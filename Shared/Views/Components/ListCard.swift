//
//  ListCard.swift
//  PaperNote
//
//  Created by Jacob Clay on 2/24/22.
//

import SwiftUI

struct ListCard: View {
    var collectionListItem: TaskList
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(collectionListItem.name)
                    .customFontCaptionBold()
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            Spacer()
            HStack {
                Text("\(collectionListItem.completedTaskCount, specifier: "%.f")/\(collectionListItem.totalTaskCount, specifier: "%.f")")
                    .customFontCaptionRegular()
                    .foregroundColor(.primary)
                Spacer()
            }
        }
        .padding()
        .frame(width: 120, height: 120)
        .background(
            Color("Surface")
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: Color("OuterShadow"), radius: 4, x: 2, y: 2)
                .shadow(color: Color("OuterGlare"), radius: 2, x: -2, y: -2)
        )
    }
}

//RoundedRectangle(cornerRadius: 15)
//    .fill(Color("Surface"))
//    .frame(width: 100, height: 100)
//    .shadow(color: Color("OuterShadow"), radius: 4, x: 4, y: 4)
//    .shadow(color: Color("OuterGlare"), radius: 2, x: -4, y: -4)

struct ListCard_Previews: PreviewProvider {
    static var previews: some View {
        ListCard(collectionListItem: TaskList(name: "GroceryList", list: [TaskItem(name: "eggs", note: "2 dozen")]))
    }
}
