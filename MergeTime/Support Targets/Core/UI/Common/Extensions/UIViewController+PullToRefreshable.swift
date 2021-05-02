//
//  UIViewController+PullToRefreshable.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

public protocol PullToRefreshable: AnyObject {}

public extension PullToRefreshable where Self: UIViewController {
    
    func setupPullToRefresh(
        with scrollView: UIScrollView,
        control: UIRefreshControl = UIRefreshControl(),
        _ action: @escaping () -> Void
    ) -> Disposable {
        control.tintColor = Asset.Colors.Text.primary.color
        scrollView.alwaysBounceVertical = true
        scrollView.assignedRefreshControl = control
        scrollView.refreshControl = control
        
        return control.rx
            .controlEvent(.valueChanged)
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in action() })
    }
    
    func endRefreshing(with scrollView: UIKit.UIScrollView?) {
        DispatchQueue.main.async {
            scrollView?.assignedRefreshControl?.endRefreshing()
        }
    }
}

private extension UIKit.UIScrollView {
    
    private struct AssociatedKeys {
        
        static var refreshControl = "assignedRefreshControl"
    }
    
    var assignedRefreshControl: UIRefreshControl? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.refreshControl) as? UIRefreshControl }
        set { objc_setAssociatedObject(self, &AssociatedKeys.refreshControl, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}
