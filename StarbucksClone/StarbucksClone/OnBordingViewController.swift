//
//  OnBordingViewController.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/30.
//

import UIKit

class OnBordingViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        startButton.layer.cornerRadius = 25
        startButton.clipsToBounds = true
        startButton.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
    }
    
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeTabBar") as? UITabBarController else { return }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}
