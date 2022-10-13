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
    @IBOutlet weak var countLabel: UILabel!
    
    var isPlay: Bool = false
    var tempoValue: Int = 60 {
        didSet {
            tempoLabel.text = String(tempoValue)
            if isPlay {
                timer?.invalidate()
                timer = nil
                startTimer()
            }
        }
    }
    var count: Int = 1 {
        didSet {
            countLabel.text = String(count)
        }
    }
    var timer: Timer?
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    func initialSetup() {
        isPlay = false
        tempoLabel.text = String(tempoValue)
        countLabel.text = String(count)
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
        count = 1
    }
    
    func playMetronomeAudio() {
        let url: URL
        
        if count == 1 {
            guard let soundPath = Bundle.main.path(forResource: "stick_low", ofType: "mp3") else { return }
            url = URL(fileURLWithPath: soundPath)
        } else {
            guard let soundPath = Bundle.main.path(forResource: "stick", ofType: "mp3") else { return }
            url = URL(fileURLWithPath: soundPath)
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            
            print(count)
            print("played")
        } catch {
            print(error)
        }
    }
    
    func updateCount() {
        count += 1
        if count > 4 {
            count = 1
        }
    }
    
    @objc func fireTimer() {
        updateCount()
        playMetronomeAudio()
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        if isPlay {
            isPlay = false
            stopTimer()
            playButtonImage.image = UIImage(systemName: "play.circle.fill")
        } else {
            isPlay = true
            playMetronomeAudio()
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

