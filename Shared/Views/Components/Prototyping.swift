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
