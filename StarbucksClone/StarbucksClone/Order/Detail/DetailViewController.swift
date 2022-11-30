//
//  DetailViewController.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/29.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    var selectedCategory: Category?
    var detailData: [Starbucks] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupCollectionView()
    }
    
    private func setupData() {
        guard let selected = selectedCategory else { return }
        self.navigationItem.title = selected.rawValue
    }
    
    private func setupCollectionView() {
        if let layout = detailCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: detailCollectionView.bounds.width, height: 120)
        }
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? DetailCell else { return UICollectionViewCell() }
        cell.item = detailData[indexPath.row]
        cell.setupCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController else { return }
//        self.present(vc, animated: true)
        vc.product = detailData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
