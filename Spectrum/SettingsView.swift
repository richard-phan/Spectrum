//
//  SettingsView.swift
//  ColorMix
//
//  Created by CSUFTitan on 3/9/20.
//  Copyright © 2020 Richard Phan. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Binding var page: Int
    
    var body: some View {
        VStack {
            Text("Settings Page")
            Button(action: {
                self.page = 0
            }) {
                Text("Home")
            }
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
