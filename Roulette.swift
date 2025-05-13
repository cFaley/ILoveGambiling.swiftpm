import SwiftUI

enum BetChoice { case none, oneToOne, twoToOne, thirtyFiveToOne }

struct Roulette: View {
    @AppStorage("cash") var cash: Int = 5000
    
    let myColor = Color(red: 107/255, green: 13/255, blue: 14/255)
    let pockets = [
        0,32,15,19,4,21,2,25,17,34,
        6,27,13,36,11,30,8,23,10,5,
        24,16,33,1,20,14,31,9,22,18,
        29,7,28,12,35,3,26
    ]
    let segmentAngle = 9.72972972972973
    let redNumbers: Set<Int> = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36]
    
    @State var rotation: Double = 0
    @State var betChoice: BetChoice = .none
    @State var selectedColorRed: Bool? = nil
    @State var selectedDozen: Int? = nil
    @State var straightNumber: Int? = nil
    @State var selectedBetAmount: Int? = nil
    @State var gameMessage: String = "Place your bet…"
    @State var amountLabel: String = "$ Bet:"
    @State var oneToOneLabel: String = "1:1"
    @State var twoToOneLabel: String = "2:1"
    @State var thirtyFiveLabel: String = "35:1"
    
    var body: some View {
        ZStack{
            myColor.ignoresSafeArea()
            VStack {
                Text("Cash: $\(cash)")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .bold()
                
                Text(gameMessage)
                    .foregroundStyle(.white)
                    .font(.headline)
                    .padding(.top)
                
                ZStack {
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
                
                HStack {
                    Menu(amountLabel) {
                        ForEach([50, 100, 150, 200], id: \.self) { amt in
                            Button("$\(amt)") {
                                selectedBetAmount = amt
                                amountLabel = "\(amt)"
                                gameMessage = "Bet amount set to $\(amt)"
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(selectedBetAmount != nil && betChoice != .none)
                    
                    Menu(oneToOneLabel) {
                        Button("Red") {
                            guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                            betChoice = .oneToOne
                            selectedColorRed = true
                            oneToOneLabel = "Red"
                            gameMessage = "Betting $\(amt) on Red"
                        }
                        Button("Black") {
                            guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                            betChoice = .oneToOne
                            selectedColorRed = false
                            oneToOneLabel = "Black"
                            gameMessage = "Betting $\(amt) on Black"
                        }
                        Button("Odd") {
                            guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                            betChoice = .oneToOne
                            oneToOneLabel = "Odd"
                            gameMessage = "Betting $\(amt) on Odd"
                        }
                        Button("Even") {
                            guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                            betChoice = .oneToOne
                            oneToOneLabel = "Even"
                            gameMessage = "Betting $\(amt) on Even"
                        }
                        Button("Low (1–18)") {
                            guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                            betChoice = .oneToOne
                            oneToOneLabel = "Low"
                            gameMessage = "Betting $\(amt) on Low (1–18)"
                        }
                        Button("High (19–36)") {
                            guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                            betChoice = .oneToOne
                            oneToOneLabel = "High"
                            gameMessage = "Betting $\(amt) on High (19–36)"
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(selectedBetAmount != nil && betChoice != .none)
                    
                    Menu(twoToOneLabel) {
                        Button("1st Dozen") {
                            guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                            betChoice = .twoToOne
                            selectedDozen = 1
                            twoToOneLabel = "1st Dozen"
                            gameMessage = "Betting $\(amt) on 1st Dozen"
                        }
                        Button("2nd Dozen") {
                            guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                            betChoice = .twoToOne
                            selectedDozen = 2
                            twoToOneLabel = "2nd Dozen"
                            gameMessage = "Betting $\(amt) on 2nd Dozen"
                        }
                        Button("3rd Dozen") {
                            guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                            betChoice = .twoToOne
                            selectedDozen = 3
                            twoToOneLabel = "3rd Dozen"
                            gameMessage = "Betting $\(amt) on 3rd Dozen"
                        }
                        Button("Column 1") {
                            guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                            betChoice = .twoToOne
                            selectedDozen = 4
                            twoToOneLabel = "Column 1"
                            gameMessage = "Betting $\(amt) on Column 1"
                        }
                        Button("Column 2") {
                            guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                            betChoice = .twoToOne
                            selectedDozen = 5
                            twoToOneLabel = "Column 2"
                            gameMessage = "Betting $\(amt) on Column 2"
                        }
                        Button("Column 3") {
                            guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                            betChoice = .twoToOne
                            selectedDozen = 6
                            twoToOneLabel = "Column 3"
                            gameMessage = "Betting $\(amt) on Column 3"
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(selectedBetAmount != nil && betChoice != .none)
                    
                    Menu(thirtyFiveLabel) {
                        ForEach(0...36, id: \.self) { num in
                            Button("\(num)") {
                                guard let amt = selectedBetAmount else { gameMessage = "Select amount first."; return }
                                betChoice = .thirtyFiveToOne
                                straightNumber = num
                                thirtyFiveLabel = "\(num)"
                                gameMessage = "Betting $\(amt) on \(num)"
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(selectedBetAmount != nil && betChoice != .none)
                    
                    Button("Clear") {
                        selectedBetAmount = nil
                        betChoice = .none
                        selectedColorRed = nil
                        selectedDozen = nil
                        straightNumber = nil
                        amountLabel = "$ Bet:"
                        oneToOneLabel = "1:1"
                        twoToOneLabel = "2:1"
                        thirtyFiveLabel = "35:1"
                        gameMessage = "Place your bet…"
                    }
                    .buttonStyle(.bordered)
                }
                
                Button("Spin") {
                    spinWheel()
                }
                .buttonStyle(.borderedProminent)
                .font(.title2)
                .disabled(selectedBetAmount == nil || betChoice == .none)
            }
        }
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
                gameMessage = "Landed on \(landedNumber) — no bet amount."
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
                if let sel = selectedDozen {
                    switch sel {
                    case 1: win = (1...12).contains(landedNumber)
                    case 2: win = (13...24).contains(landedNumber)
                    case 3: win = (25...36).contains(landedNumber)
                    case 4: win = [1,4,7,10,13,16,19,22,25,28,31,34].contains(landedNumber)
                    case 5: win = [2,5,8,11,14,17,20,23,26,29,32,35].contains(landedNumber)
                    case 6: win = [3,6,9,12,15,18,21,24,27,30,33,36].contains(landedNumber)
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
        }
    }
}
