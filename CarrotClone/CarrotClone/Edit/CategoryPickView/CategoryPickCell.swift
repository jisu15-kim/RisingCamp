//
//  CategoryPickCell.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/08.
//

import UIKit

class CategoryPickCell: UITableViewCell {
    
    @IBOutlet weak var categoryTitle: UILabel!
    var indexpath: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        
        if let index = indexpath {
            categoryTitle.text = Category.allCases[index].rawValue
        }
    }
}
