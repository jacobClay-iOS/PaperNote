//
//  Prototyping.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/25/22.
//

import SwiftUI


struct Prototyping: View {

     @State var timeText = ""
    @State var sampleDate = Date()
    var colors = ["Red", "Green", "Blue", "Tartan"]
        @State private var selectedColor = "Red"
    @State var hours = 0
    @State var minutes = 0
    let date = Date.now
    let removal = 8
    
    var id: String {
        date.description.components(separatedBy: " ")[0].replacingOccurrences(of: "-", with: "")
    }
    
    var body: some View {
        VStack {
            Button {
                print("Balls")
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
            }
            .buttonStyle(AddListButtonStyle())
            .padding()
            
            Button {
                print("Balls")
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
            }
            .buttonStyle(AddNoteButtonStyle())
            
            Text("Content")
                .contextMenu {
                    Button {
                        
                    } label: {
                        Text("Balls")
                    }

                }
        }
            
        
//        VStack {
//            SunkenTextField(textField: TextField("Time", text: $timeText))
//                .frame(width: 100)
//
//            DatePicker("Title", selection: $sampleDate, displayedComponents: .hourAndMinute)
//                .datePickerStyle(.wheel)
//                .frame(height: 300)
//            Text("\(sampleDate.description)")
//
//            HStack {
//                            Picker("", selection: $hours){
//                                ForEach(0..<4, id: \.self) { i in
//                                    Text("\(i) hours").tag(i)
//                                }
//                            }.pickerStyle(.wheel)
//                    .frame(width: 100)
//                            Picker("", selection: $minutes){
//                                ForEach(0..<60, id: \.self) { i in
//                                    Text("\(i) min").tag(i)
//                                }
//                            }
//                            .frame(width: 150)
//                            .pickerStyle(.wheel)
//
//            }
            
//            Picker(selection: $selectedColor) {
//                ForEach(colors, id: \.self) {
//                    Text($0)
//                }
//            } label: {
//                Text("You selected \(selectedColor)")
//            }
//            .pickerStyle(.wheel)
//            .frame(width: 100)
//            .clipped()
//            Picker(selection: $selectedColor) {
//                ForEach(colors, id: \.self) {
//                    Text($0)
//                }
//            } label: {
//                Text("You selected \(selectedColor)")
//            }
//            .pickerStyle(.wheel)
//            .frame(width: 100)
//            .clipped()
//        }
    }
    


}

struct Prototyping_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeumorphicBackground()
            Prototyping()
//                .preferredColorScheme(.dark)
        }
    }
}
