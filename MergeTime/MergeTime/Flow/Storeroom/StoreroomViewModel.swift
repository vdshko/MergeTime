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
    let currentSelectedItem = BehaviorRelay<ItemModuleProtocol?>(value: nil)
    
    private let content = BehaviorRelay<[ItemCollectionViewCellModel]?>(value: nil)
    private let disposeBag = DisposeBag()
    private let model: StoreroomModel
    private let itemModuleAssembly: ItemModuleAssemblyProtocol
    
    init(model: StoreroomModel, itemModuleAssembly: ItemModuleAssemblyProtocol) {
        self.model = model
        self.itemModuleAssembly = itemModuleAssembly
        content.accept(setupMockContent())
        setupBinding()
    }
    
    func updateItems(with draggingOptions: DraggingOptions) {
        guard let selectedIndex = draggingOptions.selectedItemIndex,
              let selectedItemModel = content.value?[selectedIndex] else {
            return
        }

        guard let directionIndex = draggingOptions.directionItemIndex,
              let directItemModel = content.value?[directionIndex] else {
            selectedItemModel.item.value?.moveBackAction.onNext(())
            selectedItemModel.item.value?.isDragging.accept(false)

            return
        }

        if let directItem = directItemModel.item.value,
           let selectedItem = selectedItemModel.item.value {
            selectedItem.isDragging.accept(false)
            
            // handle merge with non empty direct content
            guard directItem.isEqual(to: selectedItem),
               !directItem.isSameObject(to: selectedItem),
               !directItem.isMaxLevel else {

                selectedItem.moveBackAction.onNext(())

                return
            }

            // new item need to be mark as selected and merged
            let nextLevelItem = itemModuleAssembly.nextLevel(for: selectedItem)
            nextLevelItem?.isSelected.accept(true)
            nextLevelItem?.isMergedItem = true
            
            directItemModel.item.accept(nextLevelItem)
            selectedItemModel.item.accept(nil)
        } else {

            // handle merge with empty direct content
            selectedItemModel.item.value?.isSelected.accept(false)
            selectedItemModel.item.value?.moveToDirectPositionAction.onNext(
                (
                    position: draggingOptions.directPosition ?? .zero,
                    completion: {
                        selectedItemModel.item.value?.isDragging.accept(false)
                        directItemModel.item.accept(selectedItemModel.item.value)
                        selectedItemModel.item.accept(nil)
                        
                        // moved item need to be mark as selected after dragging
                        directItemModel.item.value?.isSelected.accept(true)
                    }
                )
            )
        }
    }
    
    private func setupBinding() {
        // if root container enabled parameter is equal to false then need remove any selections state for any items
        isRootContainerEnabled
            .filter { !$0 }
            .subscribe(onNext: { [weak currentSelectedItem] _ in
                currentSelectedItem?.value?.isSelected.accept(false)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Mock content
// remove after finish test

extension StoreroomViewModel {

    private func setupMockContent() -> [ItemCollectionViewCellModel] {
        return [
            addMock(isNil: true), addMock(level: .eight), addMock(), addMock(level: .three), addMock(),
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
        model.itemSelected
            .subscribe(onNext: { [weak currentSelectedItem] newSelectedItem in
                guard let value = currentSelectedItem?.value else {
                    currentSelectedItem?.accept(newSelectedItem)
                    
                    return
                }
                
                if !value.isSameObject(to: newSelectedItem) {
                    currentSelectedItem?.value?.isSelected.accept(false)
                    currentSelectedItem?.accept(newSelectedItem)
                }
            })
            .disposed(by: model.disposeBag)
        
        return model
    }
}
