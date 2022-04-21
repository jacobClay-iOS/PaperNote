//
//  AddEventView.swift
//  PaperNote
//
//  Created by Jacob Clay on 4/20/22.
//

import SwiftUI

struct AddEventView: View {
    @State private var eventDate = Date.now
    @State private var isAllDay = false
    @State private var isRepeating = false
    @State private var eventName = ""
    @State private var isShowingDatePicker = false
    @FocusState private var eventFieldFocus
    @State private var currentDragOffsetY: CGFloat = 0
    
    @EnvironmentObject var calendarVM: CalendarVm
    
    let repeatingEventOptions = ["Day", "Week", "Month", "Year"]
    @State private var selectedRepeatInterval = "Month"
    
    var body: some View {
        
        VStack {
            Spacer()
            VStack(spacing: 15) {
                header
                    .padding(.horizontal, 4)
                eventTextField
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
        .task {
            DispatchQueue.main.async {
                eventFieldFocus = true
            }
        }
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
                        currentDragOffsetY = 0
                    }
                }
        )
    }
    
    private var header: some View {
        VStack {
            DragGestureTab()
            HStack {
                Text("Add Event")
                    .customFontHeadline()
                    .foregroundColor(.primary)

                Spacer()
            }
        }
    }
    
    private var eventTextField: some View {
        SunkenTextField(textField: TextField("Title", text: $eventName))
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
    }
    
    private var toolBar: some View {
        VStack {
            HStack(spacing: 15) {
                DatePicker(selection: $eventDate, displayedComponents: isAllDay ? .date : [.date, .hourAndMinute]) {
                    Text("Today")
                }
                .labelsHidden()
                .datePickerStyle(.compact)
                
                if isAllDay {
                    Text("All Day")
                        .font(.body)
                        .foregroundColor(.primary)
                        .padding(.vertical, 6.5)
                        .padding(.horizontal, 12)
                        .background(
                            Color(uiColor: .tertiarySystemFill)
                            
                                
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .padding(.leading, -10)
                }
                
                
                Spacer()
                
                Button {
                   
    
                        isAllDay.toggle()
                    
                } label: {
                    Image(systemName: "sun.max")
                        .font(.title2)
                        .foregroundColor(isAllDay ? Color.accentColor : .secondary)
                }
                .buttonStyle(.plain)
                
                Button {
                    withAnimation {
                       
    
                    }
                } label: {
                    Image(systemName: "repeat")
                        .font(.title2)
                        .foregroundColor(isRepeating ? Color.accentColor : .secondary)
                }
                .buttonStyle(.plain)
    
                Button {
                    withAnimation {
    
    
                    }
                } label: {
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
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
                AddEventView()
                Spacer()
                
            }
        }
    }
}
