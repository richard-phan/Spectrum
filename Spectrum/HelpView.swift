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
    
    @State var instruction = 0
    @State var showInstruction = true
    @State var count = 0
    @State var complete = false
    
    @State var colors = [Color]()
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack() {
                    Button(action: {
                        self.page = 0
                    }) {
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.red)
                            .padding(.leading, 30)
                    }
                    
                    Spacer()
                    
                    Text("Score: 0")
                        .foregroundColor(Color.black)
                        .font(.custom("Marker Felt", size: 24))
                        .padding(.horizontal, 30)
                }.padding(.top, 30)
                
                Spacer()
                
                Text("TARGET COLOR")
                    .foregroundColor(Color.black)
                    .font(.custom("Marker Felt", size: 24))
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(red: 0.5, green: 0, blue: 0.5))
                    .frame(width: 100, height: 100)
                
                Text("SELECTED COLORS")
                    .foregroundColor(Color.black)
                    .font(.custom("Marker Felt", size: 24))
                    .padding(.top, 40)
                
                HStack(spacing: 30) {
                    Button(action: {
                        if self.colors.count > 0 {
                            self.colors.remove(at: 0)
                        }
                        
                        if self.colors.count == 0 && self.instruction == 2 {
                            self.showInstruction = true
                        }
                    }) {
                        if self.colors.count > 0 {
                            ColorCircle(color: self.colors[0])
                        } else {
                            ColorCircle(color: Color.white)
                        }
                    }.buttonStyle(AnimatedButtonStyle())
                    
                    Button(action: {
                        if self.colors.count > 1 {
                            self.colors.remove(at: 1)
                        }
                        
                        if self.colors.count == 0 && self.instruction == 2 {
                            self.showInstruction = true
                        }
                    }) {
                        if self.colors.count > 1 {
                            ColorCircle(color: self.colors[1])
                        } else {
                            ColorCircle(color: Color.white)
                        }
                    }.buttonStyle(AnimatedButtonStyle())
                }
                
                Text("BASE COLORS")
                    .foregroundColor(Color.black)
                    .font(.custom("Marker Felt", size: 24))
                    .padding(.top, 70)
                
                HStack() {
                    Button(action: {
                        if self.colors.count < 2 {
                            self.colors.append(Color(red: 1, green: 0, blue: 0))
                        }
                        
                        if (self.colors.count == 2  && self.instruction == 2) {
                            self.showInstruction = true
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(red: 1, green: 0, blue: 0))
                            .frame(width: 100, height: 100)
                    }.buttonStyle(AnimatedButtonStyle())
                    
                    Button(action: {
                        if self.colors.count < 2 {
                            self.colors.append(Color(red: 0, green: 1, blue: 0))
                        }
                        
                        if (self.colors.count == 2  && self.instruction == 2) {
                            self.showInstruction = true
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(red: 0, green: 1, blue: 0))
                            .frame(width: 100, height: 100)
                    }.buttonStyle(AnimatedButtonStyle())
                    
                    Button(action: {
                        if self.colors.count < 2 {
                            self.colors.append(Color(red: 0, green: 0, blue: 1))
                        }
                        
                        if (self.colors.count == 2  && self.instruction == 2)
                            || (self.colors.count == 0 && self.instruction == 3) {
                            self.showInstruction = true
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(red: 0, green: 0, blue: 1))
                            .frame(width: 100, height: 100)
                    }.buttonStyle(AnimatedButtonStyle())
                }
                .padding(.horizontal, 10)
                
                HStack(spacing: 20) {
                    Button(action: {
                        self.colors.removeAll()
                        
                        if self.colors.count == 0 && self.instruction == 3 {
                            self.showInstruction = true
                        }
                    }) {
                        Text("Clear")
                            .font(.custom("Marker Felt", size: 16))
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .background(Color.orange)
                            .foregroundColor(Color.white)
                    }
                    
                    Button(action: {
                        if self.instruction == 4
                            && (self.colors[0] == Color(red: 1, green: 0, blue: 0) && self.colors[1] == Color(red: 0, green: 0, blue: 1))
                            || (self.colors[0] == Color(red: 0, green: 0, blue: 1) && self.colors[1] == Color(red: 1, green: 0, blue: 0)) {
                            self.complete = true
                            self.showInstruction = true
                        }
                    }) {
                        Text("Check")
                            .font(.custom("Marker Felt", size: 16))
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .background(self.colors.count < 2 ? Color.gray : Color.red)
                            .foregroundColor(Color.white)
                            .disabled(self.colors.count < 2)
                    }
                }.padding(.top, 50)
                
                Spacer()
            }
            
            ZStack {
                if showInstruction {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.yellow)
                        .frame(width: 400, height: 300)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 5)
                        )
                    
                    VStack {
                        if !complete {
                            Text("INSTRUCTIONS")
                                .foregroundColor(Color.black)
                                .font(.custom("Marker Felt", size: 34))
                        } else {
                            Text("TUTORIAL COMPLETE")
                                .foregroundColor(Color.black)
                                .font(.custom("Marker Felt", size: 34))
                        }
                        
                        if instruction == 0 {
                            Text("Mix as many colors before time runs out")
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.black)
                                .font(.custom("Marker Felt", size: 24))
                                .padding(.top, 30)
                            Spacer()
                            Text("RED + GREEN = YELLOW")
                                .foregroundColor(Color.black)
                            Text("RED + BLUE = PURPLE")
                                .foregroundColor(Color.black)
                            Text("GREEN + BLUE = TURQOUISE")
                                .foregroundColor(Color.black)
                            
                        }
                        else if instruction == 1 {
                            Text("Choose two colors from BASE COLORS to make the TARGET COLOR")
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                                .font(.custom("Marker Felt", size: 24))
                                .padding(.top, 30)
                        }
                        else if instruction == 2 {
                            Text("Remove the SELECTED COLORS by pressing the CIRCLES or CLEAR")
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                                .font(.custom("Marker Felt", size: 24))
                                .padding(.top, 30)
                        }
                        else if instruction == 3 {
                            Text("Select BLUE and RED and press CHECK")
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                                .font(.custom("Marker Felt", size: 24))
                                .padding(.top, 30)
                        }
                        
                        if self.instruction < 4 {
                            Button(action: {
                                if self.instruction != 0 {
                                    self.showInstruction = false
                                }
                                self.instruction += 1
                            }) {
                                Text("OK")
                                    .foregroundColor(Color.black)
                                    .font(.custom("Marker Felt", size: 24))
                                    .frame(width: 100, height: 40)
                                    .background(Color.green)
                                    .padding(.top, 20)
                            }.buttonStyle(AnimatedButtonStyle())
                        } else {
                            VStack {
                                Button(action: {
                                    self.page = 0
                                }) {
                                    Text("Home")
                                        .foregroundColor(Color.black)
                                        .font(.custom("Marker Felt", size: 24))
                                        .frame(width: 200, height: 40)
                                        .background(Color.green)
                                        .padding(.top, 20)
                                }.buttonStyle(AnimatedButtonStyle())
                                
                                Button(action: {
                                    self.instruction = 0
                                    self.showInstruction = true
                                    self.complete = false
                                    self.colors.removeAll()
                                }) {
                                    Text("Redo tutorial")
                                        .foregroundColor(Color.black)
                                        .font(.custom("Marker Felt", size: 24))
                                        .frame(width: 200, height: 40)
                                        .background(Color.green)
                                        .padding(.top, 20)
                                }.buttonStyle(AnimatedButtonStyle())
                            }
                        }
                    }.frame(width: 360, height: 290)
                }
            }
        }
    }
}

//struct HelpView_Previews: PreviewProvider {
//    static var previews: some View {
//        HelpView()
//    }
//}
