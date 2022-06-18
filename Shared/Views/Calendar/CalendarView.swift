//
//  CalendarView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/24/22.
//

import SwiftUI

struct CalendarView: View {
//    @StateObject var calendarVM = CalendarVm()
    @Environment(\.scenePhase) private var scenePhase
    @State var addEventDragOffset: CGFloat = 0
    @EnvironmentObject var calendarVM: CalendarVm
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                if !calendarVM.isEventViewExpanded {
                VStack {
                    header
                        .padding(.horizontal)
                        .padding(.bottom, 4)
                        .padding(.top, 5)
                        .background(
                            Color("Surface").ignoresSafeArea()
                                .shadow(color: Color("OuterShadow"), radius: 4, y: 3)
                        )
                        
                        
                    VStack(spacing: 5) {
                        dayOfTheWeekRow
                            .padding(.horizontal, 2)
                            .padding(.top, 4)
                            calendar
                                
                        }
                        
                    }
                .transition(.move(edge: .top))
                }
                
                if !calendarVM.hideEventView {
                    eventView
                        .padding(.horizontal)
                }
                Spacer()
            }
            .opacity(calendarVM.isShowingASheet ? 0.5 : 1.0)
            .disabled(calendarVM.isShowingASheet)
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
//                    if !calendarVM.isShowingAddEventView {
                        calendarVM.refreshCurrentDate()
//                    }
                } else if newPhase == .inactive {
                    
                } else if newPhase == .background {
                    calendarVM.isShowingAddEventView = false
                    
                    calendarVM.resetCalendar()
                }
        }
            
            ZStack {
                if calendarVM.isShowingAddEventView {
                    AddEventView(eventDate: $calendarVM.highlightedDay)
                        .transition(.move(edge: .bottom))
                }
                if calendarVM.isShowingCalendarSettings {
                    CalendarSettingsView()
                        .transition(.move(edge: .bottom))
                }
            }
            .zIndex(2)
            
//            ZStack {
//                if calendarVM.isShowingCalendarSettings {
//                    CalendarSettingsView()
//                        .transition(.move(edge: .bottom))
//                }
//            }
//            .zIndex(2)
        }
       
//        .environmentObject(calendarVM)
    }
    

    

    
}

extension CalendarView {
    private var header: some View {
        HStack(spacing: 15) {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text(calendarVM.displaySelectedMonthAndYear()[1])
                    .customFontTitleBold()
                if calendarVM.isMonthNotInCurrentYear() {
                    Text(calendarVM.displaySelectedMonthAndYear()[0])
                        .customFontCaptionBold()
                }
            }
            Spacer()
            
            Button { withAnimation {  }
            } label: {
                Text("Get Pro")
                    .foregroundColor(.secondary)
                    .customFontCaptionBold()
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .background(
                        Capsule()
                            .stroke(lineWidth: 2)
                            .fill(Color.secondary)
                    )
            }
            .buttonStyle(.plain)
            
            Button { withAnimation { calendarVM.isShowingCalendarSettings.toggle() }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title2)
                    .overlay(
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.secondary.opacity(0.000001))
                    )
            }
            .buttonStyle(.plain)
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
                            .padding(.bottom, -7)
                            .opacity(calendarVM.isSameDay(date1: value.date, date2: calendarVM.currentDay) ? 1 : 0)
                    )
                    .onTapGesture { calendarVM.highlightedDay = value.date }
            }
            
        }
        .padding(.horizontal, 6)
        .offset(x: addEventDragOffset)
        .onChange(of: calendarVM.userSelectedMonth) { newValue in
            // updating month
            calendarVM.userSelectedDate = calendarVM.getCurrentMonth()
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.linear(duration: 0.01)) {
                      
                        addEventDragOffset = value.translation.width
                    }
                }
                .onEnded { value in
                    if addEventDragOffset < -80 {
                        calendarVM.userSelectedMonth += 1
                    } else if addEventDragOffset > 80  {
                        calendarVM.userSelectedMonth -= 1
                    }
                    addEventDragOffset = 0
                }
        )
    }
    
    //    @ViewBuilder
    private func CalendarDayView(value: CalendarDate) -> some View {
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
                
                if calendarVM.totalCollectionOfEvents.first(where: { event in
                    return calendarVM.isSameDay(date1: event.date, date2: value.date)
                }) != nil {
    
                    Circle()
                        .fill(Color("AccentEnd"))
                        .frame(width: 7, height: 7)
                        .offset(y: calendarVM.isSameDay(date1: value.date, date2: calendarVM.highlightedDay) ? -2 : 0)
                        
                } else {
                    Circle()
                        .fill(Color("AccentEnd"))
                        .frame(width: 7, height: 7)
                        .offset(y: calendarVM.isSameDay(date1: value.date, date2: calendarVM.highlightedDay) ? -2 : 0)
                        .opacity(0.0)
                }
            }
                
        }
        .padding(.vertical, 8)
        .frame(
            minHeight: UIScreen.main.bounds.height * 0.055, idealHeight: UIScreen.main.bounds.height * 0.065, maxHeight: UIScreen.main.bounds.height * 0.075,
            alignment: .top)
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
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    withAnimation { calendarVM.isShowingAddEventView = true } }
            label: {
                Image(systemName: "plus")
                    .font(.headline)
            }
            .buttonStyle(AddEventButtonStyle())
            }
            .customFontHeadline()
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity , alignment: .leading)
            .padding(.vertical, 10)
            
            
            if let selectedDaysEvents = calendarVM.totalCollectionOfEvents.first(where: { value in
                return calendarVM.isSameDay(date1: value.date, date2: calendarVM.highlightedDay)
            }) {
                VStack {
                    ScrollView(showsIndicators: false) {
                        ForEach(selectedDaysEvents.todaysEvents.sorted(by: <)) { event in
                            EventCardView(event: event)
                                .padding(.top, 15)
                        }
                        Divider()
                            .frame(maxWidth: 120)
                            .padding(.top, 160)
                        Button {
                            withAnimation {
                                
                                calendarVM.isEventViewExpanded.toggle()
                            }
                        } label: {
                            Text(calendarVM.isEventViewExpanded ? "Close" : "Expand")
                                .customFontBodyLight()
                                .foregroundColor(.secondary)
                                
                        }
                        .buttonStyle(.plain)
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
    
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        guard let firstDay = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else { return Date() }
        return firstDay
    }
    
    
    func currentDayNumber() -> Int {
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: self)
        return currentDay
    }
    
    
}



struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeumorphicBackground()
            VStack {
                CalendarView()
            }
            .environmentObject(CalendarVm())
                .preferredColorScheme(.dark)
        }
    }
}
