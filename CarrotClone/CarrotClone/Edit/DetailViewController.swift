//
//  DetailViewController.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/07.
//

import UIKit

class DetailViewController: UIViewController {

    var item: TradeItemModel?
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userRegion: UILabel!
    @IBOutlet weak var itemImages: UIImageView!
    
    @IBOutlet weak var customBarHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.navigationController?.hideNavigationBar()
        self.itemImages.bringSubviewToFront(itemImages)
        // Z Index -> 적용
    }

    func setupUI() {
        guard let item = item else { return }
        userName.text = item.user.name
        userRegion.text = item.region
        itemImages.image = item.photos?[0]
    }
}
