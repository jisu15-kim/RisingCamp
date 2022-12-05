//
//  ViewController.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/05.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    private var items: [TradeItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TradeItemLogic.shared.fetchDummyDatas()
        self.items = TradeItemLogic.shared.readAllItem()
        setupTableView()
    }
    
    private func setupTableView() {
        self.homeTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeTableView.rowHeight = 150
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: "ItemCell") as? ItemCell else { return UITableViewCell() }
        cell.configureUI(item: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
