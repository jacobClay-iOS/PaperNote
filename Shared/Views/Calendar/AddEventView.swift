//
//  AddEventView.swift
//  PaperNote
//
//  Created by Jacob Clay on 4/20/22.
//

import SwiftUI

struct AddEventView: View {
    @EnvironmentObject var calendarVM: CalendarVm
    @FocusState private var eventFieldFocus
    @Binding var eventDate: Date
    
    
    @State private var isAllDay = false
    @State private var isRepeating = false
    @State private var isWithAlert = false
    @State private var isShowingEventType = false
    @State private var eventName = ""
    @State private var eventType: EventType?
    @State private var currentDragOffsetY: CGFloat = 0
    
    
    @State private var selectedRepeatInterval: RepeatInterval?
    
    var body: some View {
        
        VStack {
            Spacer()
            VStack(spacing: 15) {
                
                header
                eventTextField
                
                if isShowingEventType { eventTypePicker }
                
                if isRepeating { repeatIntervalPicker }
                
                if isWithAlert { alertPicker }
                    
                toolBar
                
            }
            .padding(.horizontal)
            .padding(.bottom)
            .background(Color("Surface"))
            .customCornerRadius(25, corners: [.topLeft, .topRight])
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
            .shadow(color: Color("OuterGlare"), radius: 0.5, y: -1)
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .task { DispatchQueue.main.async { eventFieldFocus = true } }
        .offset(y: currentDragOffsetY)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation {
                        currentDragOffsetY = value.translation.height
                    }
                }
                .onEnded{ value in
                    withAnimation {
                        if currentDragOffsetY > 40 {
                            withAnimation {
                                eventFieldFocus = false
                                calendarVM.isShowingAddEventView = false
                            }
                        }
                    }
                    currentDragOffsetY = 0
                }
        )
        .onDisappear {
            calendarVM.isShowingAddEventView = false
        }
    }
}



extension AddEventView {
    // MARK: Functions
    func addEvent() {
//            let event = EachDayEventCollection(todaysEvents: [CalendarEvent(title: eventName, date: eventDate, isAllday: isAllDay, isRepeating: isRepeating, isWithAlert: isWithAlert)], date: eventDate)
        let event = CalendarEvent(title: eventName, date: eventDate, isAllday: isAllDay, isWithAlert: isWithAlert, eventType: eventType, repeatInterval: selectedRepeatInterval)
//            calendarVM.addEventToCollection(event)
        calendarVM.addEventWithRepeatInterval(event)
            eventFieldFocus = false
            calendarVM.isShowingAddEventView = false
        }
    
    // MARK: Views
    private var header: some View {
        VStack {
            DragGestureTab()
            HStack(spacing: 15) {
                Text(calendarVM.displaySelectedDay())
                    .customFontHeadline()
                    .foregroundColor(.primary)

                Spacer()
                
                if isAllDay {
                    Text("All Day")
                        .font(.body)
                        .foregroundColor(.primary)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 12)
                        .background(
                            Color(uiColor: .tertiarySystemFill)
                            
                                
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .onTapGesture {
                            isAllDay = false
                        }
                } else {
                    DatePicker(selection: $eventDate, displayedComponents: .hourAndMinute) {
                        Text("Today")
                    }
                    .labelsHidden()
//                    .datePickerStyle(.compact)
                }
            }
        }
        .padding(.horizontal, 4)
    }
    
    private var eventTextField: some View {
        SunkenTextField(textField: TextField("event", text: $eventName))
            .focused($eventFieldFocus)
            .submitLabel(.done)
            .onSubmit {
                if eventName.isEmpty {
                    withAnimation {
                        eventFieldFocus = false
                        calendarVM.isShowingAddEventView = false
                    }
                } else {
                    // submit event code here
                    withAnimation {
                        addEvent()
                    }
                }
            }
            .padding(.horizontal, 2)
    }
    
    private var repeatIntervalPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Repeat Interval")
                    .customFontCaptionMedium()
                Spacer()
                if selectedRepeatInterval != nil {
                    Image(systemName: "xmark")
                        .foregroundColor(.secondary)
                        .font(.caption)
                        .onTapGesture {
                            selectedRepeatInterval = nil
                        }
                }
            }
            Divider()
            Picker("Repeat every", selection: $selectedRepeatInterval) {
                ForEach(RepeatInterval.allCases, id: \.self) { value in
                    Text(value.localizedName)
                        .tag(value as RepeatInterval?)
            }
        }
            .pickerStyle(.segmented)
        }
        .foregroundColor(.primary)
        .padding(.horizontal, 4)
    }
    
    private var eventTypePicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Category")
                    .customFontCaptionMedium()
                Spacer()
                if eventType != nil {
                    Image(systemName: "xmark")
                        .foregroundColor(.secondary)
                        .font(.caption)
                        .onTapGesture {
                            eventType = nil
                        }
                }
                
            }
            Divider()
            Picker("Repeat Every", selection: $eventType) {
                ForEach(EventType.allCases, id: \.self) { value in
                    Text(value.localizedName)
                        .tag(value as EventType?)
            }
        }
            .pickerStyle(.segmented)
        }
        .foregroundColor(.primary)
        .padding(.horizontal, 4)
    }
    
    private var alertPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Alerts")
                    .customFontCaptionMedium()
                Spacer()
                
                
            }
            Divider()
           Text("Content")
        }
    }
    
    private var toolBar: some View {
        VStack {
            HStack(spacing: 15) {
                Button { isAllDay.toggle() }
                 label: {
                    Image(systemName: "sun.max")
                        .font(.title2)
                        .foregroundColor(isAllDay ? Color.accentColor : .secondary)
                }
                .buttonStyle(.plain)
                
                Button { withAnimation { isShowingEventType.toggle() } }
                 label: {
                    Image(systemName: "eyedropper")
                        .font(.title2)
                        .foregroundColor(isShowingEventType ? Color.accentColor : .secondary)
                }
                .buttonStyle(.plain)
                
                Button { withAnimation { isRepeating.toggle() } }
                 label: {
                    Image(systemName: "repeat")
                        .font(.title2)
                        .foregroundColor(isRepeating ? Color.accentColor : .secondary)
                }
                .buttonStyle(.plain)
    
                Button { withAnimation { isWithAlert.toggle() } }
                 label: {
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(isWithAlert ? Color.accentColor : .secondary)
                }
                .buttonStyle(.plain)

                Spacer()

                Button { withAnimation { addEvent() } }
                    label: {
                    Image(systemName: "checkmark.rectangle.fill")
                        .font(.title)
                        .foregroundColor(eventName.isEmpty ? .secondary : Color.accentColor)
                }
                .disabled(eventName.isEmpty)
                .buttonStyle(.plain)
            }
            .padding(.leading, 2)
            
            
            
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeumorphicBackground()
            VStack {
                AddEventView(
//                    displayDate: Date.now,
                    eventDate: .constant(Date.now))
                Spacer()

            }
        }
        .environmentObject(CalendarVm())
    }
}
