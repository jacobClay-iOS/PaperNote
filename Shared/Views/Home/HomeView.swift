//
//  HomeView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/26/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var calendarVM = CalendarVm()
    @StateObject var taskCollectionVM = TaskCollectionVM()
    var body: some View {
        ZStack {
            NeumorphicBackground()
            VStack {
                CalendarView()
                
            }
//            .ignoresSafeArea(.all, edges: .horizontal)
            
            if !calendarVM.isShowingASheet && !calendarVM.isEventViewExpanded {
                TaskCollectionView(startingOffsetY: $taskCollectionVM.startingOffsetY, currentDragOffsetY: $taskCollectionVM.currentDragOffsetY, hiddenOffsetY: $taskCollectionVM.hiddenOffsetY)
                    .transition(.move(edge: .bottom))
            }
                
           
            
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .environmentObject(calendarVM)
        .environmentObject(taskCollectionVM)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            
    }
}
