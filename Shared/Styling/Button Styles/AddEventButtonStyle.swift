//
//  AddEventButtonStyle.swift
//  PaperNote
//
//  Created by Jacob Clay on 4/5/22.
//

import SwiftUI

struct AddEventButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 24)
            .padding(.vertical, 6)
            .background(
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Surface"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("InnerShadow"), lineWidth: 2)
                                    .blur(radius: 2)
                                    .offset(x: 2, y: 2)
                                    .mask(RoundedRectangle(cornerRadius: 8).fill(LinearGradient(colors: [Color("InnerShadow"), Color.clear], startPoint: .topLeading, endPoint: .topTrailing))
                                         )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("InnerGlare"), lineWidth: 2)
                                    .blur(radius: 1)
                                    .offset(x: -1, y: -1)
                                    .mask(RoundedRectangle(cornerRadius: 8).fill(LinearGradient(colors: [Color.clear, Color("InnerGlare")], startPoint: .topLeading, endPoint: .bottomTrailing)))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("InnerGlare"), lineWidth: 2)
                                    .blur(radius: 1)
                                    .offset(x: -1, y: -1)
                                    .mask(RoundedRectangle(cornerRadius: 8).fill(LinearGradient(colors: [Color.clear, Color("InnerGlare")], startPoint: .bottomTrailing, endPoint: .bottomLeading)))
                            )
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Surface"))
                            
                            
                            .shadow(color: Color("OuterGlare"), radius: 0.5, x: -0.5, y: -0.5)
                            .shadow(color: Color("OuterGlare"), radius: 0.5, x: -0.5, y: -0.5)
                            .shadow(color: Color("OuterGlare"), radius: 0.5, x: -0.5, y: -0.5)
                            .shadow(color: Color("OuterShadow"), radius: 2, x: 2, y: 2)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 15)
//                                    .strokeBorder( LinearGradient(gradient: Gradient(stops: [
//                                        Gradient.Stop(color: Color("OuterGlare"), location: 0.3),
//                                        Gradient.Stop(color: Color("Surface"), location: 0.5),
//                                    ]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2, antialiased: true)
//                        )
                    }
                }
            )
    }
}
