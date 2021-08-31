//
//  MainUIView.swift
//  ReplayStartUpKit
//
//  Created by SATOSHI NAKAJIMA on 8/31/21.
//

import SwiftUI

struct MainUIView: View {
    @ObservedObject var state = AppState.shared
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    state.startBroadcast()
                }, label: {
                    Text(state.isBroadcasting ? "Stop" : "Start")
                })
            }
            .padding(10)
        }
    }
}

struct MainUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainUIView()
    }
}
