//
//  CardCell.swift
//  SamePictureGame
//
//  Created by 김지수 on 2022/12/11.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    var cardData: GameData?
    
    var cardImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setup() {
        self.addSubview(cardImage)
        setupConstraints()
        
        if let data = cardData {
            self.cardImage.image = data.image
            self.cardImage.backgroundColor = data.color
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cardImage.topAnchor.constraint(equalTo: self.topAnchor),
            cardImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
