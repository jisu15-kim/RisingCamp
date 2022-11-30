//
//  CartDataManager.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/12/01.
//

import UIKit

class CartDataManager {
    
    // 싱글톤 객체 생성
    public static var shared = CartDataManager()
    
    private init() {}
    
    private var cartData: [ProductForOrder] = []
    
    public func getCartData() -> [ProductForOrder] {
        return cartData
    }
    
    public func addItemToCart(item: ProductForOrder) {
        self.cartData.append(item)
        print(cartData)
        print("추가됨")
    }
    
    // 카운트 변경
    // 아이템 삭제
    // 전체 삭제
    // 선택 삭제
}
