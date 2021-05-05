//
//  StoreroomViewModel.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 01.05.2021.
//

// TBD: remove UI/UIKit imports after add items in ItemModules target

import class UIKit.UIColor
import class UIKit.UIView
import class UI.SimpleItemView

final class StoreroomViewModel {
    
    struct Content {
        
        var item: Item?
    }
    
    var contentObservable: Observable<[Content]> {
        return content.unwrap(with: [])
    }
    
    let contentItemInteracted = PublishSubject<(item: Content, location: Int?)>()
    
    private let content = BehaviorRelay<[Content]?>(value: nil)
    private let disposeBag = DisposeBag()
    private let model: StoreroomModel
    
    init(model: StoreroomModel) {
        self.model = model
        content.accept(setupMockContent())
        
        setupBinding()
    }
    
    private func setupBinding() {
        contentItemInteracted
            .filter { $0.location != nil }
            .withLatestFrom(content.unwrap(with: []).filter { !$0.isEmpty }) { tuple, content -> [Content] in
                var newContent = content.map { content -> Content in
                    if content.item === tuple.item.item {
                        return Content()
                    }
                    
                    return content
                }
                
                if let index = tuple.location {
                    if newContent[index].item?.moduleType == tuple.item.item?.moduleType,
                       let moduleType = tuple.item.item?.moduleType.getNextLevel {
                        newContent[index].item = Item(moduleType: moduleType)
                    } else {
                        newContent[index].item = tuple.item.item
                    }
                }
                
                return newContent
            }
            .bind(to: content)
            .disposed(by: disposeBag)
    }
}

// MARK: - Mock content

extension StoreroomViewModel {
    
    class Item: Equatable {
        
        var view: UIView?
        
        let moduleType: ModuleType
        
        init(moduleType: ModuleType = .viewWithNumber(.one)) {
            self.view = SimpleItemView(with: moduleType.level)
            self.moduleType = moduleType
        }
        
        static func == (lhs: StoreroomViewModel.Item, rhs: StoreroomViewModel.Item) -> Bool {
            return lhs.moduleType == rhs.moduleType
        }
    }
    
    private func setupMockContent() -> [Content] {
        return [
            Content(item: Item()), Content(item: Item()), Content(item: Item()), Content(item: Item()), Content(item: Item()),
            Content(item: Item()), Content(item: Item()), Content(item: Item()), Content(item: Item()), Content(item: Item()),
            Content(item: Item()), Content(item: Item()), Content(item: Item()), Content(item: Item()), Content(item: Item()),
            Content(item: Item()), Content(item: Item()), Content(item: Item()), Content(item: Item()), Content(item: Item()),
            Content(item: Item()), Content(item: Item()), Content(item: Item()), Content(item: Item()), Content(item: Item()),
            Content(item: Item()), Content(item: Item()), Content(item: Item()), Content(item: Item()), Content(item: Item())
        ]
    }
}
