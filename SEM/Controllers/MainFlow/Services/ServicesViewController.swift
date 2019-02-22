//
//  ServicesViewController.swift
//  SEM
//
//  Created by Ipman on 12/18/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Alamofire
class ServicesViewController: BaseViewController {
    
    var interactor: ServicesInteractor!
    var router: ServicesRouter!

    var locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D!
    var mapView: GMSMapView!
    var userMarker: GMSMarker!
    var placesClient: GMSPlacesClient!
    var circle: GMSCircle!
    var polyline = GMSPolyline()
    var zoomLevel: Float = 15.0
    
    var listEmployees = [EmployeesObject]()
    
    @IBOutlet weak var _viewBooking: BookingSubView!
    
    @IBOutlet weak var _viewMap: UIView!
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    override func awakeFromNib() {
        super.awakeFromNib()
        ServicesConfiguator.sharedInstance.configure(viewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        // Do any additional setup after loading the view.
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86,
                                              longitude: 151.20,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: _viewMap.bounds, camera: camera)
        _viewMap.addSubview(mapView)
        mapView.isHidden = true
        
        _viewBooking.layer.cornerRadius = 10.0
        _viewBooking.clipsToBounds = true
        _viewBooking._btnNext.addTarget(self, action: #selector(btnNextPressed), for: .touchUpInside)
    }
    @objc func btnNextPressed(){
        let bookingVC = UIStoryboard.storyboard(name: .Main).viewController(aClass: ServicesOrderViewController.self) as! ServicesOrderViewController
        self.navigationController?.pushViewController(bookingVC, animated: true)
    }
    func updateUser(location: CLLocationCoordinate2D){
        if userMarker != nil{
            userMarker.map = nil
            userMarker = nil
        }
        
        userMarker = GMSMarker(position: location)
        userMarker.icon = #imageLiteral(resourceName: "map_location").resizeImage(targetSize: CGSize(width: 40, height: 40))
        userMarker.map = mapView
        userMarker.appearAnimation = .pop
        
        if circle != nil{
            circle.map = nil
            circle = nil
        }
        
        circle = GMSCircle(position: location, radius: 1000)
        circle.fillColor = UIColor.init(hexString: "65adef", alpha: 0.3)!
        circle.strokeColor = UIColor.init(hexString: "65adef", alpha: 0.5)!
        circle.strokeWidth = 1.5;
        circle.map = mapView;
        
        currentLocation = location
        
//        let origin = String(location.latitude)+","+String(location.longitude)
//        let destination = String(10.755664)+","+String(106.665560)
//        self.getDirections(orgins: origin, destinations: destination)
        
        interactor.getListEmployees(lat: location.latitude, long: location.longitude, distance: 10)
    }
    
    func fetchEmployees(location: CLLocationCoordinate2D){
        let marker = GMSMarker(position: location)
        marker.icon = #imageLiteral(resourceName: "map_target").resizeImage(targetSize: CGSize(width: 40, height: 40))
        marker.map = mapView
    }
    
    func getDirections(orgins: String, destinations: String) {
        APIServices.getDirections(origins: orgins, destinations: destinations) {
            direction, error in
            if let direction = direction{
                self.drawDirectionOnMap(direction: direction)
            }
        }
    }
    
    func drawDirectionOnMap(direction: [GGDirectionsObject]) {
        let routeOverviewPolyline = direction[0].overview_polyline
        let points = routeOverviewPolyline["points"] as! String
        let path = GMSPath.init(fromEncodedPath: points)
        
        self.polyline = GMSPolyline.init(path: path)
        self.polyline.map = self.mapView
        self.polyline.strokeWidth = 3.5
        self.polyline.strokeColor = .greenMainColor
    }

}
extension ServicesViewController: ServicesPresenterOutput{
    func presentLoading(_ isLoading: Bool){
        if isLoading{
            self.showLoading()
        }else{
            self.hideLoading()
        }
    }
    func presentAlert(message: String){
        self.showAlert(withMessage: message)
    }
    func presentError(error: APIError){
        self.showAlert(withMessage: error.message)
    }
    func presentListEmployees(list: [EmployeesObject]){
        for (_, employees) in list.enumerated(){
            let position = CLLocationCoordinate2D(latitude: employees.lat,
                                                  longitude: employees.lng)
            self.fetchEmployees(location: position)
        }
    }
}
extension ServicesViewController: CLLocationManagerDelegate {
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        locationManager.stopUpdatingLocation()
        currentLocation = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
            updateUser(location: currentLocation)
        }
        
        listLikelyPlaces()
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    // Populate the array with the list of likely places.
    func listLikelyPlaces() {
        // Clean up from previous sessions.
        likelyPlaces.removeAll()
        
        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
            if let error = error {
                // TODO: Handle the error.
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            
            // Get likely places and add to the list.
            if let likelihoodList = placeLikelihoods {
                for likelihood in likelihoodList.likelihoods {
                    let place = likelihood.place
                    self.likelyPlaces.append(place)
                }
            }
        })
    }
}
