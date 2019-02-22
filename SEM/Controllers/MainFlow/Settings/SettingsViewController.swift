//
//  SettingsViewController.swift
//  SEM
//
//  Created by Ipman on 12/18/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import SwiftyTimer
import CocoaMQTT
class SettingsViewController: UIViewController {

    @IBOutlet weak var _img: UIImageView!
    var imgView: UIImageView!
    var timer: Timer!
    var mqtt: CocoaMQTT!
    override func viewDidLoad() {
        super.viewDidLoad()
        if imgView == nil {
            imgView = UIImageView.init(frame: _img.frame)
        }
        imgView.image = #imageLiteral(resourceName: "ImageProfile")
        
        mqtt = MQTTManager.sharedInstance.initMQTT(username: "", password: "")
        mqtt.delegate = self
        print("Update for branch dev")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mqtt.disconnect()
    }
    @IBAction func btnPressed(_ sender: Any) {
        mqtt.connect()
    }
}
extension SettingsViewController: CocoaMQTTDelegate{
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck){
        print("didConnectAck: \(ack)，rawValue: \(ack.rawValue)")
        if ack == .accept{
            mqtt.subscribe("event/12345/doorSercurity/1", qos: CocoaMQTTQOS.qos0)
        }
    }
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16){
        
    }
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16){
        
    }
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ){
        print("didReceivedMessage: \(message.string ?? "") with id \(id)")
    }
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String){
        
    }
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String){
        
    }
    func mqttDidPing(_ mqtt: CocoaMQTT){
        
    }
    func mqttDidReceivePong(_ mqtt: CocoaMQTT){
        
    }
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?){
        print("mqttDidDisconnect")
    }
    
}
