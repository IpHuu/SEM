//
//  OrderListViewController.swift
//  SEM
//
//  Created by Ipman on 1/23/19.
//  Copyright © 2019 Ipman. All rights reserved.
//

import UIKit
import Parchment
class CustomPagingView: PagingView {
    
    var menuTopConstraint: NSLayoutConstraint?
    
    override func setupConstraints() {
        pageView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        menuTopConstraint = collectionView.topAnchor.constraint(equalTo: topAnchor)
        menuTopConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: options.menuHeight),
            
            pageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageView.topAnchor.constraint(equalTo: topAnchor)
            ])
    }
}

class CustomPagingViewController: PagingViewController<PagingIndexItem> {
    
    override func loadView() {
        view = CustomPagingView(
            options: options,
            collectionView: collectionView,
            pageView: pageViewController.view
        )
    }
}
class OrderListViewController: BaseViewController {

    @IBOutlet weak var _lbHeader: UILabel!
    @IBOutlet weak var _viewContent: UIView!
    
    private let pagingViewController = CustomPagingViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        _lbHeader.font = UIFont.fontRoboto(style: .Bold, size: 20)
        
        addChildViewController(pagingViewController)
        self._viewContent.addSubview(pagingViewController.view)
        self._viewContent.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParentViewController: self)
        
        // Set our data source and delegate.
        pagingViewController.dataSource = self
        pagingViewController.menuItemSize = .fixed(width: _viewContent.frame.size.width / 3, height: pagingViewController.options.menuHeight)
        pagingViewController.indicatorColor = UIColor.yellowMainColor
        pagingViewController.selectedTextColor = UIColor.blackMainTitleColor
        pagingViewController.textColor = UIColor.grayLightTextColor
    }
    private func menuOffset(for scrollView: UIScrollView) -> CGFloat {
        return min(pagingViewController.options.menuHeight, max(0, scrollView.contentOffset.y))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func icBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension OrderListViewController: PagingViewControllerDataSource {
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
        let viewController = TableOrderListController(style: .grouped)
        viewController.delegate = self
        if index == 0 {
            viewController.status = 1
        }else if index == 1{
            viewController.status = 2
        }else if index == 2{
            viewController.status = 3
        }else{
            viewController.status = 0
        }
        
        // Inset the table view with the height of the menu height.
        let insets = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        viewController.tableView.contentInset = insets
        viewController.tableView.scrollIndicatorInsets = insets

        return viewController
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        
        if index == 0 {
            return PagingIndexItem(index: index, title: "Đã tạo") as! T
        }else if index == 1{
            return PagingIndexItem(index: index, title: "Đang giao") as! T
        }else if index == 2{
            return PagingIndexItem(index: index, title: "Đã giao") as! T
        }else{
            return PagingIndexItem(index: index, title: "Đã hủy") as! T
        }
        
    }
    
    func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int{
        return 4
    }

}
extension OrderListViewController: TableOrderListControllerDelegate{
    func didSelectedRowTable(order: OrderObject) {
        let orderDetailVC = UIStoryboard.storyboard(name: .Products).viewController(aClass: OrderDetailViewController.self) as! OrderDetailViewController
        orderDetailVC.order = order
        self.navigationController?.pushViewController(orderDetailVC, animated: true)
    }
}

