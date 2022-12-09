//
//  MyCarrotViewController.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/05.
//

import UIKit

class MyCarrotViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func myItemButtonTapped(_ sender: UIButton) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MyItemViewController") as? MyItemViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
