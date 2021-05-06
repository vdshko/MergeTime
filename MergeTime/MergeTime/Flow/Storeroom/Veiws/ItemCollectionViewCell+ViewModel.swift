//
//  ItemCollectionViewCell+ViewModel.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 02.05.2021.
//

import class UI.ItemCollectionViewCell
import struct UIKit.CGPoint
import protocol ItemModules.ItemModuleProtocol

extension ItemCollectionViewCell {
    
    func setup(with model: StoreroomViewModel.Content, contentItemInteracted: PublishSubject<(CGPoint?)>, isEvenNumber: Bool) {
        setupStyling(isEvenNumberCell: isEvenNumber)
        model.item
            .call(self, type(of: self).setupBinding)
            .disposed(by: disposeBag)
        moveEnded
            .subscribe(onNext: { location in
                contentItemInteracted.onNext(location)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupBinding(for item: ItemModuleProtocol?) {
        removeOldView()
        
        guard let item = item else {
            return
        }
        
        addNewView(item.view)
        item.moveBackAction.call(self, type(of: self).moveViewToStartPosition).disposed(by: itemDisposeBag)
        moveStarted
            .subscribe(onNext: {
                item.isDragging.accept(true)
            })
            .disposed(by: itemDisposeBag)
    }
}
