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
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemCategoryLabel: UILabel!
    @IBOutlet weak var itemBodyLabel: UILabel!
    
    @IBOutlet weak var customBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var chatButton: UIButton!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var isSuggestPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hideNavigationBar()
    }

    private func setupUI() {
        guard let item = item else { return }
        userName.text = item.user.name
        userRegion.text = item.region
        itemImages.image = item.photos?[0]
        itemTitleLabel.text = item.title
        itemCategoryLabel.text = item.category.rawValue
        itemBodyLabel.text = item.body
        
        chatButton.layer.cornerRadius = 5
        chatButton.clipsToBounds = true
        
        priceLabel.text = item.price
        isSuggestPrice.text = suggestedPrice(data: item.isPriceSuggest)
    }
    
    private func suggestedPrice(data: Bool) -> String {
        if data == true {
            return "가격 제안 가능"
        } else {
            return "가격 제안 불가"
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
