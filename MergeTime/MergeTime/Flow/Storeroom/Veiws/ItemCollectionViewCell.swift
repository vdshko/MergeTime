//
//  ItemCollectionViewCell.swift
//  UI
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import UIKit
import class RxSwift.PublishSubject

public final class ItemCollectionViewCell: CollectionViewCell {
    
    public let moveEnded = PublishSubject<CGPoint?>()
    
    private var isDragging = false
    
    public override func setupStyling() {
        super.setupStyling()
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        contentView.backgroundColor = Asset.Colors.Specific.itemContentViewBackground.color
        contentView.layer.cornerRadius = 9
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Asset.Colors.Specific.itemContentViewBorder.color.cgColorDynamic
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        contentView.layer.borderColor = Asset.Colors.Specific.itemContentViewBorder.color.cgColorDynamic
    }
    
    public func addNewView(_ view: UIView?) {
        view?.layout(in: contentView, with: .all(10))
    }
    
    public func removeOldView() {
        contentView.subviews.last?.removeFromSuperview()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
}

// MARK: - Cell sizing

extension ItemCollectionViewCell {
    
    enum Constants {
        
        static let itemsMargin: CGFloat = 10
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
        guard !contentView.subviews.isEmpty else {
            super.touchesBegan(touches, with: event)
            
            return
        }
        
        isDragging = true
        
        // WORKAROUND: - need to use superview?.insertSubview instead of superview?.bringSubviewToFront() because of UICollectionView cells specific
        superview?.insertSubview(self, aboveSubview: superview!.subviews.last!)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging,
              let location = touches.first?.location(in: contentView) else {
            super.touchesMoved(touches, with: event)
            
            return
        }
        
        guard let view = contentView.subviews.last else {
            return
        }
        
        view.frame.origin = CGPoint(
            x: location.x - view.frame.width / 2,
            y: location.y - view.frame.height / 2
        )
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragging,
           let location = touches.first?.location(in: superview) {
            isDragging = false
            moveEnded.onNext(location)
        }
        
        super.touchesEnded(touches, with: event)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDragging {
            isDragging = false
            moveEnded.onNext(nil)
        }
        
        super.touchesCancelled(touches, with: event)
    }
}
