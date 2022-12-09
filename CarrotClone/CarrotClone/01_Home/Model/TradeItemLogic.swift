//
//  TradeItemLogic.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/05.
//

import UIKit

class TradeItemLogic {
    public static var shared = TradeItemLogic()
    private init() { }
    
    private var items: [TradeItemModel] = []
    
    // Init
    public func fetchDummyDatas() {
        let myItem = [
            TradeItemModel(title: "차량 거치대 충전기 새상품", user: User(name: UserInfo.shared.getUserName()), region: "성남시 분당구",photos:  [UIImage(named: "sample")!],category: .digital, price: "10,000원", isPriceSuggest: true, body: "미개봉 새상품 입니다"),
            TradeItemModel(title: "지나가던 행인 팝니다", user: User(name: "person"), region: "오동동",photos:  [UIImage(named: "person")!],category: .living, price: "10,000원", isPriceSuggest: true, body: "미개봉 새상품 입니다"),
            TradeItemModel(title: "아이시스 팝니다", user: User(name: "삼다수"), region: "시흥동",photos:  [UIImage(named: "icis")!],category: .living, price: "25,000원", isPriceSuggest: true, body: "몇일동안 잘 마시고 있던 아이시스 데려가세요 !"),
            TradeItemModel(title: "오래된 화분 팔아요", user: User(name: "호날두"), region: "정자동",photos:  [UIImage(named: "plant")!],category: .plants, price: "85,000원", isPriceSuggest: true, body: "미개봉 새상품 입니다"),
            TradeItemModel(title: "새상품 로션 가져가세요", user: User(name: UserInfo.shared.getUserName()), region: "이매2동",photos:  [UIImage(named: "lotion")!],category: .living, price: "15,000원", isPriceSuggest: true, body: "잘 쓰던 로션이에요 아무 좋습니다"),
            TradeItemModel(title: "기스난 모니터 팝니다", user: User(name: "장장"), region: "이매2동",photos:  [UIImage(named: "monitor")!],category: .digital, price: "5,000원", isPriceSuggest: true, body: "미개봉 새상품 입니다")
        ]
        self.items = myItem
    }
    
    // Create
    public func createItem(item: TradeItemModel) {
        self.items.insert(item, at: 0)
    }
    
    // Read
    public func readAllItem() -> [TradeItemModel] {
        return items
    }
    
    public func readSingleItem(index: Int) -> TradeItemModel {
        return items[index]
    }
    
    // Update
    public func updateItem(config: TradeItemConfig) {
        for (index, item) in items.enumerated() {
            if item.id == config.id {
                self.items[index].photos = config.photos
                self.items[index].category = config.category
                self.items[index].body = config.body
                self.items[index].title = config.title
                self.items[index].region = config.region
                self.items[index].user = config.user
                self.items[index].price = config.price
                self.items[index].isPriceSuggest = config.isPriceSuggest
                self.items[index].place = config.place
            }
        }
    }
    
    // Delete
    public func deleteItem(selectedItem: TradeItemModel) {
        for (index, item) in items.enumerated() {
            if item.id == selectedItem.id {
                self.items.remove(at: index)
            }
        }
    }
}
