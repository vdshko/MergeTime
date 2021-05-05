//
//  ItemCollectionViewCell.swift
//  UI
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import UIKit
import class RxSwift.PublishSubject

public final class ItemCollectionViewCell: CollectionViewCell {
    
    public let containerBackgroundView: UIView = Factory.view()
        .cornerRadius(9)
        .clipsToBounds(false)
        .build()
    
    public let moveEnded = PublishSubject<CGPoint?>()
    
    private var isDragging = false
    
    public override func setupLayout() {
        super.setupLayout()
        
        containerBackgroundView.layout(in: self)
    }
    
    public override func setupStyling() {
        super.setupStyling()
        
        clipsToBounds = false
        contentView.clipsToBounds = false
    }
    
    public func addNewView(_ view: UIView?, text: String = "1") {
        guard let view = view else {
            return
        }
        
        view.layout(in: containerBackgroundView, with: .all(10))
        let label: UILabel = Factory.label()
            .text(text)
            .textColor(Asset.Colors.Background.primary)
            .textAlignment(.center)
            .font(typography: .default)
            .build()
        label.layout(in: view)
    }
    
    public func removeOldView() {
        containerBackgroundView.subviews.last?.removeFromSuperview()
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
        guard !containerBackgroundView.subviews.isEmpty else {
            super.touchesBegan(touches, with: event)
            
            return
        }
        
        isDragging = true
        
        // WORKAROUND: - need to use superview?.insertSubview instead of superview?.bringSubviewToFront() because of UICollectionView cells specific
        superview?.insertSubview(self, aboveSubview: superview!.subviews.last!)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging,
              let location = touches.first?.location(in: containerBackgroundView) else {
            super.touchesMoved(touches, with: event)
            
            return
        }
        
        guard let view = containerBackgroundView.subviews.last else {
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
