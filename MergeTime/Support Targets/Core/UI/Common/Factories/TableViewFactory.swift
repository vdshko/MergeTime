//
//  TableViewFactory.swift
//  Core
//
//  Created by Vlad Shkodich on 24.04.2021.
//

import UIKit

public final class TableViewFactory: ScrollViewViewFactory<UITableView> {
    
    public func footerView(_ view: UIView) -> TableViewFactory {
        base.tableFooterView = view
        
        return self
    }
    
    public func separatorInset(_ insets: UIEdgeInsets) -> TableViewFactory {
        base.separatorInset = insets
        
        return self
    }
    
    public func separatorColor(_ color: ColorAsset) -> TableViewFactory {
        base.separatorColor = color.color
        
        return self
    }
    
    public func separatorStyle(_ style: UITableViewCell.SeparatorStyle) -> TableViewFactory {
        base.separatorStyle = style
        
        return self
    }
    
    public func rowHeight(_ height: CGFloat) -> TableViewFactory {
        base.rowHeight = height
        
        return self
    }
    
    public func estimatedRowHeight(_ height: CGFloat) -> TableViewFactory {
        base.estimatedRowHeight = height
        
        return self
    }
    
    public func registerCell(_ cellTypes: TableViewCell.Type...) -> Self {
        cellTypes.forEach {
            base.registerReusableCell($0)
        }
        
        return self
    }
}

extension UIFactory {

    public static func tableView() -> TableViewFactory {
        return TableViewFactory()
    }
}
