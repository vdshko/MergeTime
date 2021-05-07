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
    let checkDirectionItemIndexAction = PublishSubject<(cellPosition: CGPoint, itemPosition: CGPoint)>()
    
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
    
    func updateItems(indexes: (selectedItemIndex: Int?, directionItemIndex: Int?)) {
        guard let selectedIndex = indexes.selectedItemIndex,
              let selectedItemModel = content.value?[selectedIndex] else {
            return
        }
        
        selectedItemModel.item.value?.isDragging.accept(false)

        guard let directionIndex = indexes.directionItemIndex,
              let directItemModel = content.value?[directionIndex] else {
            selectedItemModel.item.value?.moveBackAction.onNext(())

            return
        }

        if let directItem = directItemModel.item.value,
           let selectedItem = selectedItemModel.item.value {

            // handle merge with non empty direct content
            guard directItem.isEqual(to: selectedItem),
               !directItem.isSameObject(to: selectedItem),
               !directItem.isMaxLevel else {

                selectedItem.moveBackAction.onNext(())

                return
            }

            directItemModel.item.accept(itemModuleAssembly.nextLevel(for: selectedItem))
            selectedItemModel.item.accept(nil)
        } else {

            // handle merge with empty direct content
            directItemModel.item.accept(selectedItemModel.item.value)
            selectedItemModel.item.accept(nil)
        }
    }
}

// MARK: - Mock content
// remove after finish test

extension StoreroomViewModel {

    private func setupMockContent() -> [ItemCollectionViewCellModel] {
        return [
            addMock(level: .eight), addMock(level: .eight), addMock(), addMock(level: .three), addMock(),
            addMock(), addMock(level: .one, moduleType: .circleWithNumber), addMock(), addMock(isNil: true), addMock(),
            addMock(level: .four, moduleType: .circleWithNumber), addMock(), addMock(level: .one, moduleType: .circleWithNumber), addMock(), addMock(),
            addMock(level: .one, moduleType: .circleWithNumber), addMock(), addMock(), addMock(level: .one, moduleType: .circleWithNumber), addMock(),
            addMock(), addMock(), addMock(level: .three, moduleType: .circleWithNumber), addMock(), addMock(level: .one, moduleType: .circleWithNumber),
            addMock(level: .one, moduleType: .circleWithNumber), addMock(isNil: false, level: .five), addMock(), addMock(isNil: false, level: .six), addMock(),
            addMock(), addMock(), addMock(isNil: true), addMock(), addMock()
        ]
    }
    
    private func addMock(isNil: Bool = false, level: ModuleLevel = .one, moduleType: ModuleType = .squareWithNumber) -> ItemCollectionViewCellModel {
        let model = ItemCollectionViewCellModel(
            item: isNil ? nil : itemModuleAssembly.module(type: moduleType, level: level),
            isRootContainerEnabledObservable: isRootContainerEnabled
        )
        model.checkDirectionItemIndexAction.bind(to: checkDirectionItemIndexAction).disposed(by: model.disposeBag)
        
        return model
    }
}
