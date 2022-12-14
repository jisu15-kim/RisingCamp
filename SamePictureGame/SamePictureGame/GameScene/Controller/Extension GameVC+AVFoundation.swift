//
//  Extension GameVC+AVFoundation.swift
//  SamePictureGame
//
//  Created by 김지수 on 2022/12/14.
//

import AVFoundation
import UIKit

extension GameSceneViewController {
    
    func playMusic() {
        let url = Bundle.main.url(forResource: "mapleBgm", withExtension: "mp3")
        if let url = url {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
            }
            catch {
                print(error)
            }
        }
    }
    
    func musicToggle() {
        
    }
    
}

