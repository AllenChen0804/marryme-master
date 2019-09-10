//
//  HomeViewController.swift
//  marryme
//
//  Created by 陳永展 on 2019/8/1.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit
import AVFoundation
class HomeViewController: UIViewController {
    
    
    var player: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let speechUtterance = AVSpeechUtterance(string: "限時兩分鐘,六十分及格才可以結婚！")
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        speechUtterance.rate = 0.3
        speechUtterance.volume = 1.0
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speechUtterance)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func playClick(_ sender: Any) {
//        if let url = Bundle.main.url(forResource: "Start", withExtension: "mp4") {
//            player = try? AVAudioPlayer(contentsOf: url)
//            player?.play()
//           
//        }
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
