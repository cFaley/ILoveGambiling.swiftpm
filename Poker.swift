import SwiftUI

struct Poker: View {
    @State var cardPool = [""]
    @State var yourHand = [""]
    @State var AIHand = [""]
    @State var River = [""]
    @State var RoundNum = 0
    var body: some View {
        VStack{
            
//            ForEach(0..<cardPool.count, id: \.self){card in
//                Text("\(cardPool[card])")
//            }
          
            Text("AI1 hand:")
            HStack{
                ForEach(0..<AIHand.count, id: \.self){card in
                    Text("\(AIHand[card])")
                }
            }
            Text("river:")
            HStack{
                ForEach(0..<River.count, id: \.self){card in
                    Text("\(River[card])")
                }
            }
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
        .onAppear(){
            StartGame()
           
        }
    }
    func StartGame(){
        RoundNum = 0
        River = [""]
        cardPool = [""]
        yourHand = [""]
        AIHand = [""]
        cardPool = ["CA","SA","HA","DA","CK","SK","HK","DK","CQ","SQ","HQ","DQ","CJ","SJ","HJ","DJ","C10","S10","H10","D10","C9","S9","H9","D9","C8","S8","H8","D8","C7","S7","H7","D7","C6","S6","H6","D6","C5","S5","H5","D5","C4","S4","H4","D4","C3","S3","H3","D3","C2","S2","H2","D2"]
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
    func RateHands(){
        
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
        if RoundNum == 1{
            let RiverCard4 = Int.random(in: 1..<cardPool.count)
            River.append(cardPool[RiverCard4])
            cardPool.remove(at: RiverCard4)
        }
        if RoundNum == 2{
            let RiverCard5 = Int.random(in: 1..<cardPool.count)
            River.append(cardPool[RiverCard5])
            cardPool.remove(at: RiverCard5)
        }
        
        RoundNum += 1
    }
    
}
