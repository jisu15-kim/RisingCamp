//
//  ItemCell.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/05.
//

import UIKit

class ItemCell: UITableViewCell {
    
    var item: TradeItemModel?
    var indexpath: Int?
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // 수정 버튼 !
    @IBOutlet weak var modifyButton: UIImageView?
    
    // 수정 버튼 Delegate !
    var delegate: ModifyButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureUI(item: TradeItemModel, enableModifyButton: Bool) {
        self.backgroundColor = #colorLiteral(red: 0.1294115484, green: 0.1294119358, blue: 0.138001442, alpha: 1)
        titleLabel.text = item.title
        regionLabel.text = item.region
        priceLabel.text = item.price
        thumbnailImage.image = item.photos?[0]
        self.item = item
        setupUI()
        
        if enableModifyButton == true {
            setupModifyButton()
        } else {
            if let button = modifyButton {
                button.removeFromSuperview()
            }
        }
    }
    
    private func setupUI() {
        self.thumbnailImage.layer.cornerRadius = 10
        self.thumbnailImage.clipsToBounds = true
    }
    
    private func setupModifyButton() {
        if let button = modifyButton {
            button.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.modifyButtonTapped(_:)))
            button.addGestureRecognizer(gesture)
        }
    }
    
    @objc private func modifyButtonTapped(_ sender: UITapGestureRecognizer) {
        delegate?.modifyButtonTapped(index: indexpath!)
    }
}
