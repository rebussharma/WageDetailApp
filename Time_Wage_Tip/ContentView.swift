//
//  ContentView.swift
//  Time_Wage_Tip
//
//  Created by ribash on 12/17/22.
//

import SwiftUI

struct ContentView: View {
    private let menus = ["Summary", "Hours", "Tips"]

    var body: some View {
        TabView{
            TipView()
                .tabItem
                    {
                        Image(systemName: "house")
                            Text("Summary")
                    }
            
            HourView()
                .tabItem
                    {
                        Image(systemName: "clock")
                            Text("Hours")
                    }
            TipView()
                .tabItem
                    {
                        Image(systemName: "dollarsign.circle")
                            Text("Tips")
                    }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
