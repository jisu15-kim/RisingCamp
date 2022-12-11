//
//  ViewController.swift
//  SamePictureGame
//
//  Created by 김지수 on 2022/12/11.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        print(#function)
        
        let story = UIStoryboard(name: "GameScene", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "GameSceneViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

