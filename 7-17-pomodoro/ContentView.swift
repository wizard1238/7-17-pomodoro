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
    
    var body: some View {
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
        .onReceive(receiver, perform: { _ in
            withAnimation(Animation.linear(duration: 0.01)) {
                second += 1
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
