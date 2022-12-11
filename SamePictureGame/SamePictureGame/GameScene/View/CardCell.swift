//
//  CardCell.swift
//  SamePictureGame
//
//  Created by 김지수 on 2022/12/11.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    var isShowing = false
    var cardData: GameData?
    
    var index: IndexPath?
    
    var delegate: CardCellDelegate?
    
    var cardImage: UIImageView = {
        let image = UIImageView()
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
        cardToHide()
        setupUI()
    }
    
    // 카드 보여주기
    public func cardToShow() {
        if let data = cardData {
            self.isShowing = true
            self.cardImage.image = data.image
            self.cardImage.backgroundColor = data.color
            self.cardImage.contentMode = .scaleAspectFit
            UIView.transition(with: cardImage, duration: 0.5, options: .transitionFlipFromRight, animations: nil) { _ in
                self.delegate?.isCardShowed(index: self.index!)
            }
        }
    }
    
    // 카드 가리기
    public func cardToHide() {
        self.isShowing = false
        self.cardImage.image = UIImage(named: "back")
        self.cardImage.backgroundColor = .label
        self.cardImage.contentMode = .scaleAspectFill
        UIView.transition(with: cardImage, duration: 0.5, options: .transitionFlipFromRight) {
            print("transition")
        }
    }
    
    private func setupUI() {
        cardImage.layer.cornerRadius = 10
        cardImage.clipsToBounds = true
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
