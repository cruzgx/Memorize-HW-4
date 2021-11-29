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
    
    @State private var dealt = Set<Int>()
    
    var body: some View {
        VStack {
            ScrollView {
                header
                mainGameBody
                HStack {
                    deckbBody
                    discardDeck
                }
                userActionButtons
            }
        }
    }
    
    
    private func deal(_ card: SetCard) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: SetCard) -> Bool {
        !dealt.contains(card.id)
    }
    
    var mainGameBody: some View {
        LazyVGrid(columns:[GridItem(.adaptive(minimum: 75))]) {
            ForEach(game.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .transition(AnyTransition.scale)
                    .foregroundColor(card.getCardOutline())
                //TO DO: Removal transitions dont work.
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity).animation(.easeInOut(duration: 3)))
                    //.transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity).animation(.easeInOut(duration: 1)))
                    .onTapGesture {
                            game.selectCard(card)
                    }
                    //.transition(AnyTransition.scale.animation(Animation.easeOut(duration: 1)))
                    //would only apply transitions to cards that were touched?


              //card.getMismatchColor() == Color.gray ? .background(Color.gray) : nil

            }
            //The following should show cards come onto the screen...
        }.onAppear() {
            withAnimation(.easeInOut(duration: 5)) {
                for card in game.cards {
                    deal(card)
                }
            }
        }
        .padding(.horizontal)
    }
    
    
    
    var deckbBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .scale))
            }
         }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1)) {
                for card in game.cards {
                    deal(card)
                }
                game.add3Cards()
            }
        }
    }
    

    
    var discardDeck: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            shape.fill().foregroundColor(.red)
            shape.strokeBorder(lineWidth: 3.0)
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealHeight)
    }
    
    var header: some View {
        VStack {
            Text("Set!")
                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            
            Text("Score: " + String(game.getSetGameScore()))
        }
    }
    
    var userActionButtons: some View {
        HStack {
            Button(action: {
                withAnimation {
                    game.add3Cards()
                }
            }, label: {
                Image(systemName: "square.fill.on.square")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Text("Deal 3 More Cards")
                    
            })
            .font(.headline)
            
            Spacer()
            Button(action: {
                withAnimation {
                    game.newGame()
                }
            }, label: {
                Image(systemName: "play.fill")
                    .foregroundColor(.blue)
                Text("New Game")
            })
            .font(.headline)
        }
        .padding()
    }
    
    //Constants here:
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealHeight: CGFloat = 90
        static let undealtWidth = undealHeight * aspectRatio
    }
}




struct CardView: View {
    var card: SetCard
    
    init(_ card: SetCard) {
        self.card = card
    }
    
    var body: some View {
        
        //Geometry reader messes up cards fonts..
        
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            shape.fill().foregroundColor(.white)
            shape.strokeBorder(lineWidth: 3.0)
            
            Text(card.getCardContents())
                
                .foregroundColor(card.getCardColor())
                .opacity(card.getCardOpacity())
                .font(Font.system(size: 25))
            //.font(Font.system(size: min(geometry.size.width, geometry.size.height) ))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
