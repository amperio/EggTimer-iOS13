//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var img_softEgg: UIImageView!
    @IBOutlet weak var img_mediumEgg: UIImageView!
    @IBOutlet weak var img_hardEgg: UIImageView!
    @IBOutlet weak var pgb_progress: UIProgressView!
    
    let dic: [String:Int] = ["Soft":5,"Medium":7,"Hard":12]
    var counter = 0, totalTime = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    // Porque '#selector' viene de objective c, se tiene que especificar anteponiendo '@objc'
    @objc func updateCounter(){
        if counter >= 0{
            lbl_title.text = "\(counter) seconds to the end the of the egg"
            let f = Double(counter) / Double(totalTime)
            counter -= 1
            pgb_progress.progress = Float(1-f)
        }else{
            timer.invalidate()
            lbl_title.text = "Your egg is ready!"
            img_softEgg.alpha = 1
            img_mediumEgg.alpha = 1
            img_hardEgg.alpha = 1
            pgb_progress.progress = 0.0
            playSound()
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        // Obtener el titulo de un boton:
        // sender.titleLabel?.text
        let hardness = sender.currentTitle!
        totalTime = dic[hardness]!
        counter = dic[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        switch hardness{
        case "Soft":
            img_softEgg.alpha = 0.5
        case "Medium":
            img_mediumEgg.alpha = 0.5
        case "Hard":
            img_hardEgg.alpha = 0.5
        default:
            print("Error!")
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}





//                ___                  ___ 
//               -   -________________-   -
//             /----.       AMP        .----\
//            (  __  |                |  __  )
//            | (@ ) |                | ( @) |
//           /\\____//                \\____//\
//          /              *:   :*             \
//          \`\ ____________________________ /`/
//           \                                /
//            \    $$$$$$$$$$$$$$$$$$$$$$    /
//             \    $$$$$$$$$$$$$$$$$$$$    /
//              -__  $$$$$$$$$$$$$$$$$$  __-
//                  -_$$$$$$$$$$$$$$$$_-




