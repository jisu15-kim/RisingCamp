//
//  GameSceneViewController.swift
//  SamePictureGame
//
//  Created by 김지수 on 2022/12/11.
//

import UIKit

class GameSceneViewController: UIViewController {
    
    let setting = GameSetting.shared
    var cardData: [GameData] = []
    
    private var cardFlipCount: Int = 0
    
    private var flipedCard: [CardCell] = []
    
    @IBOutlet weak var gameZoneCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGameData()
        setupCollectionView()
    }
    
    private func setupGameData() {
        self.cardData = GameDataManager.shared.getCardData(isShuffle: true)
    }
    
    private func setupCollectionView() {
        gameZoneCollectionView.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = CGFloat(setting.getItemSpacing())
        flowLayout.minimumInteritemSpacing = CGFloat(setting.getLineSpacing())
        
        gameZoneCollectionView.dataSource = self
        gameZoneCollectionView.delegate = self
        gameZoneCollectionView.isScrollEnabled = false
        gameZoneCollectionView.backgroundColor = .clear
    }
}

//MARK: - EXTENSION CollectionView
extension GameSceneViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.setting.getRow() * self.setting.getColumn()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = gameZoneCollectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell else { return UICollectionViewCell() }
        cell.index = indexPath
        cell.delegate = self
        cell.cardData = self.cardData[indexPath.row]
        cell.setup()
        return cell
    }
}

extension GameSceneViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (Int(self.gameZoneCollectionView.frame.width) - ((setting.getRow() - 1) * setting.getItemSpacing())) / setting.getRow()
        let height = (Int(self.gameZoneCollectionView.frame.height) - ((setting.getColumn() - 1) * setting.getLineSpacing())) / setting.getColumn()
        
        return CGSize(width: width, height: height)
    }
}

extension GameSceneViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.cardData[indexPath.row].id)
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell else { return }
        
        // hide 상태라면
        if cell.isShowing == false {
            cell.cardToShow()
        } else {
            print("이미 카드가 뒤집혀 있습니다")
        }
    }
}

extension GameSceneViewController: CardCellDelegate {
    func isCardShowed(index: IndexPath) {
        
        // 1. 셀을 배열에 담아
        // 2. 배열에 담긴 셀이 2개인지 체크
        // 3. 2개라면, 셀을 꺼내 Hide 함수 호출
        guard let cell = gameZoneCollectionView.cellForItem(at: index) as? CardCell else { return }
        self.flipedCard.append(cell)
        if flipedCard.count == 2 {
            let first = self.flipedCard[0]
            let second = self.flipedCard[1]
            
            if first.cardData?.id == second.cardData?.id {
                print("카드 두개가 일치함")
            } else {
                first.cardToHide()
                second.cardToHide()
            }
            self.flipedCard = []
        }
    }
}
