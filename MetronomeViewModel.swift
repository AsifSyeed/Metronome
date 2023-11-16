//
//  MetronomeViewModel.swift
//  Metronome
//
//  Created by Asif Syeed on 6/11/23.
//

import Foundation
import SwiftUI

class MetronomeViewModel: ObservableObject {
    @Published var metronome: Metronome
    @Published var buttonLabel: String = "Start"
    
    init() {
        metronome = Metronome(tempo: 60, count: 1, countLimit: 4, isPlaying: false)
    }
    
    var tempoText: String {
        return String(metronome.tempo)
    }
    
    var countLabelText: String {
        return "\(metronome.count)/\(metronome.countLimit)"
    }
    
    var playButtonImageName: String {
        return metronome.isPlaying ? "pause.circle.fill" : "play.circle.fill"
    }
    
    func togglePlayPause() {
        if metronome.isPlaying {
            metronome.stopMetronome()
        } else {
            metronome.startMetronome()
        }
    }
    
    func incrementTempo() {
        metronome.tempo += 1
    }
    
    func decrementTempo() {
        metronome.tempo -= 1
    }
    
    func incrementCountLimit() {
        metronome.countLimit += 1
    }
    
    func decrementCountLimit() {
        metronome.countLimit -= 1
    }
}
