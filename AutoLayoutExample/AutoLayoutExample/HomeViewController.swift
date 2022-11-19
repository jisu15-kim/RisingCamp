//
//  ViewController.swift
//  AutoLayoutExample
//
//  Created by 김지수 on 2022/11/19.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet var typeCellView: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProfileImage()
        setupTypeCellView()
        
    }
    
    private func setupProfileImage() {
        self.profileImage.layer.cornerRadius = self.profileImage.bounds.width / 2
        self.profileImage.clipsToBounds = true
    }
    
    private func setupTypeCellView() {
        self.typeCellView.forEach { view in
            view.layer.cornerRadius = 20
            view.clipsToBounds = true
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}
