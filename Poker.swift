import SwiftUI

struct Poker: View {
    @State var cardPool = [""]
    @State var yourHand = [""]
    var body: some View {
        VStack{
            
            ForEach(0..<cardPool.count, id: \.self){card in
                Text("\(cardPool[card])")
            }
            .onAppear(){
                StartGame()
                let card1 = Int.random(in: 1..<cardPool.count)
                yourHand.append(cardPool[card1])
                cardPool.remove(at: card1)
                let card2 = Int.random(in: 1..<cardPool.count)
                yourHand.append(cardPool[card2])
                cardPool.remove(at: card2)
            }
            HStack{
                ForEach(0..<yourHand.count, id: \.self){card in
                    Text("\(yourHand[card])")
                }
            }
            
        }
    }
    func StartGame(){
        cardPool = ["CA","SA","HA","DA","CK","SK","HK","DK","CQ","SQ","HQ","DQ"]
    }
}
