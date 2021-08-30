//
//  ItemCollectionViewCell.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import UIKit

final class ItemCollectionViewCell: CollectionViewCell {
    
    let touchesBeganObservable = PublishSubject<Void>()
    let touchesMovedObservable = PublishSubject<CGPoint?>()
    let touchesEndedObservable = PublishSubject<(cellPosition: CGPoint?, itemPosition: CGPoint?)>()
    let touchesCancelledObservable = PublishSubject<Void>()
    
    private let highlightView: UIView = Factory.view()
        .background(Asset.Colors.Standard.transparent)
        .isHidden(true)
        .build()
    
    override func setupStyling() {
        super.setupStyling()
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        contentView.layer.cornerRadius = Constants.cornerRadius
    }
    
    override var bounds: CGRect {
        didSet {
            updateHighlightViewBorder()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        removeOldView()
    }
    
    func updateCell(with options: (view: UIView?, needToAnimate: Bool?)) {
        removeOldView()
        if let view = options.view {
            highlightView.layout(in: contentView, with: .all(Constants.highlightViewMargin))
            view.layout(in: contentView)
            if options.needToAnimate == true {
                view.animate(with: .reverseAnimation(.smallBounce))
            }
        }
    }
    
    func moveViewToPosition(options: (position: CGPoint?, completion: (() -> Void)?)) {
        guard let position = options.position,
              let view = contentView.subviews.last else {
            contentView.subviews.last?.animate(with: .nonReverseAnimation(.moveToPoint()))
            
            return
        }
        
        if let completion = options.completion {
            view.animate(with: .nonReverseAnimation(.moveToPoint(point: position, completion: completion)))
        } else {
            view.frame.origin = CGPoint(
                x: position.x - view.frame.width / 2,
                y: position.y - view.frame.height / 2
            )
        }
    }
    
    func removeOldView() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func updateBackground(isEvenNumberCell: Bool) {
        contentView.backgroundColor = isEvenNumberCell
            ? Asset.Colors.Specific.ItemContentViewBackground.evenNumberCell.color
            : Asset.Colors.Specific.ItemContentViewBackground.notEvenNumberCell.color
    }
    
    func bringCellToFront() {
        // WORKAROUND: - need to use superview?.insertSubview() instead of superview?.bringSubviewToFront() because of UICollectionView cells specific
        superview?.insertSubview(self, aboveSubview: superview!.subviews.last!)
    }
    
    func changeHighlightedState(highlighted: Bool) {
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
        
        static let itemsMargin: CGFloat = 5.5
        
        fileprivate static let highlightViewMargin: CGFloat = 5
        fileprivate static let cornerRadius: CGFloat = 9
    }
    
    static func designedSize(for contentSize: CGSize, itemsInLine: Int = 5) -> CGSize {
        let availableWidth = contentSize.width - CGFloat(itemsInLine - 1) * Constants.itemsMargin
        let width: CGFloat = availableWidth / CGFloat(itemsInLine)
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
}

// MARK: - Touch handling

extension ItemCollectionViewCell {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        touchesBeganObservable.onNext(())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        touchesMovedObservable.onNext(touches.first?.location(in: contentView))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        touchesEndedObservable.onNext((
            cellPosition: contentView.convert(contentView.frame.origin, to: superview),
            itemPosition: touches.first?.location(in: superview)
        ))
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
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
        highlightView.layer.addSublayer(CGLayer.highlightBorder(width: width, height: height))
    }
}
