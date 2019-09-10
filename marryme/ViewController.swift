//
//  ViewController.swift
//  marryme
//
//  Created by 陳永展 on 2019/7/26.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet var answerButton: [UIButton]!
    
    
    @IBOutlet weak var timelabel: UILabel!
    
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var againButton: UIButton!
    
    
    
    var choices:[String] = []
    var totalScore:Int = 0
    var mul:qua?
    var test:[Int] = []
    var count = 0
    var counter = 120
    var timer = Timer()
    let roundString = [ "一", "二", "三", "四", "五", "六", "七", "八", "九", "十" ]
    var player: AVAudioPlayer?
    var player1: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        test = num.shuffled()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
        changeQuestion()
        if let url = Bundle.main.url(forResource: "Start", withExtension: "mp4") {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
    }
    
    
    
    @IBAction func choiceButton(_ sender: UIButton) {
        if let url = Bundle.main.url(forResource: "Start", withExtension: "mp4") {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        
        let number = answerButton.firstIndex(of: sender)
        if ( answerButton[number!].currentTitle == mul!.answer ) {
            //            let speechUtterance = AVSpeechUtterance(string: "ピンポンピンポン")
            //            speechUtterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            //            speechUtterance.rate = 0.62
            //            speechUtterance.pitchMultiplier = 1.6
            //            let synthesizer = AVSpeechSynthesizer()
            //            synthesizer.speak(speechUtterance)
            
            //-------------單題答對音效-----------------------
            if let url1 = Bundle.main.url(forResource: "6", withExtension: "mp3") {
                player1 = try? AVAudioPlayer(contentsOf: url1)
                player1?.play()
            }
            //答對換回正常背景
            background.image = UIImage(named: "9")
            //答對分數加10分
            totalScore += 10
            totalLabel.text = String(totalScore)
        }
        else {
            //-------------單題答錯音效-----------------------
            let speechUtterance = AVSpeechUtterance(string: "大笨蛋")
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
            speechUtterance.rate = 0.62
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(speechUtterance)
            //答錯換成Ugly照片
            background.image = UIImage(named: "Ugly2")
            
        }
        
        //回答後題目計數＋1
        //如果題目數小於10就在繼續進入流程changeQuestion,反之則進入finalScore
        count += 1
        if ( count < 10 ) {
            self.changeQuestion()
        }
        else {
            finalScore()
        }
    }
    
    //-------------重玩按鈕----------------------
    @IBAction func playButton(_ sender: Any) {
        let num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        test = num.shuffled()
        count = 0
        totalScore = 0
        totalLabel.text = String(totalScore)
        counter = 120
        timelabel.text = "2:00"
        for i in 0...3 {
            answerButton[i].isEnabled = true
        }
        changeQuestion()
        timelabel.isHidden = false
    }
    
    
    func changeQuestion() {
        
        mul = multiqua[test[count]]
        
        roundLabel.text = "第" + roundString[count] + "題"
        
        questionLabel.text = mul!.question
        //shuffled亂數
        choices = mul!.choice.shuffled()
        answerButton[0].setTitle(choices[0], for: .normal)
        answerButton[1].setTitle(choices[1], for: .normal)
        answerButton[2].setTitle(choices[2], for: .normal)
        answerButton[3].setTitle(choices[3], for: .normal)
        
    }
    //分數流程控制
    func finalScore () {
        timer.invalidate()
        for i in 0...3 {
            answerButton[i].isEnabled = false
        }
        
        if totalScore >= 60
        {
            //大於六十分轉換頁面,並播放音樂
            if let url = Bundle.main.url(forResource: "今天你要嫁給我", withExtension: "mp4") {
                player = try? AVAudioPlayer(contentsOf: url)
                player?.play()
                performSegue(withIdentifier: "good", sender: nil)
            }
        }
        else
        {
            
            //小於六十分轉換頁面,並播放音樂
            if let url = Bundle.main.url(forResource: "最熟悉的陌生人", withExtension: "mp4") {
                player = try? AVAudioPlayer(contentsOf: url)
                player?.play()
                performSegue(withIdentifier: "bad", sender: nil)
            }
            
        }
    }
    
    // timer
    @objc  func timerRun () {
        counter -= 1
        let countSec:Int = counter % 60
        let countMin:Int = counter / 60
        timelabel.text = String(countMin) + ":" + String( format: "%02d", countSec )
        if ( counter > 0 ) {
        }
        else {
            finalScore()
        }
    }
    
    
    
}





