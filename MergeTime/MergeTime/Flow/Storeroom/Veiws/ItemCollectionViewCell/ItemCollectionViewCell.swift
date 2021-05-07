//
//  ItemCollectionViewCell.swift
//  UI
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import UIKit
import class RxSwift.PublishSubject
import class RxSwift.DisposeBag

public final class ItemCollectionViewCell: CollectionViewCell {
    
    public let moveStarted = PublishSubject<Void>()
    public let moveEnded = PublishSubject<CGPoint?>()
    
    public let touchesBeganObservable = PublishSubject<Void>()
    public let touchesMovedObservable = PublishSubject<CGPoint?>()
    public let touchesEndedObservable = PublishSubject<(cellPosition: CGPoint?, itemPosition: CGPoint?)>()
    public let touchesCancelledObservable = PublishSubject<Void>()
    
    private var isDragging = false
    
    public override func setupStyling() {
        super.setupStyling()
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        contentView.layer.cornerRadius = 9
//        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = Asset.Colors.Specific.itemContentViewBorder.color.cgColorDynamic
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

//        contentView.layer.borderColor = Asset.Colors.Specific.itemContentViewBorder.color.cgColorDynamic
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        removeOldView()
    }
    
    public func updateCell(with view: UIView?) {
        removeOldView()
        view?.layout(in: contentView)
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
}

// MARK: - Cell sizing

extension ItemCollectionViewCell {
    
    enum Constants {
        
        static let itemsMargin: CGFloat = 4
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
