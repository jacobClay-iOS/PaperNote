//
//  NeumorphicBackground.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/19/22.
//

import SwiftUI

struct NeumorphicBackground: View {
    var body: some View {
        LinearGradient(
            colors: [Color("BackgroundTop"), Color("BackgroundBottom")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct NeumorphicBackground_Previews: PreviewProvider {
    static var previews: some View {
        NeumorphicBackground()
            .preferredColorScheme(.dark)
    }
}
