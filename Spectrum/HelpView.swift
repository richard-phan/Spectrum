//
//  HelpView.swift
//  ColorMix
//
//  Created by CSUFTitan on 3/4/20.
//  Copyright © 2020 Richard Phan. All rights reserved.
//

import SwiftUI

struct HelpView: View {
    @Binding var page: Int
    
    var body: some View {
        VStack {
            Text("Combine the 3 colors to make the target color within the time frame to earn points")
            
            Button(action: {
                self.page = 0
            }) {
                Text("Home")
            }
        }
    }
}

//struct HelpView_Previews: PreviewProvider {
//    static var previews: some View {
//        HelpView()
//    }
//}
