//
//  CalendarView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/24/22.
//

import SwiftUI

struct CalendarView: View {
    @State private var userSelectedDate: Date = Date()
//    @Binding var currentDate: Date
    
    // update month with arrow buttons
    @State private var userSelectedMonth1: Int = 0
    @State private var currentDay1: Date = Date()
//    @State private var currentMonth1: Int = 0
//    @State private var startingMonth: Int = 0
    
    @State private var highlightedDay: Date = Date()
    
    var body: some View {
        
        
        ZStack {
            NeumorphicBackground()
            VStack(spacing: 15) {
                header
                .padding(.horizontal)
                
                // day view
                VStack(spacing: 5) {
                    dayOfTheWeekRow
                    
                    // dates
                    // lazy grid
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 5) {
                        ForEach(extractDate1()) { value in
                            ZStack {
                                if (value.day != -1)  {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("Surface"))
                                        
                                        .shadow(color: Color("OuterShadow"), radius: 3, x: 3, y: 3)
                                        .shadow(color: Color("OuterGlare"), radius: 1, x: -2, y: -2)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke( LinearGradient(gradient: Gradient(stops: [
                                                    Gradient.Stop(color: Color("OuterGlare"), location: 0.3),
                                                    Gradient.Stop(color: Color("Surface"), location: 0.5),
                                                ]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
                                    )
                                        .padding(.horizontal, 4)
                                        .opacity(isSameDay1(date1: value.date, date2: currentDay1) ? 1 : 0)
                                        
                                        
                                }
                                CardView1(value: value)
    //                                .background(
    //                                    RoundedRectangle(cornerRadius: 10)
    //                                        .stroke(lineWidth: 4)
    //                                        .fill(Color.blue)
    //                                        .padding(.horizontal, 4)
    //                                        .opacity(isSameDay1(date1: value.date, date2: userSelectedDate) ? 1 : 0)
    //                                )
                                    .onTapGesture {
                                        highlightedDay = value.date
                                    }
                                
                            }
                        }
                    }
                }
                
                eventView
                    .padding(.horizontal)

                
                Spacer()
            }
            .onChange(of: userSelectedMonth1) { newValue in
                // updating month
                userSelectedDate = getCurrentMonth1()
            }
            .onDisappear {
                highlightedDay = currentDay1
        }
        }
    }
    
    @ViewBuilder
    func CardView1(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(isSameDay1(date1: value.date, date2: highlightedDay) ? .title2.bold() : .title3.bold())
                    .foregroundColor(isSameDay1(date1: value.date, date2: highlightedDay) ? Color("AccentStart") : .primary)
                
                    .frame(maxWidth: .infinity)
                                if let task = tasks.first(where: { task in
                                    return isSameDay1(date1: task.taskDate, date2: value.date)
                                }) {
//                                    Text("\(value.day)")
//                                        .font(isSameDay1(date1: value.date, date2: userSelectedDate) ? .title2.bold() : .title3.bold())
//                                        .foregroundColor(isSameDay1(date1: task.taskDate, date2: userSelectedDate) ? .secondary : .primary)
//
//                        .frame(maxWidth: .infinity)

                    Spacer()
                    Circle()
                        .fill(Color("AccentEnd"))
                        .frame(width: 8, height: 8)
                }
//                else {
//                    Text("\(value.day)")
//                        .font(isSameDay1(date1: value.date, date2: userSelectedDate) ? .title2.bold() : .title3.bold())
//                        .foregroundColor(isSameDay1(date1: value.date, date2: userSelectedDate) ? .secondary: .primary)
//                        .frame(maxWidth: .infinity)
//
//                    Spacer()
//                }
            }
        }
        .padding(.vertical, 8)
        .frame(height: 60, alignment: .top)
    }
    
    
    private var header: some View {
        HStack(spacing: 40) {
            Button { userSelectedMonth1 -= 1 }
            label: {
            Image(systemName: "chevron.left")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .buttonStyle(.plain)
            
            VStack(alignment: .center, spacing: 5) {
                Text(extraDate1()[0])
                    .customFontCaptionBold()
                
                Text(extraDate1()[1])
                    .customFontHeadline()
            }
            
            Button { userSelectedMonth1 += 1 }
            label: {
            Image(systemName: "chevron.right")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .buttonStyle(.plain)
            
        }
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
            HStack(spacing: 6) {
                if isDateToday(today: highlightedDay) {
                    Text("Today")
                } else if isDateTomorrow(tomorrow: highlightedDay) {
                    Text("Tomorrow")
                } else if isDateYesterday(yesterday: highlightedDay){
                    Text("Yesterday")
                } else {
                    Text(displayDay()[0])
                    Text(displayDay()[2])
                    Text(displayDay()[1])
                }
            }
            .customFontHeadline()
            .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 20)
            
            if let task = tasks.first(where: { task in
                return isSameDay1(date1: task.taskDate, date2: highlightedDay)
            }) {
                ScrollView() {
                    ForEach(task.task) { task in
                        VStack {
                            VStack(alignment: .leading, spacing: 4) {
                                // for custom timing
                                Text(task.time.addingTimeInterval(CGFloat.random(in: 0...5000)), style: .time)
                                    .customFontCaptionRegular()
                                    .foregroundColor(.secondary)
                                
                                Text(task.title)
                                    .customFontBodyRegular()
                                    .foregroundColor(.primary)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                Color("Surface")
                                    .cornerRadius(10)
                                    .shadow(color: Color("OuterShadow"), radius: 5, x: 4, y: 4)
                                    .shadow(color: Color("OuterGlare"), radius: 1, x: -4, y: -3)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke( LinearGradient(gradient: Gradient(stops: [
                                                Gradient.Stop(color: Color("OuterGlare"), location: 0.1),
                                                Gradient.Stop(color: Color("Surface"), location: 0.1),
                                            ]), startPoint: .top, endPoint: .bottom), lineWidth: 1)
                                )
                                    
                            )
                        .padding(.horizontal, 14)
                        }
                        .padding(.vertical, 8)
                    }
                    
                }
            } else {
                Text("No events found")
                    .customFontBodyRegular()
                    .foregroundColor(.secondary)
            }
        }
    }
    
    
    
    
    // checking dates
    private func isSameDay1(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    private func isDateToday(today: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(highlightedDay)
    }
    
    private func isDateTomorrow(tomorrow: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(highlightedDay)
    }
    
    private func isDateYesterday(yesterday: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInYesterday(highlightedDay)
    }
    
    // extracting year and month for display
    private func extraDate1() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        
        let date = formatter.string(from: userSelectedDate)
        
        return date.components(separatedBy: " ")
    }
    
    // extracting day for display
    private func displayDay() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM"
        
        
        let date = formatter.string(from: highlightedDay)
        
        return date.components(separatedBy: " ")
    }
    
    private func getCurrentMonth1() -> Date {
        let calendar = Calendar.current
        // getting current month date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.userSelectedMonth1, to: Date())
        else {
            return Date()
        }
        return currentMonth
    }
    
    
    private func extractDate1()->[DateValue] {
        let calendar = Calendar.current
        // getting current month date
        let currentMonth = getCurrentMonth1()
        var days = currentMonth.getAllDates1().compactMap { date -> DateValue in
            
            // getting day
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}



// extending date to get current month dates
extension Date {
    func getAllDates1() -> [Date] {
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
        CalendarView()
            .preferredColorScheme(.dark)
    }
}
