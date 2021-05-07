//
//  StoreroomViewModel.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 01.05.2021.
//

import protocol ItemModules.ItemModuleProtocol
import struct UIKit.CGPoint

// remove after finish test
import enum ItemModules.ModuleLevel

final class StoreroomViewModel {
    
    var contentObservable: Observable<[ItemCollectionViewCellModel]> {
        return content.unwrap(with: [])
    }
    var isRootContainerEnabledObservable: Observable<Bool> {
        return isRootContainerEnabled.distinctUntilChanged().skip(1)
    }
    let checkDirectionItemIndexAction = PublishSubject<(location: CGPoint, itemObservable: BehaviorRelay<ItemModuleProtocol?>)>()
    
    let isRootContainerEnabled = BehaviorRelay<Bool>(value: false)
    
    private let content = BehaviorRelay<[ItemCollectionViewCellModel]?>(value: nil)
    private let disposeBag = DisposeBag()
    private let model: StoreroomModel
    private let itemModuleAssembly: ItemModuleAssemblyProtocol
    
    init(model: StoreroomModel, itemModuleAssembly: ItemModuleAssemblyProtocol) {
        self.model = model
        self.itemModuleAssembly = itemModuleAssembly
        content.accept(setupMockContent())
    }
    
    func updateItems(options: (directionItemIndex: Int?, selectedItemObservable: BehaviorRelay<ItemModuleProtocol?>)) {
        options.selectedItemObservable.value?.isDragging.accept(false)

        guard let index = options.directionItemIndex,
              let directItemModel = content.value?[index] else {
            options.selectedItemObservable.value?.moveBackAction.onNext(())

            return
        }

        if let directItem = directItemModel.item.value,
           let selectedItem = options.selectedItemObservable.value {

            // handle merge with non empty direct content
            guard directItem.isEqual(to: selectedItem),
               !directItem.isSameObject(to: selectedItem),
               !directItem.isMaxLevel else {

                selectedItem.moveBackAction.onNext(())

                return
            }

            directItemModel.item.accept(itemModuleAssembly.nextLevel(for: selectedItem))
            options.selectedItemObservable.accept(nil)
        } else {

            // handle merge with empty direct content
            directItemModel.item.accept(options.selectedItemObservable.value)
            options.selectedItemObservable.accept(nil)
        }
    }
}

// MARK: - Mock content
// remove after finish test

extension StoreroomViewModel {

    private func setupMockContent() -> [ItemCollectionViewCellModel] {
        return [
            addMock(level: .eight), addMock(level: .eight), addMock(), addMock(level: .three), addMock(),
            addMock(), addMock(), addMock(), addMock(isNil: true), addMock(),
            addMock(level: .four), addMock(), addMock(), addMock(), addMock(),
            addMock(), addMock(), addMock(), addMock(), addMock(),
            addMock(), addMock(), addMock(), addMock(), addMock(),
            addMock(), addMock(isNil: false, level: .five), addMock(), addMock(isNil: false, level: .six), addMock(),
            addMock(), addMock(), addMock(isNil: true), addMock(), addMock()
        ]
    }
    
    private func addMock(isNil: Bool = false, level: ModuleLevel = .one) -> ItemCollectionViewCellModel {
        let model = ItemCollectionViewCellModel(
            item: isNil ? nil : itemModuleAssembly.module(type: .squareWithNumber, level: level),
            isRootContainerEnabledObservable: isRootContainerEnabled
        )
        model.checkDirectionItemIndexAction.bind(to: checkDirectionItemIndexAction).disposed(by: model.disposeBag)
        
        return model
    }
}
