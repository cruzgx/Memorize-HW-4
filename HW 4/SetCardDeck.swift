//
//  SetCardDeck.swift
//  HW 4
//
//  Created by Cruz Gonzalez Garcia on 11/10/21.
//

import Foundation

struct SetCardDeck {
    var deck = Array<SetCard>()
    
    
    init() {
        var id = 1
        for color in SetCard.Colors.all {
            for shape in SetCard.Shapes.all {
                for shade in SetCard.Shades.all {
                    for count in 1...3 {
                        self.deck += [SetCard(shape: shape, shade: shade, color: color, count: count, id: id)]
                        id += 1
                    }
                }
            }
        }
        //possible shuffle here.
        deck.shuffle()
    }

    
    mutating func dealCard() -> SetCard? {
        if(self.isEmpty()){   //maybe deck.isEmpty() ?
            return nil
        }
        
        return self.deck.remove(at: 0)
    }
    
    
    //returns size of deck
    func count() -> Int {
        deck.count
    }
    
    func isEmpty() -> Bool {
        deck.count == 0;
    }
    
    func getMaxCardId() -> Int? {
        if isEmpty() {
            return nil
        }
        
        var max = 0
        for i in deck.indices {
            if max > deck[i].id {
                max = deck[i].id
            }
        }
        return max
    }
    
    func createNewCard() -> SetCard {
        //let newShape = SetCard.Shapes.all.randomElement()!
        let newId = getMaxCardId()! + 1 // our new basis
        
        let newCard = SetCard(shape: SetCard.Shapes.all.randomElement()!,
                              shade: SetCard.Shades.all.randomElement()!,
                              color: SetCard.Colors.all.randomElement()!,
                          count: Int.random(in: 1...3),
                          id: newId)
        return newCard
    }
    
    
//    func getIndicies() -> Range<Int> {
//        deck.indices
//    }

//    func getCard(index: Int) -> SetCard? {
//        if index < 0 || index >= deck.count {
//            return nil
//        }
//
//        return deck[index]
//    }
    
    //consider adding a shuffle function
}
