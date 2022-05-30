//
//  PaperNoteApp.swift
//  Shared
//
//  Created by Jacob Clay on 2/15/22.
//

import SwiftUI

@main
struct PaperNoteApp: App {
//    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        
                HomeView()
//                    .preferredColorScheme(.dark)
                
            
        }
    }
}
