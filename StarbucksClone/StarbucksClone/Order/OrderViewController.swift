//
//  OrderViewController.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/28.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var menuCollectionView: UICollectionView!
    let dataManager = DataManager.shard
    var starbucksModels: [Starbucks] = []
    
    var filterdData: [Category:[Starbucks]] = [
        .ColdBrew:[],
        .Blended:[],
        .Espresso:[],
        .Fizzio:[],
        .Frappuccino:[],
        .Refresher:[],
        .Teavana:[],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatas()
        setupCollectionView()
    }
    
    private func setupDatas() {
        starbucksModels = dataManager.getModelDatas()
        
        var coldBrew: [Starbucks] = []
        var blended: [Starbucks] = []
        var espresso: [Starbucks] = []
        var fizzio: [Starbucks] = []
        var frappuccino: [Starbucks] = []
        var refresher: [Starbucks] = []
        var teavana: [Starbucks] = []
        var error: [Starbucks] = []
        
        starbucksModels.forEach { item in
            switch item.category {
            case .ColdBrew:
                coldBrew.append(item)
            case .Blended:
                blended.append(item)
            case .Espresso:
                espresso.append(item)
            case .Fizzio:
                fizzio.append(item)
            case .Frappuccino:
                frappuccino.append(item)
            case .Refresher:
                refresher.append(item)
            case .Teavana:
                teavana.append(item)
            default:
                error.append(item)
            }
        }
        
        filterdData.updateValue(coldBrew, forKey: .ColdBrew)
        filterdData.updateValue(blended, forKey: .Blended)
        filterdData.updateValue(espresso, forKey: .Espresso)
        filterdData.updateValue(fizzio, forKey: .Fizzio)
        filterdData.updateValue(frappuccino, forKey: .Frappuccino)
        filterdData.updateValue(refresher, forKey: .Refresher)
        filterdData.updateValue(teavana, forKey: .Teavana)
    }
    
    private func setupCollectionView() {
        if let layout = menuCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: menuCollectionView.bounds.width, height: 100)
        }
        
        menuCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MenuCell")
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
    }
}

extension OrderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(filterdData.keys.count)
        return filterdData.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        var cellData: Starbucks
//        self.filterdData.forEach { (key, value) in
//            cellData.append(value[0])
//        }
//        dump(cellData)
        
        guard let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCell else { return UICollectionViewCell() }
        
        return cell
    }
}
