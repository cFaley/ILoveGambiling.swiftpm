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
    @AppStorage("cash") var cash: Int = 5000
    @State var playerCards: [Card] = []
    @State var dealerCards: [Card] = []
    @State var gameMessage: String = ""
    @State var gameOver: Bool = false
    @State var playerBet: Int = 0
    var body: some View {
        ZStack{
            VStack(spacing: 20) {
                Text(gameMessage)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("Cash $\(cash)")
                VStack {
                    HStack{
                        Text("Your Hand: \( total(of: playerCards) )")
                    }
                    HStack {
                        ForEach(playerCards) { card in
                            cardView(card: card)
                        }
                    }
                }
                VStack {
                    HStack{
                        Text("Dealer's Hand: \( total(of: dealerCards) )")
                        
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
                    }
                    .disabled(gamePhase != .playing)
                    
                    Button("Stand") {
                        stand()
                    }
                    .disabled(gamePhase != .playing)
                    
                }
                
                HStack {
                    Text("Select a bet:")
                    Button("$50") {
                        place(bet: 50)
                        dealInitialCards()
                    }
                    .disabled(gamePhase != .betting)
                    Button("$100") {
                        place(bet: 100)
                        dealInitialCards()
                    }
                    .disabled(gamePhase != .betting)
                    Button("$250") {
                        place(bet: 250)
                        dealInitialCards()
                    }
                    .disabled(gamePhase != .betting)
                    Button("$500") {
                        place(bet: 500)
                        dealInitialCards()
                    }
                    .disabled(gamePhase != .betting)
                    Button("$1000") {
                        place(bet: 1000)
                        dealInitialCards()
                    }
                    .disabled(gamePhase != .betting)
                }
                
                Button("Next hand") {
                    nextHand()
                }
            }
            .onAppear {
                nextHand()
            }
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
    func payOutWin() {
        guard let bet = selectedBet else { return }
        cash += bet * 2
    }
    
    func hit() {
        drawCard(into: &playerCards)
        let total = total(of: playerCards)
        
        if total > 21 {
            gameMessage = "You busted! Dealer wins."
            gamePhase = .handOver
            
        } else if total == 21 {
            payOutWin()
            gameMessage = "Blackjack! You win!"
            gamePhase = .handOver
        }
    }
    
    func stand() {
        while total(of: dealerCards) < 17 {
            drawCard(into: &dealerCards)
        }
        
        let playerTotal = total(of: playerCards)
        let dealerTotal = total(of: dealerCards)
        
        if dealerTotal > 21 || playerTotal > dealerTotal {
            payOutWin()
            gameMessage = "You win!"
        } else if dealerTotal >= 21 || dealerTotal == playerTotal {
            gameMessage = "It's a Tie! But you still lose money"
        } else {
            gameMessage = "Dealer wins!"
        }
        
        gamePhase = .handOver
    }
    
    
    func dealInitialCards() {
        playerCards.removeAll()
        dealerCards.removeAll()
        
        drawCard(into: &playerCards)
        drawCard(into: &playerCards)
        drawCard(into: &dealerCards)
    }
    
    func place(bet amount: Int) {
        selectedBet = amount
        cash -= amount
        dealInitialCards()
        gamePhase = .playing
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
        var sum = hand
            .filter { !$0.isAce }
            .reduce(0) { $0 + $1.value }
        let aceCount = hand.filter { $0.isAce }.count
        for _ in 0..<aceCount {
            if sum + 11 <= 21 {
                sum += 11
            } else {
                sum += 1
            }
        }
        
        return sum
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
    
    func nextHand() {
        selectedBet = nil
        gamePhase    = .betting
        gameMessage  = "Place your bet!"
        playerCards = []
        dealerCards = []
    }
}
