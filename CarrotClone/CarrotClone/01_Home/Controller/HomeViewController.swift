//
//  ViewController.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/05.
//

import UIKit
import PopMenu

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    private var items: [TradeItemModel] = []
    
    @IBOutlet weak var writeButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TradeItemLogic.shared.fetchDummyDatas()
        self.items = TradeItemLogic.shared.readAllItem()
        setupTableView()
        setupWriteButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.showNavigationBar()
        self.items = TradeItemLogic.shared.readAllItem()
        self.homeTableView.reloadData()
    }
    
    private func setupTableView() {
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.homeTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeTableView.rowHeight = 150
    }
    
    private func setupWriteButton() {
        writeButton.layer.cornerRadius = writeButton.frame.width / 2
        writeButton.clipsToBounds = true
        
        // 카트 제스쳐 추가
        self.writeButton.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.writeButtonTapped(_:)))
        self.writeButton.addGestureRecognizer(gesture)
    }

    // 카트 그림 눌렸을 때
    @objc func writeButtonTapped(_ sender: UITapGestureRecognizer) {
        
        let manager = PopMenuManager.default
        manager.popMenuDelegate = self
        let button1 = PopMenuDefaultAction(title: "임시 버튼", image: UIImage(named: "icon")) { action in
            
        }
        let button2 = PopMenuDefaultAction(title: "임시 버튼", image: UIImage(named: "icon")) { action in
            print("버튼2 눌림")
        }
        let writeAction = PopMenuDefaultAction(title: "글 쓰기", image: UIImage(named: "icon")) { action in
            
        }
        
        button1.imageRenderingMode = .alwaysOriginal
        button2.imageRenderingMode = .alwaysOriginal
        writeAction.imageRenderingMode = .alwaysOriginal

        manager.actions = [button1, button2, writeAction]
        
        manager.popMenuDidDismiss = { selected in
            print(selected)
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController else { return }
            vc.status = .write
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        manager.present(with: sender, on: self, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeTableView.dequeueReusableCell(withIdentifier: "ItemCell") as? ItemCell else { return UITableViewCell() }
        cell.configureUI(item: items[indexPath.row], enableModifyButton: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        print(items[indexPath.row])
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        vc.item = items[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: PopMenuViewControllerDelegate {
    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {

    }
}


extension PopMenuManager {
    func present(with gesture: UIGestureRecognizer, on viewController: UIViewController, animated: Bool = true, completion: (() -> UIView?)? = nil) {
        
        let sourceView = UIView(frame: CGRect(origin: gesture.location(in: nil), size: .zero))
        UIApplication.shared.keyWindow?.addSubview(sourceView)
        present(sourceView: sourceView, on: viewController, animated: animated) {
            sourceView.removeFromSuperview()
        }
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    func didEditFinished() {

    }
}
