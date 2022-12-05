//
//  ItemCell.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/05.
//

import UIKit

class ItemCell: UITableViewCell {
    
    var item: TradeItemModel?
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    public func configureUI(item: TradeItemModel) {
        self.backgroundColor = #colorLiteral(red: 0.1294115484, green: 0.1294119358, blue: 0.138001442, alpha: 1)
        titleLabel.text = item.title
        regionLabel.text = item.region
        priceLabel.text = item.price
        self.item = item
    }
    
    private func setupUI() {
        self.thumbnailImage.layer.cornerRadius = 15
        self.thumbnailImage.clipsToBounds = true
    }
}
