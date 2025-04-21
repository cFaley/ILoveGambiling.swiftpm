import SwiftUI

struct Poker: View {
    @State var cardPool = [""]
    @State var yourHand = [""]
    @State var AIHand = [""]
    @State var River = [""]
    @State var RoundNum = 0
    var body: some View {
        VStack{
            
            ForEach(0..<cardPool.count, id: \.self){card in
                Text("\(cardPool[card])")
            }
            .onAppear(){
                StartGame()
               
            }
            Text("AI1 hand:")
            HStack{
                ForEach(0..<AIHand.count, id: \.self){card in
                    Text("\(AIHand[card])")
                }
            }
            Text("river:")
            Text("Your Hand:")
            HStack{
                ForEach(0..<yourHand.count, id: \.self){card in
                    Text("\(yourHand[card])")
                }
            }
            HStack{
                Button("Call") {
                    NextRound()
                }
            }
            Button("New Game") {
                StartGame()
            }
        }
    }
    func StartGame(){
        cardPool = [""]
        yourHand = [""]
        AIHand = [""]
        cardPool = ["CA","SA","HA","DA","CK","SK","HK","DK","CQ","SQ","HQ","DQ"]
        let card1 = Int.random(in: 1..<cardPool.count)
        yourHand.append(cardPool[card1])
        cardPool.remove(at: card1)
        let card2 = Int.random(in: 1..<cardPool.count)
        yourHand.append(cardPool[card2])
        cardPool.remove(at: card2)
        let AIcard1 = Int.random(in: 1..<cardPool.count)
        AIHand.append(cardPool[AIcard1])
        cardPool.remove(at: AIcard1)
        let AIcard2 = Int.random(in: 1..<cardPool.count)
        AIHand.append(cardPool[AIcard2])
        cardPool.remove(at: AIcard2)
    }
    func NextRound(){
        if RoundNum == 0{
            let RiverCard1 = Int.random(in: 1..<cardPool.count)
            River.append(cardPool[RiverCard1])
            cardPool.remove(at: RiverCard1)
            let RiverCard2 = Int.random(in: 1..<cardPool.count)
            River.append(cardPool[RiverCard2])
            cardPool.remove(at: RiverCard2)
            let RiverCard3 = Int.random(in: 1..<cardPool.count)
            River.append(cardPool[RiverCard3])
            cardPool.remove(at: RiverCard3)
        }
        
        RoundNum += 1
    }
}
