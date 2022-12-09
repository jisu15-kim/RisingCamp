//
//  TradeItemModel.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/05.
//

import UIKit

enum Category: String, CaseIterable {
    case digital = "디지털기기"
    case living = "생활"
    case interior = "인테리어"
    case book = "도서"
    case clothes = "의류"
    case game = "게임"
    case usedCar = "중고차"
    case plants = "식물"
    case tickets = "티켓"
}

struct User {
    let name: String
}

struct TradeItemConfig {
    var id: Int
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

struct TradeItemModel {
    var id: Int
    var title: String
    var user: User
    var region: String
    var photos: [UIImage]?
    var category: Category
    var price: String?
    var isPriceSuggest: Bool
    var body: String
    var place: String?
    
    static var identify: Int = 0
    
    init(title: String, user: User, region: String, photos: [UIImage]? = nil, category: Category, price: String? = nil, isPriceSuggest: Bool, body: String, place: String? = nil) {

        self.id = TradeItemModel.identify
        self.title = title
        self.user = user
        self.region = region
        self.photos = photos
        self.category = category
        self.price = price
        self.isPriceSuggest = isPriceSuggest
        self.body = body
        self.place = place
        
        // 아이템 id 자동생성 !
        TradeItemModel.identify += 1
    }
}
