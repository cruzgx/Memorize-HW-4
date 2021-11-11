//
//  File.swift
//  HW 4
//
//  Created by Cruz Gonzalez Garcia on 11/10/21.
//

import Foundation

//This is the viewModel
class Game: ObservableObject {
    
    //initialize the game here
    @Published private var model = SetGame()
    
    
    
    var cards : Array<SetCard> {
        model.cards
    }
   
    //MARK: - Intents
    public func newGame(){
        model = SetGame()
        print("METHOD WAS CALLED")
    }
    
    public func selectCard(_ card: SetCard){
        model.selectCard(card)
    }
    
    public func add3Cards(){
        model.addThreeCards()
    }
    
    public func getSetGameScore() -> Int {
        model.getScore()
    }
    
    //Published private var model: SetGame<String>
}
