//
//  UIBarButtonItem.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/09.
//

import UIKit

extension UIBarButtonItem {
    static func generate(config: CustomNaviBarItemConfig, width: CGFloat? = nil) -> UIBarButtonItem {
        
        let customView = CustomNaviBarItem(config: config)
        
        if let safeWidth = width {
            customView.widthAnchor.constraint(equalToConstant: safeWidth).isActive = true
        }
        let customBarButtonItem = UIBarButtonItem(customView: customView)
        return customBarButtonItem
    }
}
