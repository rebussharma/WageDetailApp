/*
  WageDetailView.swift
  Time_Wage_Tip

  Created by ribash on 12/24/22.
*/

import SwiftUI
import Combine

/*
 Returns an array of Date between two Dates
 source: https://stackoverflow.com/questions/32536612/all-dates-between-two-date-objects-swift
 */
extension Date {
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}

/*
 /*
  When cashTips changes, the non-numeric values are filtered out, then the filtered value is compared to see
  if cashTips should be updated a second time, overwriting the bad input with the filtered input
  */                            .keyboardType(.decimalPad)
                                .onReceive(Just(totalHours[idx])){ newValue in
                                    let filtered = newValue.filter{Set("0123456789.").contains($0)}
                                    if filtered != newValue{
                                        self.totalHours[idx] = filtered
                                    }

                                }
                                .textFieldStyle(.roundedBorder)
                                .padding()
 */

struct WageDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var loopStartDate = Date()
    var loopEndDate = Date()
    
    @State private var timeRangeSelected = [Bool]()
    @State private var totalHours = [String]()
    @State private var startTime = [Date]()
    @State private var endTime = [Date]()
    @State private var cashTips = [String]()
    @State private var cardTips = [String]()
    
    @State private var dateArray = [Date]()

    var body: some View {
        
        ScrollView{
            /* for each date in range we will create a BOX to add hours, cash/card tips
             */
            ForEach (Array(dateArray.enumerated()), id:\.offset){ idx, day in
                VStack{
                    Text("Report for \(day)")
                    HStack{
                        // if toggle is off input total hours worked
                        if(!timeRangeSelected[idx]){
                            Text("Total Hours")

                            TextField(
                                "Enter Total Hours",
                                text: $totalHours[idx]
                            ).keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)

                        }
                        else // if toggle is on, add time range
                        {
                            VStack{
                                HStack{
                                    DatePicker(
                                        "Start Time",
                                        selection: $startTime[idx],
                                        displayedComponents: .hourAndMinute
                                    )
                                }

                                HStack{
                                    DatePicker(
                                        "End Time",
                                        selection: $endTime[idx],
                                        displayedComponents: .hourAndMinute
                                    )
                                }
                            }

                        }

                        Spacer()
                        Toggle("Add Time", isOn: $timeRangeSelected[idx])
                    }


                    HStack{
                        Text("Cash Tips")
                        TextField(
                            "Enter Cash Tips",
                            text: $cashTips[idx]
                        )
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                    }
                    
                    HStack{
                        Text("Card Tips")
                        TextField(
                            "Enter Card Tips",
                            text: $cardTips[idx]
                        )
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)

                    }
                    
                    
                }
                .border(Color.blue)
            }
        }.onAppear{
            dateArray = Date.dates(from: loopStartDate, to: loopEndDate)
            let arraySize = dateArray.count
            timeRangeSelected = Array<Bool>(repeating: false, count: arraySize)
            totalHours = Array<String>(repeating: "", count: arraySize)
            startTime = Array<Date>(repeating: Date.now, count: arraySize)
            endTime = Array<Date>(repeating: Date.now, count: arraySize)
            cashTips = Array<String>(repeating: "", count: arraySize)
            cardTips = Array<String>(repeating: "", count: arraySize)
        }

    }
}

struct WageDetailView_Previews: PreviewProvider {
    static let dateBound = [(String, String)]()
    static var previews: some View {
        WageDetailView(
            loopStartDate: Date.now,
            loopEndDate: Date.now
        )
    }
}
