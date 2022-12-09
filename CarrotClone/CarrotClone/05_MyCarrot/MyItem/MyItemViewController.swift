//
//  MyItemViewController.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/08.
//

import UIKit

class MyItemViewController: UIViewController {
    
    var items: [TradeItemModel] = []

    @IBOutlet weak var myItemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "나의 판매목록"
        setupData()
        setupTableView()
    }
    
    private func setupData() {
        let allItem = TradeItemLogic.shared.readAllItem()
        self.items = allItem.filter { item in
            item.user.name == UserInfo.shared.getUserName()
        }
    }
    
    private func setupTableView() {
        myItemTableView.dataSource = self
        myItemTableView.delegate = self
        myItemTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        myItemTableView.rowHeight = 150
    }
}

extension MyItemViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = myItemTableView.dequeueReusableCell(withIdentifier: "ItemCell") as? ItemCell else { return UITableViewCell() }
        cell.delegate = self
        cell.indexpath = indexPath.row
        cell.configureUI(item: items[indexPath.row], enableModifyButton: true)
        return cell
    }
}

extension MyItemViewController: ModifyButtonDelegate {
    func modifyButtonTapped(index: Int) {
        // Alert 창 표시
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 수정 버튼
        let modify = UIAlertAction(title: "게시글 수정", style: .default) { action in
            /// EDIT ViewController 열기
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController else { return }
            vc.status = .modify
            vc.item = self.items[index]
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // 삭제 버튼
        let delete = UIAlertAction(title: "삭제", style: .destructive) { action in
            TradeItemLogic.shared.deleteItem(selectedItem: self.items[index])
            self.setupData()
            self.myItemTableView.reloadData()
        }
        alert.addAction(modify)
        alert.addAction(delete)
        
        // Alert 바깥쪽 클릭해 닫기
        present(alert, animated: true) {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTappedOutside(_:)))
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(tap)
        }
    }
    
    @objc private func didTappedOutside(_ sender: UITapGestureRecognizer) {
        print(#function)
        self.dismiss(animated: true, completion: nil)
    }
}

extension MyItemViewController: HomeViewControllerDelegate {
    func didEditFinished() {
        print("완료 버튼 눌림")
        self.setupData()
        self.myItemTableView.reloadData()
    }
}
