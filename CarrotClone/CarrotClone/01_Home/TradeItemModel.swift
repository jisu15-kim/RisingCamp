//
//  TradeItemModel.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/05.
//

import UIKit

enum Category: String {
    case digital = "디지털기기"
    case living
    case interior
    case book
    case clothes
    case game
    case usedCar
    case plants
    case tickets
}

struct User {
    let name: String
}

struct TradeItemModel {
    var title: String
    var user: User
    var region: String
    var photos: [UIImage]?
    var category: Category
    var price: String?
    var isPriceSuggest: Bool
    var body: String
    var place: String?
}
