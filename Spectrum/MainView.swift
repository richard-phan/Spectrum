//
//  MainView.swift
//  Spectrum
//
//  Created by CSUFTitan on 3/4/20.
//  Copyright © 2020 Richard Phan. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @Binding var page: Int
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 15) {
                Text("Spectrum")
                    .foregroundColor(Color.black)
                    .font(.custom("Noteworthy", size: 64))
                    .bold()
                    .padding(.bottom, 150)
                
                Button(action: {
                    self.page = 1
                }) {
                    Text("Play")
                        .fontWeight(.light)
                }.buttonStyle(HomeButton())
            
                Button(action : {
                    self.page = 2
                }) {
                    Text("Help")
                        .fontWeight(.light)
                }.buttonStyle(HomeButton())
            }
        }
    }
}

struct HomeButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.custom("Marker Felt", size: 24))
            .frame(width: 250, height: 60)
            .background(Color.white)
            .cornerRadius(40)
            .foregroundColor(.black)
            .overlay(RoundedRectangle(cornerRadius: 40)
            .stroke(Color.black, lineWidth: 5))
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(page: $page)
//    }
//}
