//
//  HomeView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/26/22.
//

import SwiftUI

struct HomeView: View {
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.68
    @State var currentDragOffsetY: CGFloat = 0
    @State var hiddenOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            NeumorphicBackground()
            VStack {
                CalendarView()
                Spacer()
                
            }
            .padding(.top, 45)
            .padding(.bottom, 20)
            .ignoresSafeArea()
            
            ZStack {
                dragUpTaskView
            }
            .ignoresSafeArea(edges: .bottom)
            .offset(y: startingOffsetY)
            .offset(y: currentDragOffsetY)
            .offset(y: hiddenOffsetY)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring()) {
                            currentDragOffsetY = value.translation.height
                        }
                    }
                    .onEnded{ value in
                        withAnimation(.spring()) {
                            if currentDragOffsetY > 100 {
                                hiddenOffsetY = 150
                                
                                
                            } else if hiddenOffsetY != 0 && currentDragOffsetY < -40 {
                                hiddenOffsetY = 0
                                
                                    
                                
                            }
                            
                                currentDragOffsetY = 0
                            
                        }
                        
                    }
            )
        }
    }
    
    
    var dragUpTaskView: some View {
        VStack {
            RoundedRectangle(cornerRadius: .infinity)
                .frame(width: 40, height: 6)
                .foregroundColor(.secondary)
                .padding(.top)
            
            TaskCollectionView()
                .padding(.top, 5)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(
            Color("Surface")
                
        )
        .cornerRadius(30)
        .shadow(color: Color("OuterGlare"), radius: 1, x: 0, y: -1)
        .shadow(color: Color("OuterGlare"), radius: 0.5, x: 0, y: -1)
        .shadow(color: Color("OuterGlare"), radius: 0.5, x: 0, y: -1)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            
    }
}
