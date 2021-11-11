//
//  ContentView.swift
//  HW 4
//
//  Created by Cruz Gonzalez Garcia on 11/10/21.
//

import SwiftUI

struct ContentView: View {
    
    //viewModel Variable here
    @ObservedObject var game : Game = Game()
    
    
    //Aspect VGrid?
    var body: some View {
        VStack {
            ScrollView {
                Text("Set!")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                
                Text("Score: " + String(game.getSetGameScore()))
                    
                
                //Print out cards
                LazyVGrid(columns:[GridItem(.adaptive(minimum: 75))]){
                    ForEach(game.cards) { card in
                        CardView(card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.selectCard(card)
                            }
                            .foregroundColor(card.getCardOutline())
                
                    }
                }
                .padding(.horizontal)
                
                //User Action Buttons
                HStack {
                    Button(action: {game.add3Cards()}, label: {
                        Image(systemName: "square.fill.on.square")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("Deal 3 More Cards")
                            
                    })
                    .font(.headline)
                    
                    Spacer()
                    Button(action: {game.newGame()}, label: {
                        Image(systemName: "play.fill")
                            .foregroundColor(.blue)
                        Text("New Game")
                    })
                    .font(.headline)
                }
                .padding()
                
                
                

            }
        }
        
        
    }
}


struct CardView: View {
    var card: SetCard
    
    init(_ card: SetCard) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            shape.fill().foregroundColor(.white)
            shape.strokeBorder(lineWidth: 3.0)
            
            Text(card.getCardContents())
                .foregroundColor(card.getCardColor())
                //Card Opacity Here.
                .opacity(card.getCardOpacity())
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
