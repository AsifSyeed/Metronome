//
//  Metronome.swift
//  Metronome
//
//  Created by Asif Syeed on 6/11/23.
//

import Foundation
import AVFoundation
import Combine

class Metronome: ObservableObject {
    var tempo: Int
    var count: Int
    var countLimit: Int
    @Published var isPlaying: Bool {
        didSet {
            didChange.send()
        }
    }
    
    private var timer: Timer?
    private var audioPlayer: AVAudioPlayer?
    var didChange = PassthroughSubject<Void, Never>()
    
    init(tempo: Int, count: Int, countLimit: Int, isPlaying: Bool) {
        self.tempo = tempo
        self.count = count
        self.countLimit = countLimit
        self.isPlaying = isPlaying
    }
    
    func startMetronome() {
        guard !isPlaying else { return } // Don't start if already playing
        isPlaying = true
        
        // Start the timer for the metronome
        let intervalValue: TimeInterval = TimeInterval(60.0 / Double(tempo))
        timer = Timer.scheduledTimer(withTimeInterval: intervalValue, repeats: true) { [weak self] _ in
            self?.fireTimer()
        }
    }
    
    func stopMetronome() {
        isPlaying = false
        
        // Stop the timer
        timer?.invalidate()
        timer = nil
        
        // Reset count
        count = 1
    }
    
    func playMetronomeAudio() {
        let soundFileName: String
        var isAccent = false

        // Determine the sound file based on the count
        if count == 1 {
            soundFileName = "stick_low"
            isAccent = true
        } else {
            soundFileName = "stick"
        }

        if let soundPath = Bundle.main.path(forResource: soundFileName, ofType: "mp3") {
            do {
                let url = URL(fileURLWithPath: soundPath)
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()

                if isAccent {
                    // Handle any special accent logic here
                }

                print(count)
                print("played")
            } catch {
                print(error)
            }
        }
    }

    
    func fireTimer() {
        updateCount()
        playMetronomeAudio()
    }
    
    func updateCount() {
        count += 1
        if count > countLimit {
            count = 1
        }
    }
}
