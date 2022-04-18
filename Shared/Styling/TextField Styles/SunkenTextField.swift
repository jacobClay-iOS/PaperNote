//
//  SunkenTextField.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/20/22.
//

import SwiftUI

struct SunkenTextField: View {
    var textField: TextField<Text>
    var body: some View {
        
        textField
            .customFontBodyRegular()
            .padding()
            .foregroundColor(.primary)
            .multilineTextAlignment(.leading)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(colors: [Color("Surface"), Color("OuterGlare")], startPoint: .top, endPoint: .bottom))
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color("Surface"))
                        .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("OuterShadow"), lineWidth: 3)
                            .blur(radius: 3)
                            .offset(x: 2, y: 2)
                            .mask(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(LinearGradient(colors: [Color("InnerShadow"), Color.clear], startPoint: .top, endPoint: .bottom))
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("OuterShadow"), lineWidth: 3)
                                .blur(radius: 3)
                                .offset(x: 2, y: 2)
                                .mask(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(LinearGradient(colors: [Color("InnerShadow"), Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                                )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("OuterGlare"), lineWidth: 2)
                                .blur(radius: 2)
                                .offset(x: -1, y: -1)
                                .mask(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(LinearGradient(colors: [Color.clear, Color("InnerShadow")], startPoint: .top, endPoint: .bottom))
                                )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("OuterGlare"), lineWidth: 2)
                                .blur(radius: 2)
                                .offset(x: -1, y: -1)
                                .mask(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(LinearGradient(colors: [Color.clear, Color("InnerShadow")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                )
                        )
                        .padding(1)
                }
            )
    }
}
