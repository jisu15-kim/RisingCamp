//
//  MyCarrotViewController.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/05.
//

import UIKit

class MyCarrotViewController: UIViewController {

    @IBOutlet weak var myCarrotTableView: UITableView!
    
    var datas: [MyCarrotListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        MyCarrotDataManager.shared.fetchData()
        self.datas = MyCarrotDataManager.shared.getDatas()
        myCarrotTableView.register(UINib(nibName: "UserSectionCell", bundle: nil), forCellReuseIdentifier: "UserSectionCell")
        myCarrotTableView.register(UINib(nibName: "MyCarrotListCell", bundle: nil), forCellReuseIdentifier: "MyCarrotListCell")
        myCarrotTableView.delegate = self
        myCarrotTableView.dataSource = self
    }
}

extension MyCarrotViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            var number = 0
            for data in datas {
                if section == data.section {
                    number += 1
                }
            }
            print("section 1 : \(number)")
            return number
        case 2:
            var number = 0
            for data in datas {
                if section == data.section {
                    number += 1
                }
            }
            print("section 2 : \(number)")
            return number
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = myCarrotTableView.dequeueReusableCell(withIdentifier: "UserSectionCell") as? UserSectionCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configure()
            return cell
        default:
            guard let cell = myCarrotTableView.dequeueReusableCell(withIdentifier: "MyCarrotListCell") as? MyCarrotListCell else { return UITableViewCell() }
            cell.data = self.datas[indexPath.row]
            cell.configure()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 165
        default:
            return 50
        }
    }
}

extension MyCarrotViewController: MyCarrotItemDelegate {
    func myCarrotButtonTapped() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MyItemViewController") as? MyItemViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
