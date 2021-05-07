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
    
    let touchesBeganObservable = PublishSubject<Void>()
    let touchesMovedObservable = PublishSubject<CGPoint?>()
    let touchesEndedObservable = PublishSubject<CGPoint?>()
    let touchesCancelledObservable = PublishSubject<Void>()
    let bringCellToFrontObservable = PublishSubject<Void>()
    let checkDirectionItemIndexAction = PublishSubject<(location: CGPoint, itemObservable: BehaviorRelay<ItemModuleProtocol?>)>()
    let updateCellWithViewObservable = BehaviorRelay<UIView?>(value: nil)
    let moveViewToPositionObservable = PublishSubject<CGPoint?>()
    let item: BehaviorRelay<ItemModuleProtocol?>
    let disposeBag = DisposeBag()
    
    private var itemDisposeBag = DisposeBag()
    private var isDragging: Bool = false
    
    private let isRootContainerEnabledObservable: BehaviorRelay<Bool>
    
    init(item: ItemModuleProtocol?, isRootContainerEnabledObservable: BehaviorRelay<Bool>) {
        self.item = BehaviorRelay(value: item)
        self.isRootContainerEnabledObservable = isRootContainerEnabledObservable
        
        setupBinding()
    }
    
    private func setupBinding() {
        item.call(self, type(of: self).setupItemBinding).disposed(by: disposeBag)
        touchesBeganObservable
            .filter { [weak item] in item?.value != nil }
            .map { false }
            .bind(to: isRootContainerEnabledObservable)
            .disposed(by: disposeBag)
        touchesMovedObservable
            .compactMap { $0 }
            .withLatestFrom(item) { ($0, $1) }
            .filter { $0.1 != nil }
            .subscribe(onNext: { [weak moveViewToPositionObservable, weak bringCellToFrontObservable] position, item in
                if item?.isDragging.value == false {
                    item?.isDragging.accept(true)
                    bringCellToFrontObservable?.onNext(())
                }
                
                moveViewToPositionObservable?.onNext(position)
            })
            .disposed(by: disposeBag)
        touchesCancelledObservable
            .withLatestFrom(Observable.just(item))
            .filter { $0.value != nil }
            .subscribe(onNext: { [weak moveViewToPositionObservable] itemObservable in
                if itemObservable.value?.isDragging.value == true {
                    itemObservable.value?.isDragging.accept(false)
                }
                
                moveViewToPositionObservable?.onNext(nil)
            })
            .disposed(by: disposeBag)
        touchesEndedObservable
            .withLatestFrom(Observable.just(item)) { ($0, $1) }
            .filter { $0.1.value != nil }
            .subscribe(onNext: { [weak checkDirectionItemIndexAction] position, itemObservable in
                if let position = position,
                   itemObservable.value != nil {
                    checkDirectionItemIndexAction?.onNext((location: position, itemObservable: itemObservable))
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupItemBinding(item: ItemModuleProtocol?) {
        itemDisposeBag = DisposeBag()
        updateCellWithViewObservable.accept(item?.view)
        
        guard let item = item else {
            return
        }
        
        item.moveBackAction
            .subscribe(onNext: { [weak moveViewToPositionObservable] in
                moveViewToPositionObservable?.onNext(nil)
            })
            .disposed(by: itemDisposeBag)
        item.isDragging
            .subscribe(onNext: { [weak isRootContainerEnabledObservable] isDragging in
                isRootContainerEnabledObservable?.accept(!isDragging)
            })
            .disposed(by: itemDisposeBag)
    }
}
