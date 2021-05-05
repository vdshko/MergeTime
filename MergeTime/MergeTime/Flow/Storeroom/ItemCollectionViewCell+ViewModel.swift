//
//  ItemCollectionViewCell+ViewModel.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import class UI.ItemCollectionViewCell
import struct UIKit.CGPoint

extension ItemCollectionViewCell {
    
    func setup(with model: StoreroomViewModel.Content, contentItemInteracted: PublishSubject<(item: StoreroomViewModel.Content, location: CGPoint?)>) {
        containerBackgroundView.backgroundColor = model.color
        addNewView(model.item?.view, text: model.item?.id == 12 ? "2" : "1")
        moveEnded
            .subscribe(onNext: {
                contentItemInteracted.onNext((item: model, location: $0))
            })
            .disposed(by: disposeBag)
    }
}
