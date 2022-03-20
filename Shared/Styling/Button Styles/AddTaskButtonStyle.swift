//
//  AddTaskButton.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/19/22.
//

import SwiftUI

struct AddTaskButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(20)
            .contentShape(Circle())
            .background(
                Group {
                    if configuration.isPressed {
                        Circle()
                            .fill(Color("Surface"))
                            .overlay(
                                Circle()
                                    .stroke(Color("InnerShadow"), lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(colors: [Color("InnerShadow"), Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                                         )
                                    .overlay(
                                        Circle()
                                            .stroke(Color("InnerGlare"), lineWidth: 8)
                                            .blur(radius: 2)
                                            .offset(x: -2, y: -2)
                                            .mask(Circle().fill(LinearGradient(colors: [Color.clear, Color("InnerGlare")], startPoint: .topLeading, endPoint: .bottomTrailing)))
                                    )
                            )
                    } else {
                        Circle()
                            .fill(Color("Surface"))
                            .shadow(color: Color("OuterShadow"), radius: 4, x: 4, y: 4)
                            .shadow(color: Color("OuterGlare"), radius: 2, x: -1, y: -1)
                            .overlay(
                                Circle()
                                    .stroke( LinearGradient(gradient: Gradient(stops: [
                                        Gradient.Stop(color: Color("OuterGlare"), location: 0.3),
                                        Gradient.Stop(color: Color("Surface"), location: 0.5),
                                    ]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
                        )
                    }
                }
            )
    }
}
