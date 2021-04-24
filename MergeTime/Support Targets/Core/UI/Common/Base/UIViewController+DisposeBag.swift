//
//  UIViewController+DisposeBag.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import RxSwift

extension UIViewController {
    
    private struct AssociatedKeys {
        
        static var DisposeBag = "disposeBag"
    }
    
    private func doLocked(_ closure: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        closure()
    }
    
    var dynamicDisposeBag: DisposeBag {
        get {
            var disposeBag: DisposeBag!
            doLocked {
                let lookup = objc_getAssociatedObject(self, &AssociatedKeys.DisposeBag) as? DisposeBag
                if let lookup = lookup {
                    disposeBag = lookup
                } else {
                    let newDisposeBag = DisposeBag()
                    disposeBag = newDisposeBag
                }
            }
            return disposeBag
        }
        
        set {
            doLocked {
                objc_setAssociatedObject(self, &AssociatedKeys.DisposeBag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
