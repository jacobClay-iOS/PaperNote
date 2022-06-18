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
            
            leftSideContent
            
            Spacer()
            
            // MARK: Alert Symbols
            if event.repeatInterval != nil {
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

extension EventCardView {
    
    // MARK: Date and Text
    private var leftSideContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(event.isAllday ? "All Day" : calendarVM.displayEventTime(event: event))
                .customFontCaptionRegular()
                .foregroundColor(.secondary)
            Text(event.title)
                .customFontBodyRegular()
                .foregroundColor(.primary)
        }
        .padding(.leading, 18)
        
        // MARK: Color Tab
        .background(
            HStack {
                switch event.eventType {
                case .holiday:
                    RoundedRectangle(cornerRadius: .infinity)
                        .foregroundColor(.yellow)
                        .frame(width: 4)
                    Spacer()
                case .birthday:
                    RoundedRectangle(cornerRadius: .infinity)
                        .foregroundColor(.purple)
                        .frame(width: 4)
                    Spacer()
                case.work:
                    RoundedRectangle(cornerRadius: .infinity)
                        .foregroundColor(.red)
                        .frame(width: 4)
                    Spacer()
                case.personal:
                    RoundedRectangle(cornerRadius: .infinity)
                        .foregroundColor(.green)
                        .frame(width: 4)
                    Spacer()
                default:
                    RoundedRectangle(cornerRadius: .infinity)
                        .foregroundColor(.secondary.opacity(0.4))
                        .frame(width: 4)
                    Spacer()
                }
                
            }
        )
    }
    
    
}

struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                NeumorphicBackground()
                EventCardView(event: CalendarEvent(title: "Sample Event", date: Date.now, isAllday: true, isWithAlert: false, eventType: .holiday, repeatInterval: .year))
            }
            ZStack {
                NeumorphicBackground()
                EventCardView(event: CalendarEvent(title: "Happy birthday!! :)", date: Date.now, isAllday: true, isWithAlert: true, eventType: .birthday))
            }
            ZStack {
                NeumorphicBackground()
                EventCardView(event: CalendarEvent(title: "......dark mode eventwith a lot of text and stuff", date: Date.now, isAllday: true, isWithAlert: true))
            }
            .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 350, height: 150))
        .environmentObject(CalendarVm())
    }
}

