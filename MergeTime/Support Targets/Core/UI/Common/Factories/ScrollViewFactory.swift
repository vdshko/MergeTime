//
//  ScrollViewViewFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public class ScrollViewViewFactory<T: UIScrollView>: ViewFactory<T> {
    
    public func showsVerticalScrollIndicator(_ show: Bool) -> Self {
        base.showsVerticalScrollIndicator = show
        
        return self
    }
    
    public func showsHorizontalScrollIndicator(_ show: Bool) -> Self {
        base.showsHorizontalScrollIndicator = show
        
        return self
    }
    
    public func showsScrollIndicator(_ show: Bool) -> Self {
        return showsVerticalScrollIndicator(show)
            .showsHorizontalScrollIndicator(show)
    }
    
    public func isPagingEnabled(_ isPagingEnabled: Bool) -> Self {
        base.isPagingEnabled = isPagingEnabled
        
        return self
    }
    
    public func isScrollEnabled(_ isScrollEnabled: Bool) -> Self {
        base.isScrollEnabled = isScrollEnabled
        
        return self
    }
    
    public func bounces(_ bounces: Bool) -> Self {
        base.bounces = bounces
        
        return self
    }
}

extension UIFactory {

    public static func scrollView<T: UIScrollView>() -> ScrollViewViewFactory<T> {
        return ScrollViewViewFactory<T>(base: T())
    }
}
