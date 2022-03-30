//
//  SunkenTextEditor.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/20/22.
//

import SwiftUI

struct SunkenTextEditor: View {
    @FocusState private var todoFieldFocus: activeField?
    var textField: TextEditor
    var placeHolder: String
    
    enum activeField {
        case primaryTask
        case notesTextEditor
    }
    
    init(textField: TextEditor, placeHolderText: String) {
        self.textField = textField
        UITextView.appearance().backgroundColor = .clear
        self.placeHolder = placeHolderText
    }
    
    var body: some View {
        
        textField
            .customFontBodyRegular()
            .focused($todoFieldFocus, equals: .notesTextEditor)
            .padding(.horizontal, 13)
            .padding(.vertical, 10)
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
                                .stroke(Color("OuterGlare"), lineWidth: 2)
                                .blur(radius: 2)
                                .offset(x: -2, y: -2)
                                .mask(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(LinearGradient(colors: [Color.clear, Color("InnerShadow")], startPoint: .top, endPoint: .bottom))
                                )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("OuterGlare"), lineWidth: 4)
                                .blur(radius: 4)
                                .offset(x: -2, y: -2)
                                .mask(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(LinearGradient(colors: [Color.clear, Color("InnerShadow")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("OuterShadow"), lineWidth: 2)
                                .blur(radius: 2)
                                .offset(x: 2, y: 2)
                                .mask(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(LinearGradient(colors: [Color("InnerShadow"), Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                                )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("OuterShadow"), lineWidth: 4)
                                .blur(radius: 4)
                                .offset(x: 2, y: 2)
                                .mask(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(LinearGradient(colors: [Color("InnerShadow"), Color.clear], startPoint: .top, endPoint: .bottom))
                                )
                        )
                        .padding(2)
                }
            )
            .overlay(
                Text(placeHolder)
                    .customFontBodyRegular()
                    .foregroundColor(.secondary)
                    .opacity(0.5)
                    .padding()
                    .padding(.top, 2)
                    .padding(.leading, 1)
                    .onTapGesture(perform: { todoFieldFocus = .notesTextEditor })
                , alignment: .topLeading)
        
    }
}
