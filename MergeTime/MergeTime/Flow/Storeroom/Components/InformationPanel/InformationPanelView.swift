//
//  InformationPanelView.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 31.08.2021.
//

import UIKit

final class InformationPanelView: NiblessView {
    
    let itemNameLabel: UILabel = Factory.label()
        .font(typography: .default)
        .textColor(Asset.Colors.Text.primary)
        .build()
    let itemDescriptionLabel: UILabel = Factory.label()
        .font(typography: .default)
        .textColor(Asset.Colors.Text.primary)
        .build()
    let infoButton: UIButton = Factory.button()
        .titleColor(Asset.Colors.Text.primary)
        .build()
    let soldButton: UIButton = Factory.button()
        .titleColor(Asset.Colors.Text.primary)
        .build()
    let accelerationButton: UIButton = Factory.button()
        .titleColor(Asset.Colors.Text.primary)
        .build()
    
    private let soldLabel: UILabel = Factory.label()
        .font(typography: .default)
        .textColor(Asset.Colors.Text.primary)
        .build()
    private let accelerationLabel: UILabel = Factory.label()
        .font(typography: .default)
        .textColor(Asset.Colors.Text.primary)
        .build()
    private let separatorView: UIView = Factory.view().build()
}
