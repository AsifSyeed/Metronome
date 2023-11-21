//
//  MetronomeView.swift
//  Metronome
//
//  Created by Asif Syeed on 6/11/23.
//

import SwiftUI

struct MetronomeView: View {
    @ObservedObject var viewModel: MetronomeViewModel
    @State private var playButtonImageName: String = ""
    
    let spacing: CGFloat = 10
    @State private var numberOfItems = 4
    
    var body: some View {
        ZStack {
            CustomColors.backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    ForEach(0..<numberOfItems) { index in
                        BeatView(isActive: index == viewModel.activeBeatIndex)
                    }
                }
                .padding()
                HStack {
                    Button(action: {
                        viewModel.decrementTempo()
                    }) {
                        Image(systemName: "minus")
                            .foregroundColor(CustomColors.activeTileColor)
                            .frame(width: 80, height: 80)
                            .aspectRatio(contentMode: .fill)
                    }
                    Text(viewModel.tempoText)
                        .foregroundColor(CustomColors.textColor)
                        .font(.system(size: 100, weight: .bold))
                    Button(action: {
                        viewModel.incrementTempo()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(CustomColors.activeTileColor)
                            .frame(width: 80, height: 80)
                            .aspectRatio(contentMode: .fill)
                    }
                }
                Button(action: {
                    viewModel.togglePlayPause()
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 150, height: 60)
                        .foregroundColor(CustomColors.activeTileColor)
                        .overlay(
                            Image(systemName: playButtonImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.black)
                                .padding(10)
                        )
                }
                .onAppear {
                    playButtonImageName = viewModel.playButtonImageName
                }
                .onChange(of: viewModel.playButtonImageName) { newValue in
                    playButtonImageName = newValue
                }
                Spacer()
            }
        }
    }
}
