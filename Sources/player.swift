import Foundation

public struct Player: CanTakeCard {

    public init() {}

    public init(name: String) {
        self.name = name
    }

    public var name: String?

    public var historyOfDealtHoldemCards = [(Card, Card, NSDate)]()
    
    public var frequentHands = [String:Int]()

    public var holdemHand: (HandRank, [String])?
    
    public var holdemHandDescription: String? {
        return holdemHand?.1.joinWithSeparator(" ")
    }
    
    public var holdemHandNameDescription: String? {
        return holdemHand?.0.name.rawValue.lowercaseString
    }

    public var cardsHistory: String {
        let mapped = historyOfDealtHoldemCards.map { $0.0.description + " " + $0.1.description }
        return mapped.joinWithSeparator(", ")
    }

    public var cards = [Card]() {
        didSet {
            let tu = (self.cards[0], self.cards[1], NSDate())
            historyOfDealtHoldemCards.append(tu)
            let fqname = "\(tu.0.description),\(tu.1.description)"
            if frequentHands[fqname] == nil {
                frequentHands[fqname] = 1
            } else {
                frequentHands[fqname]!++
            }
        }
    }

    public var cardsNames: String { return cards.joinNames(with: ", ") }

    public var count: Int { return cards.count }

    public var holeCards: String { return cards.spacedDescriptions }
    
    public var lastDealtHandReadableDate: String? {
        guard let date = historyOfDealtHoldemCards.last?.2 else { return nil }
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"
        return formatter.stringFromDate(date)
    }
    
    public var lastDealtHandDate: NSDate? {
        return historyOfDealtHoldemCards.last?.2
    }
}
