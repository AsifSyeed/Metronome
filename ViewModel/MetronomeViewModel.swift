//
//  MetronomeViewModel.swift
//  Metronome
//
//  Created by Asif Syeed on 6/11/23.
//

import Foundation
import SwiftUI
import Combine

class MetronomeViewModel: ObservableObject {
    @Published var metronome: Metronome
    @Published var buttonLabel: String = "Start"
    @Published var tempo: Int = 180
    
    @Published var activeBeatIndex: Int = -1
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        metronome = Metronome(tempo: 180, count: 0, countLimit: 4, isPlaying: false)
        subscribeToCountChange()
        subscribeToTempoChange()
    }
    
    func subscribeToCountChange() {
        metronome.countChange
            .sink { [weak self] _ in
                // Update any properties or perform actions when the count changes
                // For example, you can update activeBeatIndex here
                self?.updateActiveBeatIndex()
                
                // Notify the view model's subscribers about the change
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    func subscribeToTempoChange() {
        metronome.tempoChange
            .sink { [weak self] _ in
                self?.updateTempo()
                
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    func updateTempo() {
        tempo = metronome.tempo
    }
    
    func updateActiveBeatIndex() {
        activeBeatIndex = metronome.count - 1
        print("Current Beat: \(activeBeatIndex)")
    }
    
    var isPlaying: Bool {
        return metronome.isPlaying
    }
    
    var tempoText: String {
        return String(tempo)
    }
    
    var countLabelText: String {
        return "\(metronome.count)/\(metronome.countLimit)"
    }
    
    var playButtonImageName: String {
        return metronome.isPlaying ? "pause.fill" : "play.fill"
    }
    
    func togglePlayPause() {
        if metronome.isPlaying {
            metronome.stopMetronome()
        } else {
            metronome.startMetronome()
        }
        
        objectWillChange.send()
    }
    
    func incrementTempo() {
        metronome.tempo += 1
        metronome.stopMetronome()
        metronome.startMetronome()
    }
    
    func decrementTempo() {
        metronome.tempo -= 1
        metronome.stopMetronome()
        metronome.startMetronome()
    }
    
    func incrementCountLimit() {
        metronome.countLimit += 1
    }
    
    func decrementCountLimit() {
        metronome.countLimit -= 1
    }
}
