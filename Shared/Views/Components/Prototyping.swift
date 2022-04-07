//
//  Prototyping.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/25/22.
//

import SwiftUI

struct Prototyping: View {
    var body: some View {
        VStack {
            
            
            Image("lauchScreenCheckmark")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom)
            
            
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.orange)
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(Color.accentColor)
        }
    }
}

struct Prototyping_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeumorphicBackground()
            Prototyping()
                .preferredColorScheme(.dark)
        }
    }
}
