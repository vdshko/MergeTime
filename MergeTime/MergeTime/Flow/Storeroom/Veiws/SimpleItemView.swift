//
//  SimpleItemView.swift
//  UI
//
//  Created by Vlad Shkodich on 05.05.2021.
//

import UIKit

public final class SimpleItemView: NiblessView {

    public let label: UILabel = Factory.label()
        .textColor(Asset.Colors.Background.primary)
        .textAlignment(.center)
        .font(typography: .default)
        .build()
    
    public init(with number: Int) {
        super.init(frame: .zero)
        
        setupStyling(with: number)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if label.superview == nil {
            layout()
        }
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        layer.borderColor = Asset.Colors.Background.primary.color.cgColorDynamic
    }
    
    private func setupStyling(with number: Int) {
        backgroundColor = Asset.Colors.Standart.white.color
        layer.cornerRadius = 9
        layer.borderColor = Asset.Colors.Background.primary.color.cgColorDynamic
        layer.borderWidth = 1
        label.text = String(number)
    }
    
    private func layout() {
        label.layout(in: self)
    }
}
