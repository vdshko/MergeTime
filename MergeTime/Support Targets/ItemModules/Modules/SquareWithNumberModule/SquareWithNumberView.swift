//
//  SquareWithNumberView.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 05.05.2021.
//

import UIKit

final class SquareWithNumberView: NiblessView {

    private let label: UILabel = Factory.label()
        .textColor(Asset.Colors.Background.primary)
        .textAlignment(.center)
        .font(typography: .default)
        .build()
    private let backgroundView: UIView = Factory.view()
        .background(Asset.Colors.Standard.white)
        .cornerRadius(9)
        .border(color: Asset.Colors.Background.primary, width: 1)
        .build()
    private let maxLabel: UILabel = Factory.label()
        .text(L10n.itemModuleMaxTitle)
        .textColor(Asset.Colors.Specific.itemMaxLevelTint)
        .textAlignment(.center)
        .font(typography: .tiny)
        .isHidden(true)
        .build()
    
    init(with number: Int, isMaxLevel: Bool) {
        super.init(frame: .zero)
        
        setupStyling(with: number, isMaxLevel: isMaxLevel)
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
    
    private func setupStyling(with number: Int, isMaxLevel: Bool) {
        backgroundColor = Asset.Colors.Standard.transparent.color
        label.text = String(number)
        maxLabel.isHidden = !isMaxLevel
    }
    
    private func layout() {
        backgroundView.layout(in: self, with: .all(Constants.offset))
        label.layout(in: backgroundView)
        backgroundView.addSubview(maxLabel)
        maxLabel.layout {
            $0.centerY.equal(to: label.centerYAnchor, offsetBy: 14)
            $0.trailing.equal(to: backgroundView.trailingAnchor)
            $0.leading.equal(to: backgroundView.leadingAnchor)
        }
    }
}

private extension SquareWithNumberView {
    
    enum Constants {
        
        static let offset: CGFloat = 10
    }
}
