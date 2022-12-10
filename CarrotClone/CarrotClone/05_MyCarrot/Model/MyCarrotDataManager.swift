//
//  MyCarrotDataManager.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/10.
//

import UIKit

class MyCarrotDataManager {
    
    var datas: [MyCarrotListModel] = []
    
    static public var shared = MyCarrotDataManager()
    
    private init() {}
    
    func fetchData() {
        var data = [
            MyCarrotListModel(title: "내 동네 설정", image: UIImage(systemName: "location.north.circle")!, section: 1),
            MyCarrotListModel(title: "동네 인증하기", image: UIImage(systemName: "location.magnifyingglass")!, section: 1),
            MyCarrotListModel(title: "키워드 알림", image: UIImage(systemName: "bookmark")!, section: 1),
            MyCarrotListModel(title: "당근가계부", image: UIImage(systemName: "book.closed.fill")!, section: 1),
            MyCarrotListModel(title: "모아보기", image: UIImage(systemName: "square.grid.2x2")!, section: 1),
            MyCarrotListModel(title: "관심 카테고리 설정", image: UIImage(systemName: "slider.horizontal.3")!, section: 1),
            
            MyCarrotListModel(title: "동네생활 글", image: UIImage(systemName: "book")!, section: 2),
            MyCarrotListModel(title: "동네생활 댓글", image: UIImage(systemName: "square.and.pencil")!, section: 2),
        ]
        self.datas = data
    }
    
    func getDatas() -> [MyCarrotListModel] {
        return datas
    }
    
}
