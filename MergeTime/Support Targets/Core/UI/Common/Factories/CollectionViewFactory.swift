//
//  CollectionViewFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public final class CollectionViewFactory<T>: ScrollViewViewFactory<T> where T: UICollectionView {
    
    public enum LayoutType {
        
        case `default`, flow
    }
    
    init(layout: UICollectionViewLayout) {
        super.init(base: T(frame: .zero, collectionViewLayout: layout))
    }
    
    // MARK: - Functions
    
    public func scrollDirection(_ direction: UICollectionView.ScrollDirection) -> Self {
        (base.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = direction
        
        return self
    }
    
    public func registerCell(_ cellTypes: CollectionViewCell.Type...) -> Self {
        cellTypes.forEach {
            base.registerReusableCell($0)
        }
        
        return self
    }
    
    public func itemSize(_ size: CGSize) -> Self {
        (base.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = size
        
        return self
    }
    
    public func sectionInset(_ insets: UIEdgeInsets) -> Self {
        (base.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset = insets
        
        return self
    }
    
    public func minimumLineSpacing(_ spacing: CGFloat) -> Self {
        (base.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = spacing
        
        return self
    }
    
    public func minimumInteritemSpacing(_ spacing: CGFloat) -> Self {
        (base.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = spacing
        
        return self
    }
}

extension UIFactory {
    
    public static func collectionView<T: UICollectionView>(with layoutType: CollectionViewFactory<T>.LayoutType = .flow) -> CollectionViewFactory<T> {
        switch layoutType {
        case .default: return CollectionViewFactory(layout: UICollectionViewLayout())
        case .flow: return CollectionViewFactory(layout: UICollectionViewFlowLayout())
        }
    }
}
