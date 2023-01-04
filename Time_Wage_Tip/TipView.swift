/*
  TipView.swift
  Time_Wage_Tip

  Created by ribash on 12/21/22.
*/

import SwiftUI

/*
 Details: Converts provided date in String format to Date format
 Return: Date object
 example: "12 Dec 2020" to Someday, 12 Dec 2020 HH:MM:SS
 */
func stringToDate(date: String)->Date{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy"
    return dateFormatter.date(from: date) ?? Date.now
}

struct TipView: View {
    /*
     Although not used in this class, startDate and endDate must be declared and
     passed into DateSelectorView(..) as they are binded to DateSelectorView.
     */
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(byAdding: .day, value: 14, to: Date.now)!
    
    /*
     pressedRadioButton has an extremely important function.
     a variable, selected is bind to this var from DateSelectorView.
     
     pressedRadioButton is declared as empty string but it holds its last state.
     So, if last state user had pressed Today/Custon, that button remains pressed.
     
     If pressedRadioButton is not used then the selection resets to no button pressed BUT date of last press will still be added to dateRange upon clicking "Done"
     */
    @State private var pressedRadioButton = ""
    
    /*
     didSelectDate checks if user selected a date or not. This will ONLY be true when user presses either Today/Custom AND presses "Done".
     
     If user presses either Today/Custom AND presses "Back", didSelectDate will be false
     */
    @State private var didSelectDate = false
    
    /*
     Binds range of start and end date from DateSelectorView
     */
    @State private var dateRange = [(String, String)]()
    
    var body: some View{

        NavigationView{
            VStack{
                HStack{
                    NavigationLink(
                        destination: DateSelectorView(
                            selected: $pressedRadioButton,
                            startDate: $startDate,
                            endDate: $endDate,
                            didSelectRange: $didSelectDate,
                            dateRange: $dateRange
                        )
                    ) {
                        Text("New Report")
                        Image(systemName: "plus")
                        
                    }
                    
                }
                
                if (didSelectDate){
                    VStack{
                        ForEach(dateRange, id:\.0) { day in
                            HStack{                                Text("\(day.0)")
                                Text("\(day.1)")
                                NavigationLink(destination: WageDetailView(loopStartDate: stringToDate(date: day.0), loopEndDate: stringToDate(date: day.1))){
                                    Text("Edit")
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    struct TipView_Previews: PreviewProvider {
        static var previews: some View {
            TipView()
        }
    }
}
