//
//  CollectionViewCell.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit
import RxSwift

open class CollectionViewCell: UICollectionViewCell, Reusable {
    
    public internal(set) var disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDefaultBackground()
        setupLayout()
        setupStyling()
    }
    
    @available(*, unavailable, message: "Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    required
    public init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    open func setupLayout() {}
    open func setupStyling() {}
    
    private func setupDefaultBackground() {
        backgroundColor = Asset.Colors.Background.primary.color
    }
}
