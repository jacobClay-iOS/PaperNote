//
//  Prototyping.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/25/22.
//

import SwiftUI

struct Prototyping: View {
    @State private var currentDate = Date.now
    @State private var isAllDay = false
    @State private var isRepeating = false
    @State private var eventName = ""
    
    let repeatingEventOptions = ["Day", "Week", "Month", "Year"]
    @State private var selectedRepeatInterval = "Month"
    var body: some View {
        VStack {
            
            
            Image("lauchScreenCheckmark")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.bottom)
          
            
            Text("\(currentDate)")
                .padding(.bottom, 200)
            
            
            //            SunkenTextField(textField: TextField("Event", text: $eventName))
            //                .padding(.horizontal)
            
            Form {
                
                Section {
                    TextField("Title", text: $eventName)
                    TextField("Note", text: $eventName)
                }
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .listRowBackground(Color("Surface"))
                
                Section {
                    VStack {
                        Toggle("All-day", isOn: $isAllDay)
                        
                        DatePicker(selection: $currentDate, displayedComponents: isAllDay ? .date : [.date, .hourAndMinute]) {
                            Text("Date")
                        }
                        
                        
                        Toggle(isRepeating ? "Repeat every:" : "Repeat", isOn: $isRepeating)
                        
                        if isRepeating {
                            HStack {
                                Picker("Repeat interval", selection: $selectedRepeatInterval) {
                                    ForEach(repeatingEventOptions, id: \.self) {
                                        Text($0)
                                }

                            }
                                .pickerStyle(.wheel)
                                Picker("Repeat interval", selection: $selectedRepeatInterval) {
                                    ForEach(repeatingEventOptions, id: \.self) {
                                        Text($0)
                                }
                                    .frame(width: 100)
                            }
                                .pickerStyle(.wheel)
                            }
                            
                    }
                    
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .listRowBackground(Color("Surface"))
                
                Section {
                    
                }
            }
            .listStyle(.insetGrouped)
            .tint(.accentColor)
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .onDisappear {
                UITableView.appearance().backgroundColor = .systemGroupedBackground
            }
            .shadow(color: Color("OuterGlare"), radius: 0.5, x: -0.5, y: -0.5)
            .shadow(color: Color("OuterGlare"), radius: 0.5, x: -0.5, y: -0.5)
            .shadow(color: Color("OuterGlare"), radius: 1, x: -1, y: -1)
            .shadow(color: Color("OuterShadow"), radius: 4, x: 4, y: 6)
            
        }
    }
}

struct Prototyping_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeumorphicBackground()
            Prototyping()
//                .preferredColorScheme(.dark)
        }
    }
}
