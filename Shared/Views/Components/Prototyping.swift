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
            VStack {
                Text("Hello, World!")
                    .font(.callout.bold())
                Text("Hello, World!")
                    .font(.body.bold())
                Text("Hello, World!")
                    .font(.headline)
                Text("Hello, World!")
                    .font(.headline)
                Text("Hello, World!")
                    .font(.caption.bold())
                Text("Hello, World!")
                    .font(Font.custom("RedHatText-Bold", size: 16))
            }
            .padding()
            VStack {
                Text("Hello, World!")
                    .font(.callout)
                    .fontWeight(.medium)
                Text("Hello, World!")
                    .font(Font.custom("RedHatText-Medium", size: 16))
            }
            .padding()
            VStack {
                Text("Hello, World!")
                    .font(.callout)
                    .fontWeight(.light)
                Text("Hello, World!")
                    .font(Font.custom("RedHatText-Light", size: 16))
            }
            .padding()
            
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.75)
        }
    }
}

struct Prototyping_Previews: PreviewProvider {
    static var previews: some View {
        Prototyping()
    }
}
