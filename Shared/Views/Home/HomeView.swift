//
//  HomeView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/26/22.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack {
            NeumorphicBackground()
            VStack {
                CalendarView()
                    
            }
//            .ignoresSafeArea(.all, edges: .horizontal)
            
            
                TaskCollectionView()
           
            
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
//            .preferredColorScheme(.dark)
            
    }
}
