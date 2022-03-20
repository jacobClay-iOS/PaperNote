//
//  ListSettingsView.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/15/22.
//

import SwiftUI

struct ListSettingsView: View {
    @EnvironmentObject var taskListVM: TaskListVM
    var body: some View {
       
            
        ZStack {
            NeumorphicBackground()
            VStack(spacing: 30) {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("Surface"))
                    .frame(width: 120, height: 120)
                    .shadow(color: Color("OuterShadow"), radius: 4, x: 4, y: 6)
                    .shadow(color: Color("OuterGlare"), radius: 1, x: -1, y: -1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder( LinearGradient(gradient: Gradient(stops: [
                                Gradient.Stop(color: Color("OuterGlare"), location: 0.3),
                                Gradient.Stop(color: Color("Surface"), location: 0.5),
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2, antialiased: true)
                )
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("Surface"))
                    .frame(width: 120, height: 120)
                    .shadow(color: Color("OuterShadow"), radius: 4, x: 4, y: 4)
                    .shadow(color: Color("OuterGlare"), radius: 2, x: -2, y: -2)
//                RoundedRectangle(cornerRadius: 15)
//                    .fill(Color("Surface"))
//                    .frame(width: 150, height: 150)
//                    .shadow(color: Color("OuterShadow"), radius: 4, x: 4, y: 4)
//                    .shadow(color: Color("OuterGlare"), radius: 4, x: -2, y: -2)
////                    .opacity(0.5)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 15)
//                            .strokeBorder(LinearGradient(colors: [Color("OuterGlare"), Color("Surface")], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3, antialiased: true)
//                            .blur(radius: 5)
//                            .opacity(0.8)
//                    )
                
                Image(systemName: "circlebadge")
                    .font(.body)
                    .foregroundColor(taskListVM.initializedTaskList.customAccentColor)
                    .padding(5)
                    .background(
                        Circle()
                            .foregroundColor(Color("Surface"))
                            .shadow(color: Color("OuterShadow"), radius: 2, x: 1, y: 2)
                            .overlay(
                                Circle()
                                    .stroke( LinearGradient(gradient: Gradient(stops: [
                                        Gradient.Stop(color: Color("OuterGlare"), location: 0.4),
                                        Gradient.Stop(color: Color("Surface"), location: 0.6),
                                    ]), startPoint: .topLeading, endPoint: .bottom), lineWidth: 1.5)
                        )
                    )
                
                
                
                
                
                Image(systemName: "circlebadge.fill")
                    .font(.body)
                    .foregroundColor(taskListVM.initializedTaskList.customAccentColor)
                    .padding(5)
                    .background(
                        Circle()
                            .foregroundColor(Color("Surface"))
                            .overlay(
                                Circle()
                                    .stroke(Color("OuterGlare"), lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(
                                        Circle()
                                            .fill(LinearGradient(colors: [Color.clear, Color("OuterGlare")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    )
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color("InnerShadow"), lineWidth: 4)
                                    .blur(radius: 6)
                                    .offset(x: -2, y: -2)
                                    .mask(
                                        Circle()
                                            .fill(LinearGradient(colors: [Color.black, Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    )
                            )
                            .overlay(
                                Circle()
                                    .stroke( LinearGradient(gradient: Gradient(stops: [
                                        Gradient.Stop(color: Color("OuterGlare"), location: 0.4),
                                        Gradient.Stop(color: Color("Surface"), location: 0.6),
                                    ]), startPoint: .bottomTrailing, endPoint: .topLeading), lineWidth: 1.5)
                        )
                    )
                
              
                    
                        
                        
                
                
                Button {
                    print("Balls")
                } label: {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                }
                .buttonStyle(AddTaskButtonStyle())
            }

        }
            
    }
}

struct ListSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ListSettingsView()
            .environmentObject(TaskListVM())
            .preferredColorScheme(.dark)
    }
}
