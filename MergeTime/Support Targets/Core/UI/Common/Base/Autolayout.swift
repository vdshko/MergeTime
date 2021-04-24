//
//  Autolayout.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public protocol LayoutAnchor {
    
    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}

public protocol LayoutDimension: LayoutAnchor {
    
    func constraint(equalToConstant c: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualToConstant c: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualToConstant c: CGFloat) -> NSLayoutConstraint
    func constraint(equalTo anchor: Self, multiplier m: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor {}
extension NSLayoutDimension: LayoutDimension {}

public class LayoutProperty<Anchor: LayoutAnchor> {
    
    fileprivate let anchor: Anchor
    fileprivate let kind: Kind
    
    enum Kind { case leading, trailing, top, bottom, centerX, centerY, width, height }
    
    init(anchor: Anchor, kind: Kind) {
        self.anchor = anchor
        self.kind = kind
    }
}

public class LayoutAttribute<Dimension: LayoutDimension>: LayoutProperty<Dimension> {
    
    fileprivate let dimension: Dimension
    
    init(dimension: Dimension, kind: Kind) {
        self.dimension = dimension
        
        super.init(anchor: dimension, kind: kind)
    }
}

public final class LayoutProxy {
    
    public lazy var leading = LayoutProperty<NSLayoutXAxisAnchor>(anchor: view.leadingAnchor, kind: .leading)
    public lazy var trailing = LayoutProperty<NSLayoutXAxisAnchor>(anchor: view.trailingAnchor, kind: .trailing)
    public lazy var top = LayoutProperty<NSLayoutYAxisAnchor>(anchor: view.topAnchor, kind: .top)
    public lazy var bottom = LayoutProperty<NSLayoutYAxisAnchor>(anchor: view.bottomAnchor, kind: .bottom)
    public lazy var centerX = LayoutProperty<NSLayoutXAxisAnchor>(anchor: view.centerXAnchor, kind: .centerX)
    public lazy var centerY = LayoutProperty<NSLayoutYAxisAnchor>(anchor: view.centerYAnchor, kind: .centerY)
    public lazy var width = LayoutAttribute<NSLayoutDimension>(dimension: view.widthAnchor, kind: .width)
    public lazy var height = LayoutAttribute<NSLayoutDimension>(dimension: view.heightAnchor, kind: .height)
    
    private let view: UIView
    
    fileprivate init(view: UIView) {
        self.view = view
    }
}

public extension LayoutAttribute {
    
    @discardableResult
    func equal(to constant: CGFloat, priority: UILayoutPriority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = dimension.constraint(equalToConstant: constant)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = isActive
        return constraint
    }
    
    @discardableResult
    func equal(to otherDimension: Dimension, multiplier: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let constraint = dimension.constraint(equalTo: otherDimension, multiplier: multiplier)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func greaterThanOrEqual(to constant: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let constraint = dimension.constraint(greaterThanOrEqualToConstant: constant)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func lessThanOrEqual(to constant: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let constraint = dimension.constraint(lessThanOrEqualToConstant: constant)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = true
        return constraint
    }
}

public extension LayoutProperty {
    
    @discardableResult
    func equal(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = anchor.constraint(equalTo: otherAnchor, constant: constant).constraintWithMultiplier(multiplier)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = isActive
        return constraint
    }
    
    @discardableResult
    func greaterThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func lessThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = true
        return constraint
    }
}

public extension UIView {
    
    func layout(using closure: (LayoutProxy) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }
    
    func layout(in superview: UIView, with insets: UIEdgeInsets = .zero) {
        superview.addSubview(self)
        layout { proxy in
            proxy.bottom.equal(to: superview.bottomAnchor, offsetBy: -insets.bottom)
            proxy.top.equal(to: superview.topAnchor, offsetBy: insets.top)
            proxy.leading.equal(to: superview.leadingAnchor, offsetBy: insets.left)
            proxy.trailing.equal(to: superview.trailingAnchor, offsetBy: -insets.right)
        }
    }
}

//swiftlint:disable large_tuple

// MARK: - Shorthand operators

public func +<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, rhs)
}

public func -<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, -rhs)
}

@discardableResult
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) -> NSLayoutConstraint {
    return lhs.equal(to: rhs)
}

@discardableResult
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs)
}

@discardableResult
public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs)
}

@discardableResult
public func <=<D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs)
}

@discardableResult
public func ==<D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.equal(to: rhs)
}

@discardableResult
public func ==<D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: LayoutAttribute<D>) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.dimension)
}

@discardableResult
public func *=<D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: (D, CGFloat)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0, multiplier: rhs.1)
}

@discardableResult
public func *=<D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: (LayoutAttribute<D>, CGFloat)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0.dimension, multiplier: rhs.1)
}

@discardableResult
public func *=<D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: (LayoutAttribute<D>, CGFloat, UILayoutPriority)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0.dimension, multiplier: rhs.1, priority: rhs.2)
}

@discardableResult
public func >=<D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs)
}

//swiftlint:enable large_tuple

public extension UIView {
    
    private struct AssociatedKeys {
        
        static var layout = ""
    }
    
    var layout: Layout {
        get {
            var layout: Layout!
            let lookup = objc_getAssociatedObject(self, &AssociatedKeys.layout) as? Layout
            if let lookup = lookup {
                layout = lookup
            } else {
                let newLayout = Layout()
                self.layout = newLayout
                layout = newLayout
            }
            return layout
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.layout, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

public final class Layout: NSObject {
    
    public weak var top: NSLayoutConstraint?
    public weak var bottom: NSLayoutConstraint?
    public weak var leading: NSLayoutConstraint?
    public weak var trailing: NSLayoutConstraint?
    public weak var centerX: NSLayoutConstraint?
    public weak var centerY: NSLayoutConstraint?
    public weak var width: NSLayoutConstraint?
    public weak var height: NSLayoutConstraint?
    
    fileprivate func update<A: LayoutAnchor>(constraint: NSLayoutConstraint, kind: LayoutProperty<A>.Kind) {
        switch kind {
        case .top: top = constraint
        case .bottom: bottom = constraint
        case .leading: leading = constraint
        case .trailing: trailing = constraint
        case .centerX: centerX = constraint
        case .centerY: centerY = constraint
        case .width: width = constraint
        case .height: height = constraint
        }
    }
}

public extension UILayoutPriority {
    
    static let lowered = UILayoutPriority(999)
}

fileprivate extension NSLayoutConstraint {
 
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        if multiplier == 1 {
            return self
        }
        
        return NSLayoutConstraint(
            item: self.firstItem!,
            attribute: self.firstAttribute,
            relatedBy: self.relation,
            toItem: self.secondItem,
            attribute: self.secondAttribute,
            multiplier: multiplier,
            constant: self.constant
        )
    }
}
