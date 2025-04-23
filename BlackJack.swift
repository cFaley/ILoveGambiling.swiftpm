import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var value: Int
    let suit: String
    var isFaceCard: Bool
    var isAce: Bool
}

struct BlackJack: View {
    
    enum GamePhase { case betting, playing, handOver }
    
    @State var gamePhase: GamePhase = .betting
    @State var selectedBet: Int?    = nil
    @State var cash: Int = 5000
    @State var playerCards: [Card] = []
    @State var dealerCards: [Card] = []
    @State var gameMessage: String = "Welcome to Blackjack!"
    @State var gameOver: Bool = false
    @State var playerBet: Int = 0
    @State var dealerTotal: Int = 0
    @State var playerTotal: Int = 0
    var body: some View {
        VStack(spacing: 20) {
            Text("Blackjack")
                .font(.largeTitle)
                .bold()
            Text(gameMessage)
                .padding()
            
            Text("Cash $\(cash)")
            VStack {
                HStack{
                    Text("Your Hand:")
                    Text("\(playerTotal)")
                }
                HStack {
                    ForEach(playerCards) { card in
                        cardView(card: card)
                    }
                }
            }
            VStack {
                HStack{
                    Text("Dealer's Hand:")
                    Text("\(dealerTotal)")
                }
                HStack {
                    ForEach(dealerCards) { card in
                        cardView(card: card)
                    }
                }
            }
            HStack {
                Button("Hit") {
                    hit()
                    checkGameOver()
                }
                Button("Stand") {
                    dealerTurn()
                }
            }
            
            HStack {
                Text("Select a bet:")
                Button("$50") {
                    cash -= 50
                    hit()
                    hit()
                }
                Button("$100") {
                    cash -= 100
                    hit()
                    hit()
                }
                Button("$250") {
                    cash -= 250
                    hit()
                    hit()
                }
                Button("$500") {
                    cash -= 500
                    hit()
                    hit()
                }
                Button("$1000") {
                    cash -= 1000
                    hit()
                    hit()
                }
            }
            Button("Next hand") {
                nextHand()
            }
        }
        .onAppear {
            nextHand()
        }
    }
    
    func cardView(card: Card) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 50, height: 70)
                .border(Color.black, width: 2)
            VStack {
                Text(cardDisplayValue(card))
                    .font(.headline)
                    .foregroundColor(card.suit == "hearts" || card.suit == "diamonds" ? .red : .black)
                Image(systemName: suitImage(card.suit))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(card.suit == "hearts" || card.suit == "diamonds" ? .red : .black)
            }
        }
    }
    
    func cardDisplayValue(_ card: Card) -> String {
        if card.isFaceCard {
            return ["J", "Q", "K"][card.value - 10]
        } else if card.isAce {
            return "A"
        } else {
            return String(card.value)
        }
    }
    
    func suitImage(_ suit: String) -> String {
        switch suit {
        case "hearts": return "suit.heart.fill"
        case "diamonds": return "suit.diamond.fill"
        case "clubs": return "suit.club.fill"
        case "spades": return "suit.spade.fill"
        default: return ""
        }
    }
    func hit() {
        drawCard(into: &playerCards)
        if total(of: playerCards) > 21 {
            gameMessage = "Busted! Dealer wins."
            gamePhase = .handOver
        }
    }
    
    func drawCard(into hand: inout [Card]) {
            let raw = Int.random(in: 1...13)
            let card = Card(
                value: raw > 10 ? 10 : raw,
                suit: ["hearts","diamonds","clubs","spades"].randomElement()!,
                isFaceCard: raw > 10,
                isAce: raw == 1
            )
            hand.append(card)
            adjustAces(in: &hand)
        }
    func adjustAces(in hand: inout [Card]) {
        var t = total(of: hand)
        for idx in hand.indices where t > 21 && hand[idx].isAce && hand[idx].value == 11 {
            hand[idx].value = 1
            t -= 10
        }
    }
    
    func total(of hand: [Card]) -> Int {
        hand.reduce(0) { $0 + $1.value }
    }
    
    func checkGameOver() {
        let playerTotal = playerCards.reduce(0, { $0 + $1.value })
        if playerTotal > 21 {
            gameMessage = "You busted! Dealer wins."
            gameOver = true
        } else if playerTotal == 21 {
            gameMessage = "Blackjack! You win!"
            gameOver = true
        }
    }
    
    func dealerTurn() {
        while dealerCards.reduce(0, { $0 + $1.value }) < 17 {
            hit()
        }
        let dealerTotal = dealerCards.reduce(0, { $0 + $1.value })
        let playerTotal = playerCards.reduce(0, { $0 + $1.value })
        
        if dealerTotal > 21 {
            gameMessage = "Dealer busted! You win!"
        } else if dealerTotal >= playerTotal {
            gameMessage = "Dealer wins!"
        } else {
            gameMessage = "You win!"
        }
        gameOver = true
    }
    
    func nextHand() {
        selectedBet = nil
        gamePhase    = .betting
        gameMessage  = "Place your bet!!!"
        playerCards = []
        dealerCards = []
    }
}
