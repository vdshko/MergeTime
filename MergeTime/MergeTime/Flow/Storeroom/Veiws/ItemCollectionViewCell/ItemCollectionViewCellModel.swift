//
//  ItemCollectionViewCellModel.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 06.05.2021.
//

import struct UIKit.CGPoint
import class UIKit.UIView
import protocol ItemModules.ItemModuleProtocol

final class ItemCollectionViewCellModel {
    
    var itemDisposeBag = DisposeBag()
    
    let removeOldViewObservable = PublishSubject<Void>()
    let addNewViewObservable = BehaviorRelay<UIView?>(value: nil)
    let moveStartedObservable = PublishSubject<Void>()
    let moveBackAction = PublishSubject<Void>()
    
    let disposeBag = DisposeBag()
    let itemObservable: BehaviorRelay<ItemModuleProtocol?>
    let contentItemInteracted: PublishSubject<(CGPoint?)>
    let isEvenNumber: Bool
    
    init(with model: StoreroomViewModel.Content, contentItemInteracted: PublishSubject<(CGPoint?)>, isEvenNumber: Bool) {
        itemObservable = model.item
        self.contentItemInteracted = contentItemInteracted
        self.isEvenNumber = isEvenNumber
        
        setupBinding()
    }
    
    private func setupBinding() {
        itemObservable.call(self, type(of: self).setupItemBinding).disposed(by: disposeBag)
    }
    
    private func setupItemBinding(item: ItemModuleProtocol?) {
        itemDisposeBag = DisposeBag()
        removeOldViewObservable.onNext(())
        
        guard let item = item else {
            return
        }
        
        addNewViewObservable.accept(item.view)
        item.moveBackAction
            .subscribe(onNext: { [weak moveBackAction] in
                moveBackAction?.onNext(())
            })
            .disposed(by: itemDisposeBag)
        moveStartedObservable
            .subscribe(onNext: {
                item.isDragging.accept(true)
            })
            .disposed(by: itemDisposeBag)
    }
}
