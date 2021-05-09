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
    let touchesEndedObservable = PublishSubject<(cellPosition: CGPoint?, itemPosition: CGPoint?)>()
    let touchesCancelledObservable = PublishSubject<Void>()
    let bringCellToFrontObservable = PublishSubject<Void>()
    let checkDirectionItemIndexAction = PublishSubject<(cellPosition: CGPoint, itemPosition: CGPoint)>()
    let updateCellWithOptionsObservable = BehaviorRelay<(view: UIView?, needToAnimate: Bool?)>(value: (nil, nil))
    let moveViewToPositionObservable = PublishSubject<CGPoint?>()
    let changeHighlightedState = PublishSubject<Bool>()
    let itemSelected = PublishSubject<ItemModuleProtocol>()
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
                if item?.isSelected.value == true {
                    item?.isSelected.accept(false)
                }
                
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
                itemObservable.value?.isSelected.accept(true)
                if itemObservable.value?.isDragging.value == true {
                    itemObservable.value?.isDragging.accept(false)
                }
                
                moveViewToPositionObservable?.onNext(nil)
            })
            .disposed(by: disposeBag)
        touchesEndedObservable
            .withLatestFrom(item) { ($0.cellPosition, $0.itemPosition, $1) }
            .filter { $2 != nil }
            .subscribe(onNext: { [weak checkDirectionItemIndexAction] cellPosition, itemPosition, item in
                item?.isSelected.accept(true)
                if let cellPosition = cellPosition,
                   let itemPosition = itemPosition {
                    checkDirectionItemIndexAction?.onNext((cellPosition: cellPosition, itemPosition: itemPosition))
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupItemBinding(item: ItemModuleProtocol?) {
        itemDisposeBag = DisposeBag()
        updateCellWithOptionsObservable.accept((view: item?.view, needToAnimate: item?.isMergedItem))
        
        guard let item = item else {
            return
        }
        
        if item.isMergedItem {
            item.isMergedItem = false
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
        item.isSelected
            .subscribe(onNext: { [weak changeHighlightedState, weak itemSelected] in
                changeHighlightedState?.onNext($0)
                if $0 {
                    itemSelected?.onNext(item)
                }
            })
            .disposed(by: itemDisposeBag)
    }
}
