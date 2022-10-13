//
//  ViewController.swift
//  Metronome
//
//  Created by BS901 on 10/12/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var playButtonImage: UIImageView!
    
    var isPlay: Bool = false
    var tempoValue: Int = 60 {
        didSet {
            tempoLabel.text = String(tempoValue)
            if isPlay {
                stopTimer()
                startTimer()
            }
        }
    }
    var count: Int = 0
    var timer: Timer?
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    func initialSetup() {
        isPlay = false
        tempoLabel.text = String(tempoValue)
    }
    
    func startTimer() {
        guard timer == nil else { return }
        let intervalValue: Float = Float(60.0 / Double(tempoValue))
        print(intervalValue)
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(intervalValue), target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        count = 0
    }
    
    func playMetronomeAudio() {
        guard let soundPath = Bundle.main.path(forResource: "stick", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: soundPath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            print("played")
        } catch {
            print(error)
        }
    }
    
    @objc func fireTimer() {
        count += 1
        playMetronomeAudio()
        print(count)
        if count % 2 == 0 {
            tempoLabel.font = tempoLabel.font.withSize(150)
        } else {
            tempoLabel.font = tempoLabel.font.withSize(100)
        }
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        if isPlay {
            isPlay = false
            stopTimer()
            playButtonImage.image = UIImage(systemName: "play.circle.fill")
        } else {
            isPlay = true
            startTimer()
            playButtonImage.image = UIImage(systemName: "pause.circle.fill")
        }
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        tempoValue += 1
    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        tempoValue -= 1
    }
    
}

