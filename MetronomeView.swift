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
    @State private var numberOfItem = 4
    
    var body: some View {
        ZStack {
            CustomColors.backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    ForEach(0..<numberOfItem) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 50, height: 50)
                            .foregroundColor(CustomColors.inactiveTileColor)
                            .padding()
                    }
                }
                .padding()
                HStack {
                    Image(systemName: "minus")
                        .foregroundColor(CustomColors.activeTileColor)
                        .frame(width: 80, height: 80)
                    Text("150")
                        .foregroundColor(CustomColors.textColor)
                        .font(.system(size: 100, weight: .bold))
                    Image(systemName: "plus")
                        .foregroundColor(CustomColors.activeTileColor)
                        .frame(width: 80, height: 80)
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
