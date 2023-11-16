//
//  MetronomeApp.swift
//  Metronome
//
//  Created by Asif Syeed on 6/11/23.
//

import SwiftUI

@main
struct MetronomeApp: App {
    @StateObject var viewModel = MetronomeViewModel() // Create the view model
    
    var body: some Scene {
        WindowGroup {
            MetronomeView(viewModel: viewModel) // Pass the view model as an argument
        }
    }
}
