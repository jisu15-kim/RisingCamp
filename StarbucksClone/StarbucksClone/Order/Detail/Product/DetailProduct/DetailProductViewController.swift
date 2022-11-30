//
//  DetailProductViewController.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/29.
//

import UIKit

class DetailProductViewController: UIViewController {
    
    var selectedItem: Starbucks?
    
    // 내용
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
        
    // 하단
    @IBOutlet weak var footerSection: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    // 버튼 모음
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        
        guard let item = selectedItem else { return }
        titleLabel.text = item.name
        noticeLabel.text = "환경을 위해 일회용컵 사용 줄이기에 동참해 주세요"
        
        countLabel.text = "1"
        
        buttonToCapsule(button: self.orderButton)
        buttonToCapsule(button: self.cartButton)
        addShadow(view: footerSection)
    }
    
    private func buttonToCapsule(button: UIButton) {
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
    }
    
    private func addShadow(view: UIView) {
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 1, height: -10)
        view.layer.shadowOpacity = 0.03
        view.layer.shadowRadius = 5.0
    }
}
