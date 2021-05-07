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
            .bind(to: rootView.itemsCollectionView.rx.items) { collectionView, item, model in
                let cell: ItemCollectionViewCell = collectionView.dequeueReusableCell(IndexPath(item: item, section: 0))
                cell.setup(with: model, isEvenNumber: (item + 1) % 2 == 0)
                
                return cell
            }
            .disposed(by: disposeBag)
        viewModel.checkDirectionItemIndexAction
            .map { [weak rootView] in
                (rootView?.itemsCollectionView.indexPathForItem(at: $0.location)?.item, $0.itemObservable)
            }
            .call(viewModel, type(of: viewModel).updateItems)
            .disposed(by: disposeBag)
        viewModel.isRootContainerEnabledObservable.bind(to: rootView.itemsCollectionView.rx.isUserInteractionEnabled).disposed(by: disposeBag)
    }
}

extension StoreroomViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ItemCollectionViewCell.designedSize(for: collectionView.bounds.size)
    }
}
