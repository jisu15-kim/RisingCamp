//
//  UserSectionCell.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/10.
//

import UIKit

class UserSectionCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userItemTapView: UIImageView!
    
    var delegate: MyCarrotItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        userName.text = UserInfo.shared.getUserName()
        
        userItemTapView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userItemButtonTapped))
        userItemTapView.addGestureRecognizer(gesture)
    }
    
    @objc func userItemButtonTapped() {
        print("판매내역 버튼 눌렸다")
        delegate?.myCarrotButtonTapped()
    }
}
