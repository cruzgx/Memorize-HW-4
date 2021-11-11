//
//  SetCard.swift
//  HW 4
//
//  Created by Cruz Gonzalez Garcia on 11/10/21.
//

import Foundation

import Foundation
import SwiftUI //Used to obtain color attribute

struct SetCard : Identifiable, Equatable {
    //MARK: Hint to figure out there is a set, Use the Set data structure!
    //Java uses this: HashSet<TYPE> mySet = new HashSet<>()
    
    //used to determine if 2 cards are equal to ea. other
    static func ==(lhs:  SetCard, rhs:  SetCard) -> Bool {
            (lhs.shape == rhs.shape &&
            lhs.shade == rhs.shade &&
            lhs.color == rhs.color &&
            lhs.count == rhs.count &&
            lhs.id == rhs.id)
    }
    
    //features that a Card has
    var shape: Shapes
    var shade: Shades
    var color: Colors
    var count: Int  // MARK: This variable name could be confusing. Consider numOfShapes?
    var id: Int
    
    
    var isSelected: Bool
    var isMatched: Bool
    var isMisMatched: Bool
    
    enum Shapes {
        case circle
        case square
        case triangle
        
        static var all = [Shapes.circle, .square, .triangle]
    }
    
    enum Shades {
        case outlined
        case shaded
        case filled
        
        static var all = [Shades.outlined, .shaded, .filled]
    }
    
    
    enum Colors {
        case red
        case green
        case purple
        
        static var all = [Colors.red, .green, .purple]
    }
    
    init(shape: Shapes, shade: Shades, color: Colors, count: Int, id: Int) {
        self.shape = shape
        self.shade = shade
        self.color = color
        self.count = count
        self.id = id
        
        self.isSelected = false
        self.isMatched = false
        self.isMisMatched = false
        
    }
    
    func getCardContents() -> String {
        var shape: String
        
        
        if self.shade == .outlined {
            switch (self.shape) {
            case .square:
                shape = "☐"
            case .circle:
                shape = "○"
            case .triangle:
                shape = "△"
            }
        } else {
            switch (self.shape) {
            case .square:
                shape = "◼︎"
            case .circle:
                shape = "●"
            case .triangle:
                shape = "▲"
            }
        }
        
        var cardEmojis = ""
        
        for _ in 1...self.count {
            cardEmojis += shape
        }
        
        return cardEmojis
    }
    
    
    func getCardColor() -> Color {
        
        switch self.color {
        case Colors.red:
            return Color.red
        case Colors.green:
            return Color.green
        case Colors.purple:
            return Color.purple
        }
    }
    
    
    func getCardOutline() -> Color {
         isSelected ? .green : .red //CORRECT
    }
    
    func getCardOpacity() -> Double {
        self.shade == Shades.shaded ? 0.4 : 1.0
    }
    
    mutating func setCardToSelected() {
        self.isSelected = true;
    }
}

