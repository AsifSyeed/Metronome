//
//  BeatView.swift
//  Metronome
//
//  Created by Asif Syeed on 21/11/23.
//

import SwiftUI

struct BeatView: View {
    let isActive: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 50, height: 50)
            .foregroundColor(isActive ? CustomColors.activeTileColor : CustomColors.inactiveTileColor)
            .padding()
    }
}

struct BeatView_Previews: PreviewProvider {
    static var previews: some View {
        BeatView(isActive: true)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
