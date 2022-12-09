//
//  CategoryPickDelegate.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/08.
//

import Foundation

protocol CategoryPickDelegate: AnyObject {
    func categoryPicked(selected: Category)
}
