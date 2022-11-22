//
//  ViewController.swift
//  AutoLayoutExample
//
//  Created by 김지수 on 2022/11/19.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet var imageToCircle: [UIImageView]!
    @IBOutlet var typeCellView: [UIView]!
    @IBOutlet var posterImage: [UIImageView]!
    @IBOutlet var rankingNumber: [UILabel]!
    @IBOutlet var genreImageView: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProfileImage()
        setupTypeCellView()
        setupEpisodeImage()
        setupRankingNumber()
        setupGenreImageView()
    }
    
    // 코드 정리 필요
    
    private func setupProfileImage() {
        self.imageToCircle.forEach { image in
            image.layer.cornerRadius = image.bounds.width / 2
            image.clipsToBounds = true
        }
    }
    
    private func setupTypeCellView() {
        self.typeCellView.forEach { view in
            view.layer.cornerRadius = 20
            view.clipsToBounds = true
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    private func setupEpisodeImage() {
        self.posterImage.forEach { image in
            image.layer.cornerRadius = 5
            image.clipsToBounds = true
        }
    }
    
    private func setupRankingNumber() {
        rankingNumber.forEach { label in
            label.layer.shadowColor = UIColor.darkGray.cgColor
            label.layer.shadowRadius = 5
            label.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    
    private func setupGenreImageView() {
        genreImageView.forEach { image in
            image.layer.cornerRadius = 5
            image.clipsToBounds = true            
        }
    }
}
