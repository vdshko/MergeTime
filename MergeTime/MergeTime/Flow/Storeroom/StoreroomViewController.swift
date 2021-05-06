//
//  StoreroomViewController.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 01.05.2021.
//

import UI
import UIKit

final class StoreroomViewController: ViewController<StoreroomView> {
    
    private let contentItemInteracted = PublishSubject<CGPoint?>()
    private let viewModel: StoreroomViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: StoreroomViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupBindings()
    }
    
    private func setupBindings() {
        rootView.itemsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.contentObservable
            .bind(to: rootView.itemsCollectionView.rx.items) { [unowned contentItemInteracted] collectionView, item, model in
                let cell: ItemCollectionViewCell = collectionView.dequeueReusableCell(IndexPath(item: item, section: 0))
                cell.setup(with: model, contentItemInteracted: contentItemInteracted, isEvenNumber: (item + 1) % 2 == 0)
                
                return cell
            }
            .disposed(by: disposeBag)
        contentItemInteracted
            .map { [weak rootView] location -> Int? in
                guard let location = location else {
                    return nil
                }
                
                return rootView?.itemsCollectionView.indexPathForItem(at: location)?.row
            }
            .bind(to: viewModel.contentItemInteracted)
            .disposed(by: disposeBag)
    }
}

extension StoreroomViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ItemCollectionViewCell.designedSize(for: collectionView.bounds.size)
    }
}
