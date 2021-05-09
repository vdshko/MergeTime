//
//  ItemCollectionViewCell+ViewModel.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import class UI.ItemCollectionViewCell

extension ItemCollectionViewCell {
    
    func setup(with model: ItemCollectionViewCellModel, isEvenNumber: Bool) {
        setupStyling(isEvenNumberCell: isEvenNumber)
        model.updateCellWithOptionsObservable.call(self, type(of: self).updateCell).disposed(by: disposeBag)
        model.moveViewToPositionObservable.call(self, type(of: self).moveViewToPosition).disposed(by: disposeBag)
        model.bringCellToFrontObservable.call(self, type(of: self).bringCellToFront).disposed(by: disposeBag)
        model.changeHighlightedState.call(self, type(of: self).changeHighlightedState).disposed(by: disposeBag)
        touchesBeganObservable.bind(to: model.touchesBeganObservable).disposed(by: disposeBag)
        touchesMovedObservable.bind(to: model.touchesMovedObservable).disposed(by: disposeBag)
        touchesEndedObservable.bind(to: model.touchesEndedObservable).disposed(by: disposeBag)
        touchesCancelledObservable.bind(to: model.touchesCancelledObservable).disposed(by: disposeBag)
    }
}
