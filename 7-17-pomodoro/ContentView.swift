//
//  ContentView.swift
//  7-17-pomodoro
//
//  Created by Jeremy Tow on 7/17/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    @State var second: Int = 0
    var circleDiameter: CGFloat = UIScreen.main.bounds.width * 0.9
    
    @State var status: String = "Start"
    @State var section: Int = 1
    
    @State var countdown: Int = 0
    @State var phase: String =  ""
    @State var colors: [Color] = [Color](repeating: .red, count: 8)
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<8) { i in
                    Rectangle()
                        .fill(colors[i])
                        .frame(width: (circleDiameter - 75) / 8, height: 20)
                }
            }
            Text(phase)
            ZStack {
                Circle()
                    .fill(Color.primary)
                    .opacity(0.2)
                    .frame(width: circleDiameter, height: circleDiameter)
                ForEach(0..<60) { i in
                    Rectangle()
                        .opacity(0.7)
                        .frame(width: 2, height: (i % 5 == 0) ? 20 : 10)
                        .offset(x: 0, y: -circleDiameter/2.1)
                        .rotationEffect(Angle(degrees: Double(i * 6)))
                }
                Rectangle()
                    .frame(width: 3, height: circleDiameter/2)
                    .offset(x: 0, y: -circleDiameter/4)
                    .rotationEffect(Angle(degrees: Double(second * 6)))
            }
            .onAppear() {
                countdown = getTimeSegment(section: section).rawValue
                phase = getPhase(section: section)
            }
            .onReceive(receiver, perform: { _ in
                if status != "Start" {
                    colors[section - 1] = .green
                    if countdown > 0 && status == "Stop" {
                        withAnimation(Animation.linear(duration: 0.01)) {
                            second += 30
                            countdown -= 30
                        }
                    }
                    if countdown == 0 {
                        section = (section >= 8) ? 1 : section + 1
                        
                        countdown = getTimeSegment(section: section).rawValue
                        phase = getPhase(section: section)
                        status = "Start"
                    }
                }
                
            })
            
            Text(String(getFormattedTime(i: countdown)))
            
            Button(status) {
                if status == "Start" {
                    status = "Stop"
                } else {
                    status = "Start"
                }
            }
        }
    }
    
    func getFormattedTime(i: Int) -> String {
        let minutes = Int(floor(Double(i / 60)))
        let seconds = i % 60
        
        return String(minutes) + ":" + ((seconds < 10) ? "0" : "") + String(seconds)
    }
    
    func getTimeSegment(section: Int) -> Sections {
        if section % 2 != 0 {
            return .work
        } else if section == 8 {
            return .long_break
        } else {
            return .short_break
        }
    }
    
    func getPhase(section: Int) -> String {
        if section % 2 != 0 {
            return "Work"
        } else if section == 8 {
            return "Long Break"
        } else {
            return "Short Break"
        }
    }
}

enum Sections: Int {
    case work = 180
    case short_break = 60
    case long_break = 120
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
