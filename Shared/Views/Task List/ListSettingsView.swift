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
       
            
        Text("Title")
            
    }
}

struct ListSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ListSettingsView()
            .environmentObject(TaskListVM())
            .preferredColorScheme(.dark)
    }
}
