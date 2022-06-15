//
//  NotepadView.swift
//  PaperNote
//
//  Created by Jacob Clay on 6/12/22.
//

import SwiftUI

struct NotepadView: View {
    
    @State var noteText = ""
    
    var body: some View {
        ZStack {
            NeumorphicBackground()
            VStack {
                
                ZStack {
                    Rectangle()
                        .frame(width: .infinity, height: 60)
                        .shadow(color: Color("OuterShadow"), radius: 8, y: 6)
                    HStack {
                            Text("Notepad")
                                .font(.title)
                            Spacer()
                        }
                        .padding()
                        .background(Color("Surface"))
                    
                   
                }
                    
                
                
               
                    
                
                NotepadTextEditor(textField: TextEditor(text: $noteText))
                    
                    .padding()
            }
        }
    }
}

struct NotepadView_Previews: PreviewProvider {
    static var previews: some View {
        NotepadView()
            .preferredColorScheme(.dark)
    }
}
