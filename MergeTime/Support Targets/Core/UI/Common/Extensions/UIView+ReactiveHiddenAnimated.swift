//
//  UIView+ReactiveHiddenAnimated.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    
    public var isHiddenAnimated: Binder<Bool> {
        return Binder(self.base) { view, hidden in
            view.setHiddenAnimated(hidden)
        }
    }
}

extension UIView {
    
    public func setHiddenAnimated(_ hidden: Bool) {
        if isHidden == hidden {
            return
        }
        let alpha = hidden ? 0 : self.alpha
        let oldAlpha = self.alpha
        if !hidden {
            self.alpha = 0
            self.isHidden = false
        }
        UIView.animate(
            withDuration: 0.2,
            animations: { self.alpha = alpha },
            completion: { _ in
                self.isHidden = hidden
                self.alpha = oldAlpha
            }
        )
    }
}
