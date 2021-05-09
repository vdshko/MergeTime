//
//  ItemCollectionViewCell.swift
//  UI
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import UIKit
import class RxSwift.PublishSubject

public final class ItemCollectionViewCell: CollectionViewCell {
    
    public let touchesBeganObservable = PublishSubject<Void>()
    public let touchesMovedObservable = PublishSubject<CGPoint?>()
    public let touchesEndedObservable = PublishSubject<(cellPosition: CGPoint?, itemPosition: CGPoint?)>()
    public let touchesCancelledObservable = PublishSubject<Void>()
    
    private let highlightView: UIView = Factory.view()
        .background(Asset.Colors.Standard.transparent)
        .isHidden(true)
        .build()
    
    private var isDragging = false
    
    public override func setupStyling() {
        super.setupStyling()
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        contentView.layer.cornerRadius = Constants.cornerRadius
    }
    
    public override var bounds: CGRect {
        didSet {
            updateHighlightViewBorder()
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        removeOldView()
    }
    
    public func updateCell(with options: (view: UIView?, needToAnimate: Bool?)) {
        removeOldView()
        if let view = options.view {
            highlightView.layout(in: contentView, with: .all(Constants.highlightViewMargin))
            view.layout(in: contentView)
            if options.needToAnimate == true {
                view.animate(with: .reverseAnimation(.smallBounce))
            }
        }
    }
    
    public func moveViewToPosition(_ position: CGPoint?) {
        guard let position = position,
              let view = contentView.subviews.last else {
            contentView.subviews.last?.animate(with: .nonReverseAnimation(.moveToPoint()))
            
            return
        }
        
        view.frame.origin = CGPoint(
            x: position.x - view.frame.width / 2,
            y: position.y - view.frame.height / 2
        )
    }
    
    public func removeOldView() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    public func setupStyling(isEvenNumberCell: Bool) {
            contentView.backgroundColor = isEvenNumberCell
                ? Asset.Colors.Specific.ItemContentViewBackground.evenNumberCell.color
                : Asset.Colors.Specific.ItemContentViewBackground.notEvenNumberCell.color
    }
    
    public func bringCellToFront() {
        // WORKAROUND: - need to use superview?.insertSubview() instead of superview?.bringSubviewToFront() because of UICollectionView cells specific
        superview?.insertSubview(self, aboveSubview: superview!.subviews.last!)
    }
    
    public func changeHighlightedState(highlighted: Bool) {
        highlightView.layer.removeAllAnimations()
        if highlighted {
            highlightView.isHidden = false
            highlightView.animate(with: .reverseAnimation(.autoreverseSizingWithOpacity))
        } else {
            highlightView.isHidden = true
        }
    }
}

// MARK: - Cell sizing

extension ItemCollectionViewCell {
    
    enum Constants {
        
        static let itemsMargin: CGFloat = 4
        
        fileprivate static let highlightViewMargin: CGFloat = 5
        fileprivate static let cornerRadius: CGFloat = 9
    }
    
    public static func designedSize(for contentSize: CGSize, itemsInLine: Int = 5) -> CGSize {
        let availableWidth = contentSize.width - CGFloat(itemsInLine - 1) * Constants.itemsMargin
        let width: CGFloat = availableWidth / CGFloat(itemsInLine)
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
}

// MARK: - Touch handling

extension ItemCollectionViewCell {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        touchesBeganObservable.onNext(())
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        touchesMovedObservable.onNext(touches.first?.location(in: contentView))
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        touchesEndedObservable.onNext((
            cellPosition: contentView.convert(contentView.frame.origin, to: superview),
            itemPosition: touches.first?.location(in: superview)
        ))
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        touchesCancelledObservable.onNext(())
    }
}

// MARK: - HighlightView styling

private extension ItemCollectionViewCell {
    
    func updateHighlightViewBorder() {
        // remove previously added sublayers
        highlightView.layer.sublayers?.removeAll()
        
        let width = bounds.width - Constants.highlightViewMargin * 2
        let height = bounds.height - Constants.highlightViewMargin * 2
        let margin: CGFloat = 3
        
        let cornerPath = UIBezierPath()
        
        // rightTopCorner
        cornerPath.move(to: CGPoint(x: (width - width / 4), y: 0))
        cornerPath.addLine(to: CGPoint(x: width, y: 0))
        cornerPath.addLine(to: CGPoint(x: width, y: height / 4))
        cornerPath.addLine(to: CGPoint(x: (width - margin), y: height / 4))
        cornerPath.addLine(to: CGPoint(x: (width - margin), y: margin))
        cornerPath.addLine(to: CGPoint(x: (width - width / 4), y: margin))
        cornerPath.addLine(to: CGPoint(x: (width - width / 4), y: 0))
        
        // rightBottomCorner
        cornerPath.move(to: CGPoint(x: (width - width / 4), y: height))
        cornerPath.addLine(to: CGPoint(x: width, y: height))
        cornerPath.addLine(to: CGPoint(x: width, y: (height - height / 4)))
        cornerPath.addLine(to: CGPoint(x: (width - margin), y: (height - height / 4)))
        cornerPath.addLine(to: CGPoint(x: (width - margin), y: (height - margin)))
        cornerPath.addLine(to: CGPoint(x: (width - width / 4), y: (height - margin)))
        cornerPath.addLine(to: CGPoint(x: (width - width / 4), y: height))
        
        // leftTopCorner
        cornerPath.move(to: CGPoint(x: 0, y: 0))
        cornerPath.addLine(to: CGPoint(x: 0, y: height / 4))
        cornerPath.addLine(to: CGPoint(x: margin, y: height / 4))
        cornerPath.addLine(to: CGPoint(x: margin, y: margin))
        cornerPath.addLine(to: CGPoint(x: width / 4, y: margin))
        cornerPath.addLine(to: CGPoint(x: width / 4, y: 0))
        cornerPath.addLine(to: CGPoint(x: 0, y: 0))
        
        // leftBottomCorner
        cornerPath.move(to: CGPoint(x: 0, y: height))
        cornerPath.addLine(to: CGPoint(x: width / 4, y: height))
        cornerPath.addLine(to: CGPoint(x: width / 4, y: (height - margin)))
        cornerPath.addLine(to: CGPoint(x: margin, y: (height - margin)))
        cornerPath.addLine(to: CGPoint(x: margin, y: (height - height / 4)))
        cornerPath.addLine(to: CGPoint(x: 0, y: (height - height / 4)))
        cornerPath.addLine(to: CGPoint(x: 0, y: height))
        
        let layer = CAShapeLayer()
        layer.path = cornerPath.cgPath
        layer.strokeColor = Asset.Colors.Specific.itemContentViewBorder.color.cgColor
        layer.fillColor = Asset.Colors.Specific.itemMaxLevelTint.color.cgColor
        layer.lineWidth = 0.5
        
        highlightView.layer.addSublayer(layer)
    }
}
