//
//  TableViewCell.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import class UIKit.UITableViewCell
import class RxSwift.DisposeBag

open class TableViewCell: UITableViewCell, Reusable {
    
    public internal(set) var disposeBag = DisposeBag()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupDefaultBackground()
        setupLayout()
        setupStyling()
    }
    
    @available(*, unavailable, message: "Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    required
    public init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    open func setupLayout() {}
    open func setupStyling() {}
    
    private func setupDefaultBackground() {
        backgroundColor = Asset.Colors.Background.primary.color
    }
}
