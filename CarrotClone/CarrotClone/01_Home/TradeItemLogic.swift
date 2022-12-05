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
            TradeItemModel(title: "차량 거치대 충전기 새상품", user: User(name: "니크"), region: "이매2동", category: .digital, price: "10,000원", isPriceSuggest: true, body: "미개봉 새상품 입니다"),
            TradeItemModel(title: "차량 거치대 충전기 새상품", user: User(name: "니크"), region: "이매2동", category: .digital, price: "10,000원", isPriceSuggest: true, body: "미개봉 새상품 입니다"),
            TradeItemModel(title: "차량 거치대 충전기 새상품", user: User(name: "니크"), region: "이매2동", category: .digital, price: "10,000원", isPriceSuggest: true, body: "미개봉 새상품 입니다"),
            TradeItemModel(title: "차량 거치대 충전기 새상품", user: User(name: "니크"), region: "이매2동", category: .digital, price: "10,000원", isPriceSuggest: true, body: "미개봉 새상품 입니다"),
            TradeItemModel(title: "차량 거치대 충전기 새상품", user: User(name: "니크"), region: "이매2동", category: .digital, price: "10,000원", isPriceSuggest: true, body: "미개봉 새상품 입니다"),
            TradeItemModel(title: "차량 거치대 충전기 새상품", user: User(name: "니크"), region: "이매2동", category: .digital, price: "10,000원", isPriceSuggest: true, body: "미개봉 새상품 입니다"),
        ]
        self.items = myItem
    }
    
    // Create
    public func createItem(item: TradeItemModel) {
        self.items.append(item)
    }
    
    // Read
    public func readAllItem() -> [TradeItemModel] {
        return items
    }
    
    public func readSingleItem(index: Int) -> TradeItemModel {
        return items[index]
    }
    
    // Update
    public func updateItem(index: Int, item: TradeItemModel) {
        self.items[index] = item
    }
    
    // Delete
    public func deleteItem(index: Int) {
        self.items.remove(at: index)
    }
}
