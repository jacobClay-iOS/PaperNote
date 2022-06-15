//
//  ExpandedEventView.swift
//  PaperNote
//
//  Created by Jacob Clay on 6/14/22.
//

import SwiftUI

struct ExpandedEventView: View {
    @EnvironmentObject var calendarVM: CalendarVm
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if calendarVM.isDateToday(calendarVM.highlightedDay) {
                    Text("Today")
                } else if calendarVM.isDateTomorrow(calendarVM.highlightedDay) {
                    Text("Tomorrow")
                } else if calendarVM.isDateYesterday(calendarVM.highlightedDay){
                    Text("Yesterday")
                } else {
                    Text(calendarVM.displaySelectedDay())
                }
                
                Spacer()
                Button { withAnimation { calendarVM.isEventViewExpanded = false } }
                  label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }

                
            }
            .customFontTitleBold()
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity , alignment: .leading)
            .padding(.vertical, 10)
            .background(
                Color("Surface").ignoresSafeArea()
                    .shadow(color: Color("OuterShadow"), radius: 4, y: 3)
            )
            
            
            if let selectedDaysEvents = calendarVM.totalCollectionOfEvents.first(where: { value in
                return calendarVM.isSameDay(date1: value.date, date2: calendarVM.highlightedDay)
            }) {
                VStack {
                    ScrollView(showsIndicators: false) {
                        ForEach(selectedDaysEvents.todaysEvents.sorted(by: <)) { event in
                            EventCardView(event: event)
                                .padding(.top, 15)
                        }
                        
                        .padding(.bottom, 65)
                        
                    }
                    
                }
            } else {
                ScrollView(showsIndicators: false) {
                    Text("No events")
                        .customFontBodyRegular()
                        .foregroundColor(.secondary)
                        .padding(.top)
                }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                withAnimation { calendarVM.isShowingAddEventView = true } }
        label: {
            Image(systemName: "plus")
                .font(.headline)
        }
        .buttonStyle(AddEventButtonStyle())
        .padding()
        .padding(.horizontal)
        }
    }
}

struct ExpandedEventView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedEventView()
            .environmentObject(CalendarVm())
    }
}
