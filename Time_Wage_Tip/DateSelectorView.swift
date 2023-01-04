/*
  DateSelectorView.swift
  Time_Wage_Tip

  Created by ribash on 12/21/22.
*/


import SwiftUI

struct DateSelectorView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var selected: String
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var didSelectRange: Bool
    @Binding var dateRange: [(String, String)]

    let sDate = Date.now
    let eDate = Calendar.current.date(byAdding: .day, value: 14, to: Date.now)!

    var body: some View{
        
        VStack{
            Text("Select Dates")
            // Radio Button1
            HStack{
                Button(action: {
                    selected = "today"
                    didSelectRange = false // will set true only when 'DONE' is clicked
                    startDate = sDate
                    endDate = eDate
                    print(selected)
                }){
                    Text("  ")
                        .frame(width:30,height:30)
                        .background(selected == "today" ? Color.black : Color.white)
                        .cornerRadius(100)
                        .foregroundColor(Color.black)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.red, lineWidth: 6)
                            .scaleEffect(0.6))
                }
                Text("Today")
                Text(Date(), style: .date)
            }
            
            // Radio Button2
            HStack{
                Button(action: {
                    selected = "custom"
                    didSelectRange = false
                    startDate = sDate
                    endDate = eDate
                    print(selected)
                }){
                    Text("  ")
                        .frame(width:30,height:30)
                        .background(selected == "custom" ? Color.black : Color.white)
                        .cornerRadius(100)
                        .foregroundColor(Color.black)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.red, lineWidth: 6)
                            .scaleEffect(0.6))
                }
                Text("Custom")
            }
            
            HStack{
                if (selected == "custom"){
                    VStack{
                        DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                        DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    }
                }
            }
            
            Button("Done", action:{
                didSelectRange = true
                let format = DateFormatter()
                format.dateFormat = "dd MMM YYYY"
                let startDateComp = format.string(from: startDate)
                let endDateComp = format.string(from: endDate)

                dateRange.append((startDateComp, endDateComp))
               self.presentationMode.wrappedValue.dismiss()
            })

        }
        
    }
}
 
