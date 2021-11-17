//
//  SetGame.swift
//  HW 4
//
//  Created by Cruz Gonzalez Garcia on 11/10/21.
//

import Foundation

struct SetGame {
    
    var setDeck = SetCardDeck()
    var cards = [SetCard]() //the cards beings displayed
    var score = 0;
    
    var selectedCards = [SetCard]() //cards the user touches
    
    
    //Note: A game should start with 12 cards
    init () {
        for _ in 1...12 {
            //score = 0
            
            if let card = setDeck.dealCard() { //if drawing a card doesn't give us nil
                cards.append(card)
            } else {
                print("Error, no cards left in the deck")
            }
        }
        
        for card in cards {
            print(card.shape, card.getCardContents(), "Num of Shapes: \(card.count)", card.shade)
        }
    }
    
    
    
    //update to card not pos
//    mutating func selectCard(_ card: SetCard) {
//        // if card doeesnt exist in the set of cards being displayed at pos, return
//        if(!cards.indices.contains(pos) ) { return }
//
//        //add cards who haven't been selected to cards or deselct them if numOfSelectedCards < 3
//        if selectedCards.count < 3 {
//            var chosenCard = cards[pos]
//
//            if !chosenCard.isSelected {
//                chosenCard.isSelected.toggle() //possible bug here. Now selected
//                selectedCards.append(chosenCard)
//                return
//            }
//
//            if chosenCard.isSelected {
//                chosenCard.isSelected.toggle() //possible bug here; No longer selected
//                selectedCards.removeAll(where: { $0 == chosenCard})
//                return
//            }
//        }
//
//        //MARK: chck for a 'Set' : Consider using a helper function
//        let isSet = isASet(hand: cards)
//
//        if isSet {
//            score += 1
//            //the selectedCards[] must be then set to unSelected AND REMOVED
//
//
//        } else {
//            //
//        }
        
        
        
//        let card1 = selectedCards[0] , card2 = selectedCards[1], card3 = selectedCards[2]
//
//        let areAllShapesSameOrDiff : Bool
//        let areAllShadesSameOrDiff : Bool
//        let areAllColorSameOrDiff  : Bool
//        let areAllCountSameOrDiff  : Bool
//
//        if (card1.shape == card2.shape  && card2.shape == card3.shape
//            || ){
//            areAllShapesSameOrDiff = true
//        }
        
        
        // if card is selected already deselect it and remove from cards
//        if cards[pos].isSelected {
//            cards[pos].isSelected.toggle()
//            //REMOVE FROM CARDS IN PLAY (CARDS) & remove from deck?
//            cards.remove(at: pos)
//        }
        
//
//    }
    
    
    mutating func selectCard(_ card: SetCard) {
        
        if let idx = cards.firstIndex(where: { $0.id == card.id }), selectedCards.contains(card) {
            if selectedCards.count < 3 {
               
               // selectedCards.remove(at: cards.firstIndex(where: {$0 == cards[idx]})!)
                
                //let idxChosen = selectedCards.firstIndex(where: { $0.id == cards[idx].id })!
              
                //selectedCards.remove(at: idxChosen)
                
                selectedCards.removeAll(where: { $0 == cards[idx] })
                cards[idx].isSelected.toggle()
            }
            
            //USED TO TEST REMOVE ME.
            print("---------------")
            for selected in selectedCards {
                
                print(selected.shape, selected.getCardContents(), "Num of Shapes: \(selected.count)", selected.shade)
            }
            print("---------------")
            
            return
        }

        
        if let idx = cards.firstIndex(where: { $0.id == card.id }), !selectedCards.contains(card) {
            if selectedCards.count < 3 { //AND IS NOT ALREADY IN THE SELECTED CARDS...
                cards[idx].isSelected.toggle()
                selectedCards.append(cards[idx])
                
                if selectedCards.count == 3 && wasThereASet(cards: selectedCards) {
                    //remove all selected Cards AND coresspoinding cards in deck.
                    
                    for i in selectedCards {
                        cards.removeAll(where: { $0 == i })
                        selectedCards.removeAll()
                    }
                    score += 1
                    return
                }
                
                
            } else {
                //CODE HERE IMPLIES THERE WAS NO SET.
                print("NO SET FOUND")
                
                for i in selectedCards.indices {
                    selectedCards[i].isMisMatched.toggle()
                }
                
                //Obejective: change CARDS[] are seen in SelectedCards[] to unSelected : Maybe try a nest for loop.
                for i in cards.indices {
                    for j in selectedCards {
                        if cards[i] == j {
                            cards[i].isSelected.toggle()
                        }
                    }
                }
                
                selectedCards.removeAll()
            }
            
            print("--------------->")
            for selected in selectedCards {
                print(selected.shape, selected.getCardContents(), "Num of Shapes: \(selected.count)", selected.shade)
            }
            print("--------------->")
            
            
        }
    }
    
    //disable this button if the deck is empty
    mutating func addThreeCards() {
        //show 3 new cards that are displayed from deck
        for _ in 1...3 {
            if let card = setDeck.dealCard() { //if calling the function does not return nil
                cards.append(card)
            } else {
                print("Deck is empty. Can't add more cards")
            }
        }
    }
    
    
    func getScore() -> Int {
        score
    }
    
    
    //MARK: Helper functions
    
