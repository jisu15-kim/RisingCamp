//
//  Extension+UITextField.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/06.
//

import UIKit


extension UITextField {
    func addLeftPadding(leading: Int) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leading, height: Int(self.frame.height)))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
