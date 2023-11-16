//
//  MetronomeView.swift
//  Metronome
//
//  Created by Asif Syeed on 6/11/23.
//

import SwiftUI

struct MetronomeView: View {
    @ObservedObject var viewModel: MetronomeViewModel
    
    let spacing: CGFloat = 10
    @State private var numberOfItem = 4
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    HStack {
                        ForEach(0..<numberOfItem) { index in
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.white)
                                .padding()
                        }
                    }
                    .padding()
                }
                .navigationBarTitle("Metronome", displayMode: .large)
            }
        }
        .background(Color.green)
    }
}


struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView(viewModel: MetronomeViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
