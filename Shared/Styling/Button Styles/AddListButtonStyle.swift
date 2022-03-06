//
//  AddListButtonStyle.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/5/22.
//

import SwiftUI

struct AddListButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(RoundedRectangle(cornerRadius: 15))
            .frame(width: 120, height: 120)
            .background(
                Group {
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("Surface"))
                            .frame(width: 120, height: 120)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color("InnerShadow"), lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(RoundedRectangle(cornerRadius: 15).fill(LinearGradient(colors: [Color("InnerShadow"), Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                                         )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color("InnerGlare"), lineWidth: 8)
                                            .blur(radius: 2)
                                            .offset(x: -2, y: -2)
                                            .mask(RoundedRectangle(cornerRadius: 15).fill(LinearGradient(colors: [Color.clear, Color("InnerGlare")], startPoint: .topLeading, endPoint: .bottomTrailing)))
                                    )
                            )
                    } else {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("Surface"))
                            .frame(width: 120, height: 120)
                            .shadow(color: Color("OuterShadow"), radius: 4, x: 4, y: 4)
                            .shadow(color: Color("OuterGlare"), radius: 2, x: -2, y: -2)
                    }
                }
            )
    }
}
