//
//  CategoryPickViewController.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/08.
//

import UIKit

class CategoryPickViewController: UIViewController {
    
    @IBOutlet weak var categoryPickTableView: UITableView!
    var delegate: CategoryPickDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPickTableView.delegate = self
        categoryPickTableView.dataSource = self
    }
}

extension CategoryPickViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = categoryPickTableView.dequeueReusableCell(withIdentifier: "CategoryPickCell") as? CategoryPickCell else { return UITableViewCell() }
        cell.indexpath = indexPath.row
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = Category.allCases
        self.navigationController?.popViewController(animated: true, completion: {
            self.delegate?.categoryPicked(selected: category[indexPath.row])
        })
    }
}
