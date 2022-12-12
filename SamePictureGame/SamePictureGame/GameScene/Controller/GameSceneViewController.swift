//
//  GameSceneViewController.swift
//  SamePictureGame
//
//  Created by 김지수 on 2022/12/11.
//

import UIKit

class GameSceneViewController: UIViewController {
    
    @IBOutlet weak var cardFlipLifeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    let setting = GameSetting.shared
    var cardData: [GameData] = []
    var cardFlipLife: Int = 0 {
        didSet {
            print("남은 횟수: \(cardFlipLife)")
            cardFlipLifeLabel.text = "\(cardFlipLife)"
        }
    }
    var timer: Timer!
    var gamePlayTime = 0
    var startRow = 0
    
    // Match된 카드의 갯수 // 10개
    private var cardMatchCount: Int = 0 {
        didSet {
            if cardMatchCount == (setting.getRow() * setting.getColumn()) / 2 {
                self.gameClear()
            }
        }
    }
    
    private var flipedCard: [CardCell] = []
    
    @IBOutlet weak var gameZoneCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameData()
        setupCollectionView()
        firstHint()
    }
    
    private func setupGameData() {
        self.cardData = GameDataManager.shared.getCardData(isShuffle: true)
        self.cardFlipLife = setting.getLifeCount()
        print("남은 횟수: \(cardFlipLife)")
        self.cardFlipLifeLabel.text = "\(self.cardFlipLife)"
        self.gamePlayTime = 0
        self.timeLabel.text = "\(gamePlayTime)"
    }
    
    private func setupCollectionView() {
        gameZoneCollectionView.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = CGFloat(setting.getItemSpacing())
        flowLayout.minimumInteritemSpacing = CGFloat(setting.getLineSpacing())
        
        gameZoneCollectionView.dataSource = self
        gameZoneCollectionView.delegate = self
        gameZoneCollectionView.isScrollEnabled = false
        gameZoneCollectionView.backgroundColor = .clear
        gameZoneCollectionView.allowsSelection = false
    }
    
    private func timerStart() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerToLabel), userInfo: nil, repeats: true)
    }
    
    @objc private func timerToLabel() {
        self.gamePlayTime += 1
        self.timeLabel.text = "\(gamePlayTime)"
    }
    
    // 처음 힌트주기
    private func firstHint() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(firstFlip), userInfo: nil, repeats: true)
    }
    
    @objc private func firstFlip() {
        if self.startRow < 20 {
            guard let cell = self.gameZoneCollectionView.cellForItem(at: IndexPath(row: self.startRow, section: 0)) as? CardCell else { return }
            cell.cardToShow(isHint: true)
            self.startRow += 1
        } else {
            // 힌트가 끝나면 액션
            self.timer.invalidate()
            self.timerStart()
            gameZoneCollectionView.allowsSelection = true  // 힌트 시간에는 클릭을 못해 -> 본격 게임 시작 !
            self.startRow = 0
        }
    }
    
    // 게임 클리어시 Alert 및 액션 설정
    private func gameClear() {
        self.timer.invalidate()
        let alert = UIAlertController(title: "게임 클리어🙌", message: "축하드립니다🥳", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default) { action in
            self.dismiss(animated: true)
        }
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    // 게임 실패
    private func gameFail() {
        self.timer.invalidate()
        let alert = UIAlertController(title: "🤔게임 실패", message: "아쉬워요", preferredStyle: .alert)
        let home = UIAlertAction(title: "홈으로", style: .default) { action in
            self.dismiss(animated: true)
        }
        let retry = UIAlertAction(title: "재도전", style: .default) { action in
            self.retryGame()
        }
        alert.addAction(home)
        alert.addAction(retry)
        present(alert, animated: true)
    }
    
    // 재도전
    private func retryGame() {
        self.setupGameData()
        self.setupCollectionView()
        self.gameZoneCollectionView.reloadData()
        self.firstHint()
    }
    
    public func checkFlipLife() -> Bool {
        if self.cardFlipLife == 0 {
            return false
        } else {
            return true
        }
    }
}

//MARK: - EXTENSION CollectionView
extension GameSceneViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.setting.getRow() * self.setting.getColumn()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = gameZoneCollectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell else { return UICollectionViewCell() }
        cell.index = indexPath
        cell.delegate = self
        cell.cardData = self.cardData[indexPath.row]
        cell.setup()
        return cell
    }
}

extension GameSceneViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (Int(self.gameZoneCollectionView.frame.width) - ((setting.getRow() - 1) * setting.getItemSpacing())) / setting.getRow()
        let height = (Int(self.gameZoneCollectionView.frame.height) - ((setting.getColumn() - 1) * setting.getLineSpacing())) / setting.getColumn()
        
        return CGSize(width: width, height: height)
    }
}

extension GameSceneViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.cardData[indexPath.row].id)
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell else { return }
        
        // hide 상태라면
        if cell.isShowing == false {
            self.cardFlipLife -= 1
            cell.cardToShow()
        } else {
            print("이미 카드가 뒤집혀 있습니다")
        }
    }
}

extension GameSceneViewController: CardCellDelegate {
    func isCardShowed(index: IndexPath) {
        
        // 카드 Flip 라이프가 0이라면, FAIL

        // 1. 셀을 배열에 담아
        // 2. 배열에 담긴 셀이 2개인지 체크
        // 3. 2개라면, 셀을 꺼내 Hide 함수 호출
        guard let cell = gameZoneCollectionView.cellForItem(at: index) as? CardCell else { return }
        self.flipedCard.append(cell)
        if flipedCard.count == 2 {
            let first = self.flipedCard[0]
            let second = self.flipedCard[1]
            
            if first.cardData?.id == second.cardData?.id {
                self.cardMatchCount += 1
            } else {
                first.cardToHide()
                second.cardToHide()
            }
            self.flipedCard = []
        }
        
        if self.cardFlipLife == 0 {
            self.gameFail()
        }
    }
}
