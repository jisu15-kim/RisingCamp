//
//  StarbucksModel.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/28.
//

import UIKit

enum Menu {
    case drink
    case food
    case goods
}

enum Category {
    case ColdBrew
    case Espresso
    case Frappuccino
    case Blended
    case Refresher
    case Fizzio
    case Teavana
    case Error
}

struct Starbucks {
    let id: Int
    let menu: Menu
    let category: Category
    let name: String
    let englishName: String
    let desciption: String
    let price: Int
    let imageName: String
    let isBrandNew: Bool
    let isLimited: Bool
    let isRecommand: Bool
}
