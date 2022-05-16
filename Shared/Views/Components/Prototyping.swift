//
//  Prototyping.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/25/22.
//

import SwiftUI


struct Prototyping: View {

     
    var colors = ["Red", "Green", "Blue", "Tartan"]
        @State private var selectedColor = "Red"
     
    let date = Date.now
    let removal = 8
    
    var id: String {
        date.description.components(separatedBy: " ")[0].replacingOccurrences(of: "-", with: "")
    }
    
    var body: some View {
        VStack {
            Text(date.description.drop(while: { char in
                char != " "
            }))
            
            Text(id)
                
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
        }
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