    //Clear and unselect cards from selectedCards[]
//    private func clearSelectedCards(){
//        for i in selectedCards {
//            var card = selectedCards[i]
//            card.isSelected.toggle()
//        }
//        selectedCards.removeAll()
//    }
    
    //OLD NON FUNCTIONING CODE BELOQ
    //Given 3 card Returns true if its a set.
    //    private func isASet(hand cards: Array<SetCard>) -> Bool {
    //        let card1 = cards[0], card2 = cards[1], card3 = cards[2]
    //
    //        let areAllShapesSameOrDiff : Bool
    //        let areAllShadesSameOrDiff : Bool
    //        let areAllColorSameOrDiff  : Bool
    //        let areAllCountSameOrDiff  : Bool
    //
    //
    //        //Checks if card1, 2 and 3 all have the same shape or all dont
    //        if (card1.shape == card2.shape  && card2.shape == card3.shape
    //                || card1.shape != card2.shape && card2.shape != card3.shape && card3.shape != card1.shape){
    //            areAllShapesSameOrDiff = true  //true iff all same or diff
    //        } else {
    //            areAllShapesSameOrDiff = false
    //        }
    //
    //
    //        //Checks if card1, 2, and 3 have either all the same shade or all diff shade
    //        if(card1.shade == card2.shade && card2.shade == card3.shade
    //            || card1.shade != card2.shade && card2.shade != card3.shade && card3.shade != card1.shade){
    //            areAllShadesSameOrDiff = true
    //        } else {
    //            areAllShadesSameOrDiff = false
    //        }
    //
    //
    //        //Checks if card1, 2, and 3 have either all the same color or all diff shape
    //        if(card1.color == card2.color && card2.color == card3.color
    //            || card1.color != card2.color && card2.color != card3.color && card3.color != card1.color){
    //            areAllColorSameOrDiff = true
    //        } else {
    //            areAllColorSameOrDiff = false
    //        }
    //
    //        //Checks to if card1, card 2 and 3 have either all the same ammnt. of shapes or all have a diff ammnt. of shapes
    //        if (card1.count == card2.count && card2.count == card3.count
    //            || card1.count != card2.count && card2.count != card3.count && card3.count != card1.count) {
    //            areAllCountSameOrDiff = true
    //        } else {
    //            areAllCountSameOrDiff = false
    //        }
    //
    //        return areAllShapesSameOrDiff && areAllShadesSameOrDiff && areAllColorSameOrDiff && areAllCountSameOrDiff
    //    }
    
    
    // MARK: Functions used to determine if a set.
    //Assume a hand always contains 3 cards.
    
    
    // MARK: Shape Functions
    func areAllShapesSame(hand cards: Array<SetCard>) -> Bool {
        let A = cards[0], B = cards[1], C = cards[2]
        
        return A.shape == B.shape && B.shape == C.shape && A.shape == C.shape
    }
    
    func areAllShapesDiff(hand cards: Array<SetCard>) -> Bool {
        let A = cards[0], B = cards[1], C = cards[2]
        
        // A != B, B != C, A != C
        
        return A.shape != B.shape && B.shape != C.shape && A.shape != C.shape
    }

    // MARK: Shade functions
    func areAllShadesSame(hand cards: Array<SetCard>) -> Bool {
        let A = cards[0], B = cards[1], C = cards[2]
        
        return A.shade == B.shade && B.shade == C.shade && A.shade == C.shade
    }
    
    func areAllShadesDiff(hand cards: Array<SetCard>) -> Bool {
        let A = cards[0], B = cards[1], C = cards[2]
        
        return A.shade != B.shade && B.shade != C.shade && A.shade != C.shade
    }
    
    // MARK: Color functions
    func areAllColorSame(hand cards: Array<SetCard>) -> Bool {
        let A = cards[0], B = cards[1], C = cards[2]
        
        return A.color == B.color && B.color == C.color && A.color == C.color
    }
    
    func areAllColorsDiff(hand cards: Array<SetCard>) -> Bool {
        let A = cards[0], B = cards[1], C = cards[2]
        
        return A.color != B.color && B.color != C.color && A.color != C.color
    }
    
    
    // MARK: Count functions
    func areAllCountsSame(hand cards: Array<SetCard>) -> Bool {
        let A = cards[0], B = cards[1], C = cards[2]
        
        return A.count == B.count && B.count == C.count && A.count == C.count
    }
    
    func areAllCountsDiff(hand cards: Array<SetCard>) -> Bool {
        let A = cards[0], B = cards[1], C = cards[2]
        
        return A.count != B.count && B.count != C.count && A.count != C.count
    }
    
    func wasThereASet(cards: Array<SetCard>) -> Bool {
        let shape = areAllShapesSame(hand: cards) || areAllShapesDiff(hand: cards)
        let shade = areAllShadesSame(hand: cards) || areAllShadesDiff(hand: cards)
        let color = areAllColorSame(hand: cards)  || areAllColorsDiff(hand: cards)
        let count = areAllCountsSame(hand: cards) || areAllCountsDiff(hand: cards)
        
        return shape && shade && color && count
    }
}
