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
        cardImageInit()
        setupUI()
    }
    
    // 카드 보여주기
    public func cardToShow(isHint: Bool? = false) {
        if let data = cardData {
            self.isShowing = true
            self.cardImage.image = data.image
            self.cardImage.backgroundColor = data.color
            self.cardImage.contentMode = .scaleAspectFit
            UIView.transition(with: cardImage, duration: 0.5, options: .transitionFlipFromRight, animations: nil) { _ in
                if isHint == true {
                    self.cardToHide()
                } else {
                    self.delegate?.isCardShowed(index: self.index!)
                }
            }
        }
    }
    
    // 카드 이미지 초기 설정
    private func cardImageInit() {
        self.isShowing = false
        self.cardImage.image = UIImage(named: "back")
        self.cardImage.backgroundColor = .label
        self.cardImage.contentMode = .scaleAspectFill
    }
    
    private func firstHint() {
        self.cardToShow(isHint: true)
    }
    
    // 카드 가리기
    public func cardToHide(isHint: Bool = false) {
        self.isShowing = false
        self.cardImage.image = UIImage(named: "back")
        self.cardImage.backgroundColor = .label
        self.cardImage.contentMode = .scaleAspectFill
        UIView.transition(with: cardImage, duration: 0.5, options: .transitionFlipFromLeft, animations: nil) { _ in
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
