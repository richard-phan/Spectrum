//
//  GameView.swift
//  Spectrum
//
//  Created by CSUFTitan on 3/3/20.
//  Copyright © 2020 Richard Phan. All rights reserved.
//

import SwiftUI
import AVFoundation

var audioPlayer: AVAudioPlayer!

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not find sound resource")
        }
    }
}

struct GameView: View {
    @Binding var page: Int
    
    @State var timeRemaining = 60
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var difficulty = 2
    @State var score = 0
    @State var colors = [RawColor(1.0, 0.0, 0.0), RawColor(0.0, 1.0, 0.0), RawColor(0.0, 0.0, 1.0)]
    @State var indexes = [0, 0, 0, 1, 1, 1, 2, 2, 2].shuffled()

    @State var choiceIndex = [0, 1, 2].shuffled()
    
    @State private var choices = [RawColor]()
    
    var body: some View {
        return Group {
            if self.timeRemaining == 0 {
                VStack(spacing: 15) {
                    Text("Score: \(score)")
                        .font(.custom("Marker Felt", size: 25))
                        .padding(.bottom, 50)
                    
                    Button(action: {
                        self.timeRemaining = 60
                        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    }) {
                        Text("Play again")
                    }.buttonStyle(HomeButton())
                    
                    Button(action: {
                        self.page = 0
                    }) {
                        Text("Home")
                    }.buttonStyle(HomeButton())
                }
            } else {
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    VStack {
                        Button(action: {
                            self.page = 0
                        }) {
                            Image(systemName: "x.circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        
                        Text("Time remaining: \(timeRemaining)")
                            .font(.custom("Marker Felt", size: 30))
                            .onReceive(timer) { _ in
                                if self.timeRemaining > 0 {
                                    self.timeRemaining -= 1
                                }
                            }
                        
                        RoundedRectangle(cornerRadius: 15)
                            .fill(rawToColor(targetColor()))
                            .frame(width: 100, height: 100)
                        
                        HStack(spacing: 30) {
                            if choices.count >= 1 {
                                Button(action : {
                                    self.choices.remove(at: 0)
                                }) {
                                    ColorCircle(color: rawToColor(choices[0]))
                                }.buttonStyle(AnimatedButtonStyle())
                            }
                            else {
                                ColorCircle(color: Color.white)
                            }
                            
                            if choices.count >= 2 {
                                Button(action: {
                                    self.choices.remove(at: 1)
                                }) {
                                    ColorCircle(color: rawToColor(choices[1]))
                                }.buttonStyle(AnimatedButtonStyle())
                            }
                            else {
                                ColorCircle(color: Color.white)
                            }
                            
                            if self.difficulty == 3 {
                                if choices.count >= 3 {
                                    Button(action: {
                                        self.choices.remove(at: 2)
                                    }) {
                                        ColorCircle(color: rawToColor(choices[2]))
                                    }.buttonStyle(AnimatedButtonStyle())
                                }
                                else {
                                    ColorCircle(color: Color.white)
                                }
                            }
                        }.padding(.top, 50)
                        
                        HStack {
                            Button(action: {
                                if self.choices.count < self.difficulty {
                                    self.choices.append(self.colors[self.choiceIndex[0]])
                                }
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(self.rawToColor(self.colors[self.choiceIndex[0]]))
                                    .frame(width: 100, height: 100)
                            }.buttonStyle(AnimatedButtonStyle())
                            
                            Button(action: {
                                if self.choices.count < self.difficulty {
                                    self.choices.append(self.colors[self.choiceIndex[1]])
                                }
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(self.rawToColor(self.colors[choiceIndex[1]]))
                                    .frame(width: 100, height: 100)
                            }.buttonStyle(AnimatedButtonStyle())
                            
                            Button(action: {
                                if self.choices.count < self.difficulty {
                                    self.choices.append(self.colors[self.choiceIndex[2]])
                                }
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(self.rawToColor(self.colors[self.choiceIndex[2]]))
                                    .frame(width: 100, height: 100)
                            }.buttonStyle(AnimatedButtonStyle())
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, 100)
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                self.choices.removeAll()
                            }) {
                                Text("Clear")
                                    .font(.custom("Marker Felt", size: 16))
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 10)
                                    .background(Color.orange)
                                    .foregroundColor(Color.white)
                            }
                            
                            Button(action: {
                                if self.checkAnswer() {
                                    playSound(sound: "correct1", type: "mp3")
                                    self.score += 1;
                                    self.setColors()
                                    self.indexes.shuffle()
                                    self.choiceIndex.shuffle()
                                } else {
                                    playSound(sound: "wrong2", type: "mp3")
                                }
                                self.choices.removeAll()
                            }) {
                                Text("Check")
                                    .font(.custom("Marker Felt", size: 16))
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 10)
                                    .background(choices.count < difficulty ? Color.gray : Color.red)
                                    .foregroundColor(Color.white)
                            }.disabled(choices.count < difficulty)
                        }.padding(.top, 50)
                        
                        Text("Score: \(self.score)")
                            .font(.custom("Marker Felt", size: 24))
                            .padding(.top, 15)
                    }
                }
            }
        }
    }
    
    func targetColor() -> RawColor {
        if difficulty == 2 {
            return colors[0] + colors[1]
        } else {
            var color = colors[indexes[0]]
            for i in 1..<3 {
                color = color + colors[indexes[i]]
            }
            
            return color
        }
    }
    
    func setColors() -> Void {
        let color = randomColor2()
        self.colors[0] = RawColor(color[0], color[1], color[2])
        self.colors[1] = RawColor(color[2], color[0], color[1])
        self.colors[2] = RawColor(color[1], color[2], color[0])
        
//        for i in 0..<self.colors.count {
//            self.colors[i] = randomColor()
//        }
    }
    
    func rawToColor(_ raw: RawColor) -> Color {
        return Color(red: raw.red, green: raw.green, blue: raw.blue)
    }
    
    func checkAnswer() -> Bool {
        var mixedColor = choices[0]
        
        for idx in 1..<choices.count {
            mixedColor = mixedColor + choices[idx]
        }
        
        return mixedColor == targetColor()
    }
}

class RawColor {
    var red: Double
    var green: Double
    var blue: Double
    
    init(_ red: Double, _ green: Double, _ blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    static func + (lhs: RawColor, rhs: RawColor) -> RawColor {
        let red = (lhs.red + rhs.red) / 2
        let green = (lhs.green + rhs.green) / 2
        let blue = (lhs.blue + rhs.blue) / 2
        
        return RawColor(red, green, blue)
    }
    
    static func == (lhs: RawColor, rhs: RawColor) -> Bool {
        return lhs.red == rhs.red && lhs.green == rhs.green && lhs.blue == rhs.blue
    }
}

func randomColor() -> RawColor {
    return RawColor(Double.random(in: 0...1), Double.random(in: 0...1), Double.random(in: 0...1))
}

func randomColor2() -> [Double] {
    let colors = [0, Double.random(in: 0.7...1), Double.random(in: 0...1)].shuffled()
    return colors
}

struct AnimatedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct ColorCircle: View {
    var color: Color
    
    var body: some View {
        Circle()
            .frame(width: 50, height: 50)
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: 4)
            ).foregroundColor(color)
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}


