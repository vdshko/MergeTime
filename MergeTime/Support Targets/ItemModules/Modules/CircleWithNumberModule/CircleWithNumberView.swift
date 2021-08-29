//
//  CircleWithNumberView.swift
//  ItemModules
//
//  Created by Vlad Shkodich on 08.05.2021.
//

import UIKit

final class CircleWithNumberView: NiblessView {
    
    private let label: UILabel = Factory.label()
        .textColor(Asset.Colors.Background.primary)
        .textAlignment(.center)
        .font(typography: .default)
        .build()
    private let backgroundView: UIView = Factory.view()
        .background(Asset.Colors.Standard.white, alpha: 0.7)
        .border(color: Asset.Colors.Background.primary, width: 1)
        .build()
    private let maxLebel: UILabel = Factory.label()
        .text(L10n.itemModuleMaxTitle)
        .textColor(Asset.Colors.Specific.itemMaxLevelTint)
        .textAlignment(.center)
        .font(typography: .tiny)
        .isHidden(true)
        .build()
    
    override var bounds: CGRect {
        didSet {
            backgroundView.layer.cornerRadius = (bounds.width - 2 * Constants.offset) / 2
        }
    }
    
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
        maxLebel.isHidden = !isMaxLevel
    }
    
    private func layout() {
        backgroundView.layout(in: self, with: .all(Constants.offset))
        label.layout(in: backgroundView)
        backgroundView.addSubview(maxLebel)
        maxLebel.layout {
            $0.centerY.equal(to: label.centerYAnchor, offsetBy: 14)
            $0.trailing.equal(to: backgroundView.trailingAnchor)
            $0.leading.equal(to: backgroundView.leadingAnchor)
        }
    }
}

private extension CircleWithNumberView {
    
    enum Constants {
        
        static let offset: CGFloat = 10
    }
}
