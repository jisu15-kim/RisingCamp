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
    }
}

//MARK: - EXTENSION CollectionView
extension GameSceneViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.setting.getRow() * self.setting.getColumn()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = gameZoneCollectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell else { return UICollectionViewCell() }
        cell.cardData = self.cardData[indexPath.row]
        cell.setup()
        return cell
    }
}

extension GameSceneViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        
        let width = (Int(self.gameZoneCollectionView.frame.width) - ((setting.getRow() - 1) * setting.getItemSpacing())) / setting.getRow()
        let height = (Int(self.gameZoneCollectionView.frame.height) - ((setting.getColumn() - 1) * setting.getLineSpacing())) / setting.getColumn()
        
        return CGSize(width: width, height: height)
    }
}

extension GameSceneViewController: UICollectionViewDelegate {
    
}
