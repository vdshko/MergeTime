//
//  SquareWithNumberView.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 05.05.2021.
//

import UIKit

final class SquareWithNumberView: NiblessView {

    let label: UILabel = Factory.label()
        .textColor(Asset.Colors.Background.primary)
        .textAlignment(.center)
        .font(typography: .default)
        .build()
    
    private let backgroundView: UIView = Factory.view()
        .background(Asset.Colors.Standard.white)
        .cornerRadius(9)
        .border(color: Asset.Colors.Background.primary, width: 1)
        .build()
    
    init(with number: Int) {
        super.init(frame: .zero)
        
        setupStyling(with: number)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if label.superview == nil {
            layout()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        backgroundView.layer.borderColor = Asset.Colors.Background.primary.color.cgColorDynamic
    }
    
    private func setupStyling(with number: Int) {
        backgroundColor = Asset.Colors.Standard.transparent.color
        label.text = String(number)
    }
    
    private func layout() {
        backgroundView.layout(in: self, with: .all(10))
        label.layout(in: backgroundView)
    }
}
