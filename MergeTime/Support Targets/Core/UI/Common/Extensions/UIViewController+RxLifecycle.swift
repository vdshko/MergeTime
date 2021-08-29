//
//  UIViewController+RxLifecycle.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

/// converts UIViewController's lifecycle methods to reactive streams
public extension Reactive where Base: UIViewController {
    
    var viewDidLoad: Observable<Void> {
        return sentMessage(#selector(Base.viewDidLoad)).map { _ in Void() }
    }
    
    var viewDidAppear: Observable<Void> {
        return sentMessage(#selector(Base.viewDidAppear(_:))).map { _ in Void() }
    }
    
    var viewDidDisappear: Observable<Void> {
        return sentMessage(#selector(Base.viewDidDisappear(_:))).map { _ in Void() }
    }
    
    var viewWillAppear: Observable<Void> {
        return sentMessage(#selector(Base.viewWillAppear(_:))).map { _ in Void() }
    }
    
    var viewWillDisappear: Observable<Void> {
        return sentMessage(#selector(Base.viewWillDisappear(_:))).map { _ in Void() }
    }
}
