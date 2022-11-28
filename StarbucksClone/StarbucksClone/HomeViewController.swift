//
//  ViewController.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/28.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let dataManager = DataManager()
    private var starbucksModel: [Starbucks] = []
    private var recommandData: [Starbucks] = []
    
    @IBOutlet weak var userRecommandCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupUserRecCV()
    }
    
    func setupData() {
        dataManager.loadLocationsFromCSV(fileName: "StarbucksModel")
        self.starbucksModel = dataManager.getModelDatas()

        // recommand 필터
        self.recommandData = starbucksModel.filter { $0.isRecommand == true }
        dump(recommandData)
    }
    
    func setupUserRecCV() {
        userRecommandCollectionView.delegate = self
        userRecommandCollectionView.dataSource = self
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommandData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
        return UICollectionViewCell()
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate {
    
}
