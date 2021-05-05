//
//  StoreroomViewModel.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 01.05.2021.
//

// TBD: remove UI/UIKit imports after add items in ItemModules target

import class UIKit.UIColor
import class UIKit.UIView
import class UI.Factory

final class StoreroomViewModel {
    
    struct Content {
        
        let color: UIColor
        var item: Item?
    }
    
    struct Item {
        
        let id: Int
        var view: UIView?
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
            .withLatestFrom(content.unwrap(with: []).filter { !$0.isEmpty }) { [weak self] tuple, content -> [Content] in
                var newContent = content.map { item -> Content in
                    if item.item?.id == tuple.item.item?.id {
                        return Content(color: item.color, item: nil)
                    }
                    
                    return item
                }
                
                if let index = tuple.location {
                    if newContent[index].item?.id == 2, let view = self?.addMockView() {
                        newContent[index].item = Item(id: 12, view: view)
                    } else {
                        newContent[index].item = tuple.item.item
                    }
                }
                
                return newContent
            }
            .bind(to: content)
            .disposed(by: disposeBag)
    }
    
    private func setupMockContent() -> [Content] {
        return [
            Content(color: .blue, item: Item(id: 1, view: addMockView())), Content(color: .brown),
            Content(color: .cyan), Content(color: .darkGray),
            Content(color: .green), Content(color: .lightGray),
            Content(color: .lightText), Content(color: .magenta, item: Item(id: 2, view: addMockView())),
            Content(color: .orange), Content(color: .purple),
            Content(color: .red), Content(color: .yellow),
            
            Content(color: .blue), Content(color: .brown),
            Content(color: .cyan, item: Item(id: 3, view: addMockView())), Content(color: .darkGray),
            Content(color: .darkText), Content(color: .gray),
            Content(color: .green), Content(color: .lightGray),
            Content(color: .lightText), Content(color: .magenta),
            Content(color: .orange), Content(color: .purple),
            Content(color: .red), Content(color: .yellow, item: Item(id: 4, view: addMockView())),
            
            Content(color: .blue), Content(color: .brown),
            Content(color: .cyan), Content(color: .darkGray),
            Content(color: .darkText), Content(color: .gray),
            Content(color: .green), Content(color: .lightGray, item: Item(id: 5, view: addMockView())),
            Content(color: .lightText), Content(color: .magenta),
            Content(color: .orange), Content(color: .purple),
            Content(color: .red), Content(color: .yellow)
        ]
    }
    
    private func addMockView() -> UIView {
        return Factory.view()
            .background(Asset.Colors.Standart.white)
            .border(color: Asset.Colors.Background.primary, width: 1)
            .cornerRadius(9)
            .build()
    }
}
