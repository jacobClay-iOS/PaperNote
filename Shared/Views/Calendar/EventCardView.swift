//
//  EventCardView.swift
//  PaperNote
//
//  Created by Jacob Clay on 4/27/22.
//

import SwiftUI

struct EventCardView: View {
    var event: CalendarEvent
    @EnvironmentObject var calendarVM: CalendarVm
    var body: some View {
        HStack(spacing: 18) {

            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.isAllday ? "All Day" : calendarVM.displayEventTime(event: event))
                    .customFontCaptionRegular()
                .foregroundColor(.secondary)
                Text(event.title)
                    .customFontBodyRegular()
                    .foregroundColor(.primary)
            }
            
                

            
            Spacer()
            
            if event.isRepeating {
                Image(systemName: "repeat")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            if event.isWithAlert {
                Image(systemName: "bell")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color("Surface")
                .cornerRadius(10)
                
                .shadow(color: Color("OuterGlare"), radius: 0.5, x: -0.5, y: -0.5)
                .shadow(color: Color("OuterGlare"), radius: 0.5, x: -0.5, y: -0.5)
                .shadow(color: Color("OuterGlare"), radius: 0.5, x: 0, y: -0.5)
                .shadow(color: Color("OuterShadow"), radius: 3, x: 4, y: 4)
        )
    .padding(.horizontal, 12)
    }
}

struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeumorphicBackground()
            EventCardView(event: CalendarEvent(title: "Sample Event", date: Date.now, isAllday: true, isRepeating: true, isWithAlert: true))
        }
        .environmentObject(CalendarVm())
    }
}
