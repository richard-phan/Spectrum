//
//  ContentView.swift
//  Spectrum
//
//  Created by CSUFTitan on 3/3/20.
//  Copyright © 2020 Richard Phan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var page = 0
    @State var score: Int!
    
    var body: some View {
        return Group {
            if page == 0 {
                MainView(page: $page)
            }
            if page == 1 {
                GameView(page: $page)
            }
            if page == 2 {
                HelpView(page: $page)
            }
            if page == 3 {
                SettingsView(page: $page)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
