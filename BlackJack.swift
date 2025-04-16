import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var value: Int
    let suit: String
    var isFaceCard: Bool
    var isAce: Bool
}

struct BlackJack: View {
    @State var playerCards: [Card] = []
    @State var dealerCards: [Card] = []
    @State var gameMessage: String = "Welcome to Blackjack!"
    @State var gameOver: Bool = false
    @State var playerBet: Int = 0
    @State var cash = 5000
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
                    Text("0392")
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
                    Text("0392")
                }
                HStack {
                    ForEach(dealerCards) { card in
                        cardView(card: card)
                    }
                }
            }
            HStack {
                Button("Hit") {
                    drawCard(for: &playerCards)
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
                }
                Button("$100") {
                    cash -= 100
                }
                Button("$250") {
                    cash -= 250
                }
                Button("$500") {
                    cash -= 500
                }
                Button("$1000") {
                    cash -= 1000
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
                    .font(.title)
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
    func drawCard(for hand: inout [Card]) {
        let cardValue = Int.random(in: 1...13)
        let suit = ["hearts", "diamonds", "clubs", "spades"].randomElement()!
        let card = Card(
            value: cardValue > 10 ? 10 : cardValue,
            suit: suit,
            isFaceCard: cardValue > 10,
            isAce: cardValue == 1
        )
        hand.append(card)
        adjustAces(hand: &hand)
    }
    
    func adjustAces(hand: inout [Card]) {
        var total = hand.reduce(0, { $0 + $1.value })
        for i in 0..<hand.count {
            if total > 21 && hand[i].isAce && hand[i].value == 11 {
                hand[i].value = 1
                total -= 10
            }
        }
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
            drawCard(for: &dealerCards)
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
        playerCards = []
        dealerCards = []
        gameMessage = "New game started!"
        gameOver = false
        drawCard(for: &playerCards)
        drawCard(for: &playerCards)
        drawCard(for: &dealerCards)
    }
}
