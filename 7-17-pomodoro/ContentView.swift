//
//  ContentView.swift
//  7-17-pomodoro
//
//  Created by Jeremy Tow on 7/17/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var myVar: String = "my text"
    var body: some View {
        Text(myVar)
            .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
