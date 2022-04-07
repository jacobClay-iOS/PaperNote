//
//  CalendarView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/24/22.
//

import SwiftUI

struct CalendarView: View {
    @StateObject var calendarVM = CalendarVm()
    @Environment(\.scenePhase) var scenePhase
    
    @State var currentDragOffsetX: CGFloat = 0
    
    var body: some View {
            VStack(spacing: 15) {
                header
                    .padding(.horizontal)
                    .padding(.bottom, -5)
                // day view
                VStack {
                    VStack(spacing: 5) {
                        dayOfTheWeekRow
                            .padding(.horizontal, 2)
                        // dates
                        // lazy grid
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 5) {
                            ForEach(calendarVM.extractDate()) { value in
                                CardView1(value: value)
                                    
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
                }
                
                eventView
                    .padding(.horizontal)
                
//                Spacer()
                
            }
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
    }
    
    @ViewBuilder
    func CardView1(value: DateValue) -> some View {
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
                
                
                if let task = tasks.first(where: { task in
                    return calendarVM.isSameDay(date1: task.taskDate, date2: value.date)
                }) {
                     
//                    Spacer()
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
            Text(calendarVM.extraDate()[1])
                .customFontTitleBold()
            if calendarVM.isMonthNotInCurrentYear(month: calendarVM.highlightedDay) {
                Text(calendarVM.extraDate()[0])
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
    
    private var eventView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 7) {
                if calendarVM.isDateToday(today: calendarVM.highlightedDay) {
                    Text("Today")
                } else if calendarVM.isDateTomorrow(tomorrow: calendarVM.highlightedDay) {
                    Text("Tomorrow")
                } else if calendarVM.isDateYesterday(yesterday: calendarVM.highlightedDay){
                    Text("Yesterday")
                } else {
                    Text(calendarVM.displayDay()[0])
                    Text(calendarVM.displayDay()[2])
                    Text(calendarVM.displayDay()[1])
                }
                
                Spacer()
                Button {
                    
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
            
            
            if let task = tasks.first(where: { task in
                return calendarVM.isSameDay(date1: task.taskDate, date2: calendarVM.highlightedDay)
            }) {
                ScrollView(showsIndicators: false) {
                    ForEach(task.task) { task in
                        VStack {
                            HStack(spacing: 18) {
//                                VStack(alignment: .leading, spacing: 4) {
                                    // for custom timing
                                Text(task.time , style: .time)
                                        .customFontCaptionBold()
                                        .foregroundColor(.secondary)
                                    
                                    Text(task.title)
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
                    
                }
            } else {
                Text("No events")
                    .customFontBodyRegular()
                    .foregroundColor(.secondary)
                    .padding(.top)
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

// extending date to get current month dates
extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        // getting start date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        
        // getting date
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
            
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeumorphicBackground()
            CalendarView()
//                .preferredColorScheme(.dark)
        }
    }
}
