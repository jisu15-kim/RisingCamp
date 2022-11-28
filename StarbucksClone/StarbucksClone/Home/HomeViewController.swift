//
//  ViewController.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/28.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var sections: [UIImageView]!
    
    private let dataManager = DataManager.shard
    private var starbucksModel: [Starbucks] = []
    private var recommandData: [Starbucks] = []
    
    @IBOutlet weak var userRecommandCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupUI()
        setupUserRecCV()
    }
    
    private func setupData() {
        dataManager.loadLocationsFromCSV(fileName: "StarbucksModel")
        self.starbucksModel = dataManager.getModelDatas()

        // recommand 필터
        self.recommandData = starbucksModel.filter { $0.isRecommand == true }
    }
    
    private func setupUserRecCV() {
        // CollectionView의 width값
        let width = userRecommandCollectionView.bounds.width
        if let layout = userRecommandCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            
            // 기준 width의 0.4
            layout.itemSize = CGSize(width: width * 0.4 - layout.minimumInteritemSpacing, height: width * 0.4 + 40)
            print("이거 실행되냐")
        }
        userRecommandCollectionView.showsHorizontalScrollIndicator = false
        userRecommandCollectionView.delegate = self
        userRecommandCollectionView.dataSource = self
        userRecommandCollectionView.register(UserRecommandCell.self, forCellWithReuseIdentifier: "UserRecommandCell")
    }
    
    private func setupUI() {
        sections.forEach { image in
            image.layer.cornerRadius = 7
            image.clipsToBounds = true
            image.layer.masksToBounds = false
            image.layer.shadowColor = UIColor.black.cgColor
            image.layer.shadowRadius = 2
            image.layer.shadowOffset = CGSize(width: 0, height: 10)
            image.layer.shadowOpacity = 0.1
            image.layer.shadowRadius = 4.0
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommandData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserRecommandCell", for: indexPath) as? UserRecommandCell else { return UICollectionViewCell() }
        cell.item = self.recommandData[indexPath.row]
        cell.setupCell()
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}
