//
//  WebViewFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit
import WebKit

public final class WebViewFactory: ViewFactory<WKWebView> {
    
    init() {
        super.init(base: WKWebView(frame: .zero, configuration: WKWebViewConfiguration()))
    }
    
    public func showsVerticalScrollIndicator(_ show: Bool) -> Self {
        base.scrollView.showsVerticalScrollIndicator = show
        
        return self
    }
    
    public func showsHorizontalScrollIndicator(_ show: Bool) -> Self {
        base.scrollView.showsHorizontalScrollIndicator = show
        
        return self
    }
    
    public func showsScrollIndicator(_ show: Bool) -> Self {
        return showsVerticalScrollIndicator(show)
            .showsHorizontalScrollIndicator(show)
    }
    
    public func bounces(_ bounces: Bool) -> Self {
        base.scrollView.bounces = bounces
        
        return self
    }
}

extension UIFactory {

   public static func webView() -> WebViewFactory {
        return WebViewFactory()
    }
}
