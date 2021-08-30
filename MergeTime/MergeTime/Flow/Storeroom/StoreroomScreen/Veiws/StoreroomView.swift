//
//  StoreroomView.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 01.05.2021.
//

import UIKit

public final class StoreroomView: NiblessView {
    
    public let itemsCollectionView: UICollectionView = Factory.collectionView()
        .registerCell(ItemCollectionViewCell.self)
        .minimumInteritemSpacing(ItemCollectionViewCell.Constants.itemsMargin)
        .minimumLineSpacing(ItemCollectionViewCell.Constants.itemsMargin)
        .isScrollEnabled(false)
        .background(Asset.Colors.Standard.transparent)
        .build()
    
    public init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if itemsCollectionView.superview == nil {
            layout()
            removeCollectionViewScrollIndicators()
        }
    }
}

// MARK: - Internals

extension StoreroomView {
    
    private func layout() {
        addSubview(itemsCollectionView)
        
        itemsCollectionView.layout {
            $0.leading.equal(to: safeAreaLayoutGuide.leadingAnchor, offsetBy: ItemCollectionViewCell.Constants.itemsMargin)
            $0.trailing.equal(to: safeAreaLayoutGuide.trailingAnchor, offsetBy: -ItemCollectionViewCell.Constants.itemsMargin)
            $0.top.equal(to: safeAreaLayoutGuide.topAnchor, offsetBy: ItemCollectionViewCell.Constants.itemsMargin)
            $0.bottom.equal(to: safeAreaLayoutGuide.bottomAnchor, offsetBy: -ItemCollectionViewCell.Constants.itemsMargin)
        }
    }
    
    private func removeCollectionViewScrollIndicators() {
        itemsCollectionView.subviews.last?.removeFromSuperview()
        itemsCollectionView.subviews.last?.removeFromSuperview()
    }
}
