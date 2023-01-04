//
//  TimeAndTips.swift
//  Time_Wage_Tip
//
//  Created by ribash on 1/3/23.
//

import Foundation

struct Details: Identifiable{
    let id: String = UUID().uuidString
    let timeRangeSelected : Bool
    let totalHours : String
    let startTime : Date
    let endTime : Date
    let cashTips : String
    let cardTips : String
}

class TimeAndTips{
    @Published var details: [Details] = []
}
