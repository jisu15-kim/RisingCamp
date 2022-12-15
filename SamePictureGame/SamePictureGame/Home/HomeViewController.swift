//
//  ViewController.swift
//  SamePictureGame
//
//  Created by 김지수 on 2022/12/11.
//

import UIKit

class HomeViewController: UIViewController, GameSceneDelegate {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var rankingButton: UIButton!
    
    var bgmToggleView: BGMToggleView = {
        let view = BGMToggleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func gameSceneDismiss() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewToRoundCorner(view: self.titleView)
        viewToRoundCorner(view: self.startButton)
        viewToRoundCorner(view: self.rankingButton)
        setupBgmToggleView()
        appDelegate.playMusic()
    }
    
    func viewToRoundCorner(view: UIView) {
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
    }
    
    func setupBgmToggleView() {
        self.view.addSubview(bgmToggleView)
        NSLayoutConstraint.activate([
            self.bgmToggleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            self.bgmToggleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.bgmToggleView.widthAnchor.constraint(equalTo: bgmToggleView.heightAnchor, multiplier: 1.0),
            self.bgmToggleView.widthAnchor.constraint(equalToConstant: 25)
        ])   
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        print(#function)
        
        let story = UIStoryboard(name: "GameScene", bundle: nil)
        guard let vc = story.instantiateViewController(withIdentifier: "GameSceneViewController") as? GameSceneViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @IBAction func rankButtonTapped(_ sender: UIButton) {
        
    }
}

extension HomeViewController: BGMToggleViewDelegate {
    func BgmViewTapped() {
        print(#function)
        appDelegate.musicToggle()
    }
}

