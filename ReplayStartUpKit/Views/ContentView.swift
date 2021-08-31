//
//  ContentView.swift
//  ReplayStartUpKit
//
//  Created by SATOSHI NAKAJIMA on 8/31/21.
//

import SwiftUI

struct ContentView: View {
    @State var angle = Double(0.0)
    private let timer = Timer.publish(every: 1.0, on: .main, in: .default).autoconnect()
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                .foregroundColor(.blue)
                .rotationEffect(Angle(radians: angle))
                .animation(.easeInOut)
        }.onReceive(timer) { _ in
            angle += .pi/4
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
