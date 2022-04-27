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
    @State private var eventName = ""
    @State private var currentDragOffsetY: CGFloat = 0
    
    let repeatingEventOptions = ["Day", "Week", "Month", "Year"]
    @State private var selectedRepeatInterval = "Month"
    
    var body: some View {
        
        VStack {
            Spacer()
            VStack(spacing: 15) {
                
                header
//                Text("\(eventDate)")
                eventTextField
                
                if isRepeating { repeatPicker }
                    
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
                    withAnimation(.spring()) {
                        currentDragOffsetY = value.translation.height
                    }
                }
                .onEnded{ value in
                    withAnimation(.spring()) {
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
    }
    
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
                } else {
                    DatePicker(selection: $eventDate, displayedComponents: .hourAndMinute) {
                        Text("Today")
                    }
                    .labelsHidden()
                    .datePickerStyle(.compact)
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
                }
            }
            .padding(.horizontal, 2)
    }
    
    private var repeatPicker: some View {
        HStack(spacing: 8) {
            Text("Every:")
                .customFontBodyMedium()
                .foregroundColor(.primary)
            
            Picker("Repeat interval", selection: $selectedRepeatInterval) {
                ForEach(repeatingEventOptions, id: \.self) {
                    Text($0)
            }
        }
            .pickerStyle(.segmented)
            .foregroundColor(.primary)
        }
        .padding(.horizontal, 4)
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

                Button {
                    
                } label: {
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