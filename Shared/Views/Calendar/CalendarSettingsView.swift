//
//  CalendarSettingsView.swift
//  PaperNote
//
//  Created by Jacob Clay on 4/30/22.
//

import SwiftUI

struct CalendarSettingsView: View {
    @EnvironmentObject var calendarVM: CalendarVm
    @State var settingsViewDragOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 10) {
                DragGestureTab()
                header
                Rectangle()
                    .frame(height: 400)
            }
            .padding(.horizontal)
            .padding(.bottom)
            .padding(.bottom)
            .background(Color("Surface"))
            .customCornerRadius(25, corners: [.topRight, .topLeft])
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .offset(y: settingsViewDragOffset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.spring()) {
                        settingsViewDragOffset = value.translation.height
                    }
                }
                .onEnded { value in
                    withAnimation(.spring()) {
                        if settingsViewDragOffset > 40 {
                            withAnimation {
                                calendarVM.isShowingCalendarSettings = false
                            }
                        }
                        settingsViewDragOffset = 0
                    }
                    
                }
        )
    }
}

extension CalendarSettingsView {
    private var header: some View {
        HStack {
            Text("Settings")
                .customFontHeadline()
                .foregroundColor(.primary)
            Spacer()
        }
    }
}

struct CalendarSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeumorphicBackground()
            CalendarSettingsView()
        }
        .environmentObject(CalendarVm())
    }
}
