import SwiftUI

enum BetChoice { case none, oneToOne, twoToOne, thirtyFiveToOne }

struct Roulette: View {
    @AppStorage("cash") var cash: Int = 5000
    
    let myColor = Color(red: 107/255, green: 13/255, blue: 14/255)
    let pockets = [0,32,15,19,4,21,2,25,17,34,6,27,13,36,11,30,
                   8,23,10,5,24,16,33,1,20,14,31,9,22,18,29,7,28,12,35,3,26]
    let segmentAngle = 9.72972972972973
    let redNumbers: Set<Int> = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36]
    
    @State private var rotation: Double = 0
    @State private var betChoice: BetChoice = .none
    @State private var selectedColorRed: Bool? = nil
    @State private var selectedDozen: Int? = nil
    @State private var straightNumber: Int? = nil
    @State private var selectedBetAmount: Int? = nil
    @State private var gameMessage: String = "Place your bet…"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Cash: $\(cash)")
                .font(.title2)
                .bold()
            
            // Bet amount selection
            HStack(spacing: 15) {
                ForEach([50, 100, 150], id: \.self) { amount in
                    Button("$\(amount)") {
                        selectedBetAmount = amount
                        gameMessage = "Bet amount set to $\(amount)"
                    }
                    .buttonStyle(.bordered)
                }
            }
            
            // Wheel display
            ZStack {
                Rectangle()
                    .fill()
                    .foregroundStyle(myColor)
                Image("rouletteWheel")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .rotationEffect(.degrees(rotation))
                    .animation(.easeOut(duration: 4), value: rotation)
                Image(systemName: "arrow.up")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.black)
                    .offset(y: -100)
            }
            .padding()
            
            Text(gameMessage)
                .font(.headline)
            
            // Bet type selection using drop-down menus
            HStack(spacing: 15) {
                // 1:1 bet on Red or Black
                Menu("Bet 1:1") {
                    Button("Red") {
                        guard let amount = selectedBetAmount else {
                            gameMessage = "Select a bet amount first."
                            return
                        }
                        betChoice = .oneToOne
                        selectedColorRed = true
                        gameMessage = "Betting $\(amount) on Red"
                    }
                    Button("Black") {
                        guard let amount = selectedBetAmount else {
                            gameMessage = "Select a bet amount first."
                            return
                        }
                        betChoice = .oneToOne
                        selectedColorRed = false
                        gameMessage = "Betting $\(amount) on Black"
                    }
                }
                .buttonStyle(.borderedProminent)
                
                // 2:1 bet on dozens
                Menu("Bet 2:1") {
                    Button("1st Dozen (1-12)") {
                        guard let amount = selectedBetAmount else {
                            gameMessage = "Select a bet amount first."
                            return
                        }
                        betChoice = .twoToOne
                        selectedDozen = 1
                        gameMessage = "Betting $\(amount) on Dozen 1"
                    }
                    Button("2nd Dozen (13-24)") {
                        guard let amount = selectedBetAmount else {
                            gameMessage = "Select a bet amount first."
                            return
                        }
                        betChoice = .twoToOne
                        selectedDozen = 2
                        gameMessage = "Betting $\(amount) on Dozen 2"
                    }
                    Button("3rd Dozen (25-36)") {
                        guard let amount = selectedBetAmount else {
                            gameMessage = "Select a bet amount first."
                            return
                        }
                        betChoice = .twoToOne
                        selectedDozen = 3
                        gameMessage = "Betting $\(amount) on Dozen 3"
                    }
                }
                .buttonStyle(.borderedProminent)
                
                // 35:1 straight-up bet on any number
                Menu("Bet 35:1") {
                    ForEach(pockets, id: \.self) { num in
                        Button("\(num)") {
                            guard let amount = selectedBetAmount else {
                                gameMessage = "Select a bet amount first."
                                return
                            }
                            betChoice = .thirtyFiveToOne
                            straightNumber = num
                            gameMessage = "Betting $\(amount) on \(num)"
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                
                // Clear selections
                Button("Clear") {
                    betChoice = .none
                    selectedColorRed = nil
                    selectedDozen = nil
                    straightNumber = nil
                    selectedBetAmount = nil
                    gameMessage = "Place your bet…"
                }
                .buttonStyle(.bordered)
            }
            
            // Spin the wheel
            Button("Spin") {
                spinWheel()
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        .padding()
    }
    
    func spinWheel() {
        let targetIndex = Int.random(in: 0..<pockets.count)
        let pocketCenter = Double(targetIndex) * segmentAngle + (segmentAngle / 2)
        let landingOffset = 360 - pocketCenter
        rotation = 5 * 360 + landingOffset
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            let raw = rotation.truncatingRemainder(dividingBy: 360)
            let pointerAngle = (360 - raw + (segmentAngle / 2)).truncatingRemainder(dividingBy: 360)
            var landedIndex = 0
            for i in 0..<pockets.count {
                let start = Double(i) * segmentAngle
                let end = start + segmentAngle
                if pointerAngle >= start && pointerAngle < end {
                    landedIndex = i
                    break
                }
            }
            let landedNumber = pockets[landedIndex]
            let isRed = redNumbers.contains(landedNumber)
            guard let amount = selectedBetAmount else {
                gameMessage = "Landed on \(landedNumber) — no bet amount selected."
                return
            }
            switch betChoice {
            case .oneToOne:
                if landedNumber != 0, isRed == selectedColorRed {
                    cash += amount
                    gameMessage = "Landed on \(landedNumber) — you win $\(amount)!"
                } else {
                    cash -= amount
                    gameMessage = "Landed on \(landedNumber) — you lose $\(amount)..."
                }
            case .twoToOne:
                var win = false
                if let dozen = selectedDozen {
                    switch dozen {
                    case 1: win = (1...12).contains(landedNumber)
                    case 2: win = (13...24).contains(landedNumber)
                    case 3: win = (25...36).contains(landedNumber)
                    default: win = false
                    }
                }
                if win {
                    cash += amount * 2
                    gameMessage = "Landed on \(landedNumber) — you win $\(amount * 2)!"
                } else {
                    cash -= amount
                    gameMessage = "Landed on \(landedNumber) — you lose $\(amount)..."
                }
            case .thirtyFiveToOne:
                if landedNumber == straightNumber {
                    cash += amount * 35
                    gameMessage = "Landed on \(landedNumber) — you win $\(amount * 35)!"
                } else {
                    cash -= amount
                    gameMessage = "Landed on \(landedNumber) — you lose $\(amount)..."
                }
            case .none:
                gameMessage = "Landed on \(landedNumber) — no bet placed."
            }
            // Reset for next round
            selectedBetAmount = nil
            betChoice = .none
        }
    }
}
