//
//  StoreroomViewModel.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 01.05.2021.
//

import protocol ItemModules.ItemModuleProtocol

// remove after finish test
import enum ItemModules.ModuleLevel

final class StoreroomViewModel {
    
    struct Content {
        
        let item: BehaviorRelay<ItemModuleProtocol?>
    }
    
    var contentObservable: Observable<[Content]> {
        return content.unwrap(with: [])
    }
    
    let contentItemInteracted = PublishSubject<Int?>()
    
    private let content = BehaviorRelay<[Content]?>(value: nil)
    private let disposeBag = DisposeBag()
    private let model: StoreroomModel
    private let itemModuleAssembly: ItemModuleAssemblyProtocol
    
    init(model: StoreroomModel, itemModuleAssembly: ItemModuleAssemblyProtocol) {
        self.model = model
        self.itemModuleAssembly = itemModuleAssembly
        content.accept(setupMockContent())
        
        setupBinding()
    }
    
    private func setupBinding() {
        contentItemInteracted.call(self, type(of: self).updateItems).disposed(by: disposeBag)
    }
    
    private func updateItems(with index: Int?) {
        guard let selectedContent = content.value?.first(where: { $0.item.value?.isDragging.value == true }) else {
            return
        }
        
        selectedContent.item.value?.isDragging.accept(false)
        
        guard let index = index,
              let directContent = content.value?[index] else {
            selectedContent.item.value?.moveBackAction.onNext(())
            
            return
        }
        
        if let directItem = directContent.item.value,
           let selectedItem = selectedContent.item.value {
            
            // handle merge with non empty direct content
            guard directItem.isEqual(to: selectedItem),
               !directItem.isSameObject(to: selectedItem),
               !directItem.isMaxLevel else {
                selectedItem.moveBackAction.onNext(())
                
                return
            }
            
            directContent.item.accept(itemModuleAssembly.nextLevel(for: selectedItem))
            selectedContent.item.accept(nil)
        } else {
            
            // handle merge with empty direct content
            directContent.item.accept(selectedContent.item.value)
            selectedContent.item.accept(nil)
        }
    }
}

// MARK: - Mock content
// remove after finish test

extension StoreroomViewModel {

    private func setupMockContent() -> [Content] {
        return [
            addMock(level: .eight), addMock(level: .eight), addMock(), addMock(level: .three), addMock(),
            addMock(), addMock(), addMock(), addMock(), addMock(),
            addMock(level: .four), addMock(), addMock(), addMock(), addMock(),
            addMock(), addMock(), addMock(), addMock(), addMock(),
            addMock(), addMock(), addMock(), addMock(), addMock(),
            addMock(), addMock(), addMock(level: .five), addMock(level: .six), addMock(),
            addMock(), addMock(), addMock(), addMock(), addMock(isNil: true)
        ]
    }
    
    private func addMock(isNil: Bool = false, level: ModuleLevel = .one) -> Content {
        return Content(item: BehaviorRelay<ItemModuleProtocol?>(value: isNil ? nil : itemModuleAssembly.module(type: .squareWithNumber, level: level)))
    }
}
