//
//  CardCellDelegate.swift
//  SamePictureGame
//
//  Created by 김지수 on 2022/12/12.
//

import Foundation

protocol CardCellDelegate: AnyObject {
    func isCardShowed(index: IndexPath)
    func cardTimeOver()
    func tappedCardPreAni()
}
