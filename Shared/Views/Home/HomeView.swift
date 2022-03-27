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
                Spacer()
                
                TaskCollectionView()
                    
            }
            .padding(.top, 45)
            .padding(.bottom, 20)
            .ignoresSafeArea()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
