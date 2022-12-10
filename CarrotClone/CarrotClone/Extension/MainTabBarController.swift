//
//  MainTabBarController.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/09.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItem()
        
    }
    
    // 네비게이션바 아이템 세팅
    private func setupNavigationItem() {
        let titleConfig = CustomNaviBarItemConfig(title: "시흥동", handler: {})
        let titleItem = UIBarButtonItem.generate(config: titleConfig)
        
        let searchConfig = CustomNaviBarItemConfig(title: nil, image: UIImage(systemName: "magnifyingglass"), handler: {})
        let searchItem = UIBarButtonItem.generate(config: searchConfig, width: 30)
        
        let notiConfig = CustomNaviBarItemConfig(title: nil, image: UIImage(systemName: "bell"), handler: {})
        let notiItem = UIBarButtonItem.generate(config: notiConfig, width: 30)
        
        navigationItem.leftBarButtonItem = titleItem
        navigationItem.rightBarButtonItems = [searchItem, notiItem]
    }
}

struct CustomNaviBarItemConfig {
    var title: String?
    var image: UIImage?
    var handler: (() -> Void)
    
    init(title: String? = nil, image: UIImage? = nil, handler: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.handler = handler
    }
}

class CustomNaviBarItem: UIButton {
    
    var config: CustomNaviBarItemConfig
    
    init(config: CustomNaviBarItemConfig) {
        self.config = config
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        self.titleLabel?.textColor = .label
        self.titleLabel?.tintColor = .label
        self.tintColor = .white
        
        self.setTitle(config.title, for: .normal)
        self.setImage(config.image, for: .normal)
    }
    
    @objc func buttonTapped() {
        
    }
}
