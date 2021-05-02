//
//  UICollectionView+Reusable.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public extension UICollectionView {
    
    final func registerReusableCell<T: UICollectionViewCell>(_ cellType: T.Type) where T: Reusable {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(_ indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = dequeueReusableCell(
                withReuseIdentifier: cellType.reuseIdentifier,
                for: indexPath
                ) as? T else {
                    fatalError(
                        "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) "
                            + "matching type \(cellType.self). "
                            + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                            + "and that you registered the cell beforehand"
                    )
            }
            
            return cell
    }
    
    final func registerReusableSupplementaryView<T: UICollectionReusableView>(elementKind: String, viewType: T.Type)
        where T: Reusable {
            register(
                viewType.self,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: viewType.reuseIdentifier
            )
    }
    
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
        (elementKind: String, indexPath: IndexPath, viewType: T.Type = T.self) -> T where T: Reusable {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: viewType.reuseIdentifier,
            for: indexPath
            ) as? T else {
                fatalError(
                    "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier)"
                        + " matching type \(viewType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the supplementary view beforehand"
                )
        }
        
        return view
    }
}
