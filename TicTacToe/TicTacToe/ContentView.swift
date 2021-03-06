//
//  ContentView.swift
//  TicTacToe
//
//  Created by Kathiresan on 20/05/20.
//  Copyright © 2020 Kathiresan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewModel = GameFlow()
    
    @State var player: Player = .one
    
    @State var wonPlayer: String = ""
        
    var body: some View {
        
        VStack(spacing: 10) {

              Text("Tic Tac Toe")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            ZStack {
                 VStack(spacing: 1) {
                                ForEach(0...2, id: \.self) { i in
                                    HStack(spacing: 1) {
                                        
                                        ForEach(0...2, id: \.self) { j in
                                            Button(action: {
                                                self.buttonTapped(key: "\(i)\(j)")
                                            }, label: {
                                                Text(self.getValue(key: "\(i)\(j)"))
                                            })
                                                .buttonStyle(CustomButtonStyle())
                                        }
                                    }
                                }
                            }
                            .background(LinearGradient(gradient: Gradient.init(colors: [.red, .green , .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .opacity(self.wonPlayer.isEmpty ? 1.0 : 0.7)
                            .disabled(self.wonPlayer.isEmpty ? false : true)
                            
                            Text(wonPlayer.isEmpty ? "" : "Won \(wonPlayer)")
                                       .font(.largeTitle)
                                       .padding()
                                       .background(Color.white)
                                       .foregroundColor(Color.black)
                                       .opacity(wonPlayer.isEmpty ? 0.0 : 1.0)
            }
           
            
            Spacer()
            
            Button(action: {
                self.newGameButtonTapped()
            }, label: {
                Spacer()
                Text("New game")
                .bold()
                    .foregroundColor(Color.white)
                Spacer()
                })
                .padding()
                .background(Color.green.opacity(0.8))
            .cornerRadius(20)
            .padding()
        }
        
    }
    
    func buttonTapped(key: String) {
        if player == .one {
            viewModel.setValue(.cross, for: key)
        } else {
            viewModel.setValue(.circle, for: key)
        }
        
        if viewModel.isWin() {
            print("Win: \(player)")
            self.wonPlayer = player.identity
        } else {
            player.toggle()
        }
        
    }
    
    func getValue(key: String) -> String {
        viewModel.getValue(for: key).rawValue
    }
    
    func newGameButtonTapped() {
        viewModel.content = [:]
        player = .one
        
        wonPlayer = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
