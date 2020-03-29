//
//  ContentView.swift
//  Spectrum
//
//  Created by CSUFTitan on 3/3/20.
//  Copyright © 2020 Richard Phan. All rights reserved.
//

import SwiftUI

//extension Bundle {
//    func decode(_ file: String) -> GameData {
//        guard let url = self.url(forResource: file, withExtension: ".json") else {
//            fatalError("Failed to locate \(file) in bundle.")
//        }
//        
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Failed to load \(file) from bundle.")
//        }
//        
//        let decoder = JSONDecoder()
//        
//        guard let loaded = try? decoder.decode(GameData.self, from: data) else {
//            fatalError("Failed to decode \(file) from bundle")
//        }
//        
//        return loaded
//    }
//    
//    func encode(_ file: String, data: GameData) -> Void {
//        do {
//            guard let fileURL = self.url(forResource: file, withExtension: ".json") else {
//                fatalError("Failed to locate \(file) in bundle.")
//            }
//            
//            print(fileURL)
//            
//            try JSONEncoder().encode(data)
//                .write(to: fileURL)
//        } catch {
//            fatalError("Failed to write to file")
//        }
//    }
//}

struct GameData: Codable {
    let correct: String
    let wrong: String
    let highscore: Int
}

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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
