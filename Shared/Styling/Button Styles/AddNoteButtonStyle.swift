//
//  AddNoteButtonStyle.swift
//  PaperNote
//
//  Created by Jacob Clay on 6/12/22.
//

import SwiftUI

struct AddNoteButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(RoundedRectangle(cornerRadius: 12))
            .frame(width: 160, height: 80)
            .background(
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("Surface"))
                            .frame(width: 160, height: 80)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("InnerShadow"), lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(RoundedRectangle(cornerRadius: 12).fill(LinearGradient(colors: [Color("InnerShadow"), Color.clear], startPoint: .top, endPoint: .bottom))
                                         )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color("InnerGlare"), lineWidth: 8)
                                            .blur(radius: 2)
                                            .offset(x: -2, y: -2)
                                            .mask(RoundedRectangle(cornerRadius: 12).fill(LinearGradient(colors: [Color.clear, Color("InnerGlare")], startPoint: .topLeading, endPoint: .bottomTrailing)))
                                    )
                            )
                    } else {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("Surface"))
                            .frame(width: 160, height: 80)
                            .shadow(color: Color("OuterGlare"), radius: 0.5, x: -0.5, y: -0.5)
                            .shadow(color: Color("OuterGlare"), radius: 0.5, x: -0.5, y: -0.5)
                            .shadow(color: Color("OuterGlare"), radius: 1, x: -1, y: -1)
                            .shadow(color: Color("OuterShadow"), radius: 4, x: 4, y: 6)
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
