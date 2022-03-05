//
//  ProtoProgressCard.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/4/22.
//

import SwiftUI

struct ProtoProgressCard: View {
    @State var completed: CGFloat = 2
    @State var total: CGFloat = 10
   
    var percent: CGFloat {
       1 - (completed / total)
    }
    
    
    
    var body: some View {
        ZStack {
            NeumorphicBackground()
            
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Title")
                        .customFontCaptionBold()
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
                HStack {
                    Text("\(completed, specifier: "%.f")/\(total, specifier: "%.f")")
                        .customFontCaptionRegular()
                        .foregroundColor(.primary)
                    Spacer()
                }
            }
            .padding(25)
            .frame(width: 120, height: 120)
            .background(
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("Surface"))
                        .shadow(color: Color("OuterShadow"), radius: 2, x: 4, y: 4)
                        .shadow(color: Color("OuterGlare"), radius: 2, x: -2, y: -2)
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.gray, lineWidth: 5)
                        .opacity(0.1)
                        .padding(10)
                    RoundedRectangle(cornerRadius: 12)
                        .trim(from: percent, to: 1)
                        .stroke(Color.green, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                        .rotationEffect(Angle(degrees: 90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
//                        .shadow(color: .green, radius: 4)
                        .padding(12)
                }
            )
        }
    }
}

struct ProtoProgressCard_Previews: PreviewProvider {
    static var previews: some View {
        ProtoProgressCard()
            .preferredColorScheme(.dark)
    }
}
