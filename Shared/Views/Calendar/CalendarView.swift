//
//  CalendarView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/24/22.
//

import SwiftUI

struct CalendarView: View {
    @StateObject var calendarVM = CalendarVm()
    @Environment(\.scenePhase) private var scenePhase
    @State var currentDragOffsetX: CGFloat = 0
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                header
                    .padding(.horizontal)
                    .padding(.bottom, -5)
                    .padding(.top, 5)
                    
                VStack(spacing: 5) {
                    dayOfTheWeekRow
                        .padding(.horizontal, 2)
                    calendar
                        
                }
                if !calendarVM.isShowingAddEventView {
                    eventView
                        .padding(.horizontal)
                } 
                Spacer()
            }
            
               
            
            .opacity(calendarVM.isShowingAddEventView ? 0.5 : 1.0)
            .disabled(calendarVM.isShowingAddEventView ? true : false)
            .onChange(of: calendarVM.userSelectedMonth) { newValue in
                // updating month
                calendarVM.userSelectedDate = calendarVM.getCurrentMonth()
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    calendarVM.refreshCurrentDate()
                } else if newPhase == .inactive {
                    
                } else if newPhase == .background {
                    calendarVM.resetCalendar()
                }
        }
            
            ZStack {
                if calendarVM.isShowingAddEventView {
                    AddEventView(
//                        displayDate: calendarVM.highlightedDay,
                        eventDate: $calendarVM.highlightedDay)
                        .transition(.move(edge: .bottom))
                }
            }
            .zIndex(2)
        }
       
        .environmentObject(calendarVM)
    }
    
    @ViewBuilder
    func CalendarDayView(value: CalendarDate) -> some View {
        VStack {
            if value.day != -1 {
                if calendarVM.isSameDay(date1: value.date, date2: calendarVM.highlightedDay) {
                    Text("\(value.day)")
                        .customFontTitle2Bold()
                        .foregroundColor(Color("AccentStart"))
                        .frame(maxWidth: .infinity)
                        .offset(y: -1)
                    Spacer()
                } else {
                    Text("\(value.day)")
                        .customFontTitle3Medium()
                        .foregroundColor(Color.primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                
                if sampleEvents.first(where: { event in
                    return calendarVM.isSameDay(date1: event.date, date2: value.date)
                }) != nil {
    
                    Circle()
                        .fill(Color("AccentEnd"))
                        .frame(width: 7, height: 7)
                        .offset(y: calendarVM.isSameDay(date1: value.date, date2: calendarVM.highlightedDay) ? -2 : 0)
                        
                }
            }
        }
        .padding(.vertical, 10)
        .frame(
            height: UIScreen.main.bounds.height * 0.062,
            alignment: .top)
    }
    
}

extension CalendarView {
    private var header: some View {
        HStack(alignment: .bottom, spacing: 15) {
            Text(calendarVM.displaySelectedMonthAndYear()[1])
                .customFontTitleBold()
            if calendarVM.isMonthNotInCurrentYear(month: calendarVM.highlightedDay) {
                Text(calendarVM.displaySelectedMonthAndYear()[0])
                    .customFontCaptionBold()
                    .offset(y: -5)
            }
            Spacer()
        }
        .foregroundColor(.primary)
    }
    
    private var dayOfTheWeekRow: some View {
        HStack(spacing: 0) {
            Text("S")
                .frame(maxWidth: .infinity)
            Text("M")
                .frame(maxWidth: .infinity)
            Text("T")
                .frame(maxWidth: .infinity)
            Text("W")
                .frame(maxWidth: .infinity)
            Text("T")
                .frame(maxWidth: .infinity)
            Text("F")
                .frame(maxWidth: .infinity)
            Text("S")
                .frame(maxWidth: .infinity)
        }
        .customFontCaptionBold()
        .foregroundColor(.secondary)
    }
    
    private var calendar: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 5) {
            ForEach(calendarVM.populateCalendarWithDates()) { value in
                CalendarDayView(value: value)
                    
                    .background(
                        currentDayBackground
                            .frame(height: UIScreen.main.bounds.height * 0.068)
                            .opacity(calendarVM.isSameDay(date1: value.date, date2: calendarVM.currentDay) ? 1 : 0)
                    )
                    .onTapGesture { calendarVM.highlightedDay = value.date }
            }
            
        }
        .padding(.horizontal, 6)
        .offset(x: currentDragOffsetX)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.linear(duration: 0.01)) {
                      
                        currentDragOffsetX = value.translation.width
                    }
                }
                .onEnded { value in
                    if currentDragOffsetX < -80 {
                        calendarVM.userSelectedMonth += 1
                    } else if currentDragOffsetX > 80  {
                        calendarVM.userSelectedMonth -= 1
                    }
                    currentDragOffsetX = 0
                }
        )
    }
    
    private var eventView: some View {
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
                Button {
                    withAnimation {
                        calendarVM.isShowingAddEventView = true
                    }
                    
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.primary)
                        .font(.headline)
                }
                .buttonStyle(AddEventButtonStyle())    
            }
            .customFontHeadline()
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity , alignment: .leading)
            .padding(.vertical, 10)
            
            
            if let selectedDaysEvents = sampleEvents.first(where: { value in
                return calendarVM.isSameDay(date1: value.date, date2: calendarVM.highlightedDay)
            }) {
                ScrollView(showsIndicators: false) {
                    ForEach(selectedDaysEvents.todaysEvents) { event in
                        VStack {
                            HStack(spacing: 18) {
//                                VStack(alignment: .leading, spacing: 4) {
                                    // for custom timing
                                
                                // working here
                                
                                Text(calendarVM.displayEventTime(event: event))
                                    .customFontCaptionBold()
                                    .foregroundColor(.secondary)
                                
                                    Text(event.title)
                                        .customFontBodyRegular()
                                        .foregroundColor(.primary)
//                                }
                                
                                Spacer()
//                                Image(systemName: "repeat")
//                                    .font(.headline)
//                                    .foregroundColor(.secondary)
//                                Image(systemName: "bell.slash")
//                                    .font(.headline)
//                                    .foregroundColor(.secondary)
                                
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
                        .padding(.horizontal, 15)
                        }
                        .padding(.top, 15)
                    }
                    .padding(.bottom, 65)
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
    }
    
    private var currentDayBackground: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [Color("Surface"), Color("OuterGlare")], startPoint: .topLeading, endPoint: .bottomTrailing))
                
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("Surface"))
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("OuterShadow"), lineWidth: 3)
                    .blur(radius: 2)
                    .offset(x: 2, y: 2)
                    .mask(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(colors: [Color("InnerShadow"), Color.clear], startPoint: .top, endPoint: .bottom))
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("OuterShadow"), lineWidth: 3)
                        .blur(radius: 2)
                        .offset(x: 2, y: 2)
                        .mask(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(colors: [Color("InnerShadow"), Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("OuterGlare"), lineWidth: 2)
                        .blur(radius: 1)
                        .offset(x: -1, y: -1)
                        .mask(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(colors: [Color.clear, Color("InnerShadow")], startPoint: .top, endPoint: .bottom))
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("OuterGlare"), lineWidth: 2)
                        .blur(radius: 1)
                        .offset(x: -1, y: -1)
                        .mask(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(colors: [Color.clear, Color("InnerShadow")], startPoint: .topLeading, endPoint: .bottomTrailing))
                        )
                )
                .padding(1)
        }
        .offset(y: 6)
    }
    
    
    
}

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        guard let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else { return [Date()] }
        guard let range = calendar.range(of: .day, in: .month, for: self) else { return [Date()] }
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate) ?? Date()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeumorphicBackground()
            VStack {
                CalendarView()
            }
//                .preferredColorScheme(.dark)
        }
    }
}
