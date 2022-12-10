//
//  MyCarrotListCell.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/10.
//

import UIKit

class MyCarrotListCell: UITableViewCell {
    
    var data: MyCarrotListModel?
    
    @IBOutlet weak var myCarrotImage: UIImageView!
    @IBOutlet weak var myCarrotListTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        if let data = data {
            myCarrotImage.image = data.image
            myCarrotListTitle.text = data.title
        }
    }
    
}
