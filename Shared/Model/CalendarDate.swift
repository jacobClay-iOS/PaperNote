//
//  DateValue.swift
//  PaperNote
//
//  Created by Jacob Clay on 3/24/22.
//

import SwiftUI

struct CalendarDate: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
