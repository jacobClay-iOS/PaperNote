//
//  NotepadTextEditor.swift
//  PaperNote
//
//  Created by Jacob Clay on 6/12/22.
//

import SwiftUI

struct NotepadTextEditor: View {
//    @FocusState private var todoFieldFocus: activeField?
    var textField: TextEditor
//    var placeHolder: String
    
    enum activeField {
        case primaryTask
        case notesTextEditor
    }
    
    init(textField: TextEditor) {
        self.textField = textField
        UITextView.appearance().backgroundColor = .clear
//        self.placeHolder = placeHolderText
    }
    
    var body: some View {
        
        textField
            .customFontBodyRegular()
//            .focused($todoFieldFocus, equals: .notesTextEditor)
//            .padding(.horizontal, 13)
//            .padding(.vertical, 10)
            .foregroundColor(.primary)
            .multilineTextAlignment(.leading)
        
    }
}
