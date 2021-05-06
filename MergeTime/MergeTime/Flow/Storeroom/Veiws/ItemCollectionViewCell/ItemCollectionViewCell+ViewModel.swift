//
//  ItemCollectionViewCell+ViewModel.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import class UI.ItemCollectionViewCell

extension ItemCollectionViewCell {
    
    func setup(with model: ItemCollectionViewCellModel) {
        setupStyling(isEvenNumberCell: model.isEvenNumber)
        moveStarted.bind(to: model.moveStartedObservable).disposed(by: disposeBag)
        moveEnded
            .subscribe(onNext: { location in
                model.contentItemInteracted.onNext(location)
            })
            .disposed(by: disposeBag)
        model.removeOldViewObservable.call(self, type(of: self).removeOldView).disposed(by: disposeBag)
        model.addNewViewObservable.call(self, type(of: self).addNewView).disposed(by: disposeBag)
        model.moveBackAction.call(self, type(of: self).moveViewToStartPosition).disposed(by: disposeBag)
    }
}
