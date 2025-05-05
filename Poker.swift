import SwiftUI


struct Poker: View {
    @State var cardPool = [""]
    @State var yourHand = [""]
    @State var AIHand = [""]
    @State var River = [""]
    @State var RoundNum = 0
    @State var YourHandRank = 0
    @State var AIHandRank = 0
    @State var YourHighCard = 0
    @State var AIHighCard = 0
    @State var value1 = ""
    @State var value2 = ""
    @State var Rvalue1 = ""
    @State var Rvalue2 = ""
    @State var Rvalue3 = ""
    @State var Rvalue4 = ""
    @State var Rvalue5 = ""
    @State var TwoPairDict: [String : Int] = ["2":0,"3":0,"4":0,"5":0,"6":0,"7":0,"8":0,"9":0,"10":0,"J":0,"Q":0,"K":0,"A":0]
    @State var FlushDict: [String : Int] = ["C":0,"S":0,"D":0,"H":0]
    @State var PlayerCardNum: [Int : [Int:String]] = [:]
    var body: some View {
        VStack{
            
            //            ForEach(0..<cardPool.count, id: \.self){card in
            //                Text("\(cardPool[card])")
            //            }
            
            Text("AI hand:")
            HStack{
                ForEach(0..<AIHand.count, id: \.self){card in
                    //                    Text("\(AIHand[card])")
                    Image("\(AIHand[card])")
                        .resizable()
                        .frame(width: 50, height: 75, alignment: .center)
                }
            }
            Text("river:")
            HStack{
                ForEach(0..<River.count, id: \.self){card in
                    //                    Text("\(River[card])")
                    Image("\(River[card])")
                        .resizable()
                        .frame(width: 50, height: 75, alignment: .center)
                }
            }
            Text("Your Hand:")
            HStack{
                ForEach(0..<yourHand.count, id: \.self){card in
                    //                    Text("\(yourHand[card])")
                    Image("\(yourHand[card])")
                        .resizable()
                        .frame(width: 50, height: 75, alignment: .center)
                }
            }
            Text("\(YourHandRank)")
            HStack{
                Button("Call") {
                    if RoundNum == 3{
                        RateHands()
                    }
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
        YourHandRank = 0
        RoundNum = 0
        River = []
        cardPool = []
        yourHand = []
        AIHand = []
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
    func PairPlayer(){
        //        var cards: [String : Int] = [:]
        TwoPairDict = ["2":0,"3":0,"4":0,"5":0,"6":0,"7":0,"8":0,"9":0,"10":0,"J":0,"Q":0,"K":0,"A":0]
        for card in yourHand{
            //            var counter = 1
            TwoPairDict[String(card.dropFirst())]! += 1
        }
        for card in River{
            //            var counter = 1
            TwoPairDict[String(card.dropFirst())]! += 1
        }
        var result = [String]()
        var result2 = [String]()
        var result3 = [String]()
        for (key, value) in TwoPairDict {
            if value == 2 {
                result.append(key)
            }
        }
        for (key, value) in TwoPairDict {
            if value == 3 {
                result2.append(key)
            }
        }
        for (key, value) in TwoPairDict {
            if value == 4 {
                result3.append(key)
            }
        }
        print("\(result.count)")
        if result.count == 0{
        }
        else{
            
            if result.count == 1{
                if YourHandRank <= 1{
                    YourHandRank = 1
                }
            }
            else {
                if YourHandRank <= 2{
                    YourHandRank = 2
                }
            }
        }
        if result2.count >= 1{
            if YourHandRank <= 3{
                YourHandRank = 3
            }
            if result.count >= 1{
                if YourHandRank <= 6{
                    YourHandRank = 6
                }
            }
        }
        
        if result3.count >= 1{
            if YourHandRank <= 7{
                YourHandRank = 7
            }
        }
    }
    func PlayerFlush(){
        FlushDict = ["C":0,"S":0,"D":0,"H":0]
        var currentSuit = ""
//                var SortedNums = PlayerCardNum.sorted
        for card in yourHand{
            //            var counter = 1
            FlushDict["\(String(card.first!))"]! += 1
        }
        for card in River{
            //            var counter = 1
            FlushDict["\(String(card.first!))"]! += 1
        }
        
        var result = [String]()
        for (key, value) in FlushDict {
            if value >= 5 {
                currentSuit = key
                result.append(key)
            }
        }
        var cardNumList:[Int] = []
        //        for (key, value) in PlayerCardNum {
        //            if value == currentSuit  {
        //                cardNumList.append(key)
        //            }
        //        }
        for (key, value) in PlayerCardNum {
            for (key, value) in value {
                if value == currentSuit  {
                    cardNumList.append(key)
                }
            }
        }
        
        let sortedCardNumList:[Int] = cardNumList.sorted()
        if sortedCardNumList.count >= 5 {
            
            
            if sortedCardNumList[1] + 1 == sortedCardNumList[2]{
                if sortedCardNumList[2] + 1 == sortedCardNumList[3]{
                    if sortedCardNumList[3] + 1 == sortedCardNumList[4]{
                        if sortedCardNumList[4] + 1 == sortedCardNumList[5]{
                            
                            if YourHandRank <= 9{
                                YourHandRank = 9
                            }
                        }
                    }
                }
            }
            if sortedCardNumList.count >= 6{
                
                
                
                if sortedCardNumList[2] + 1 == sortedCardNumList[3]{
                    if sortedCardNumList[3] + 1 == sortedCardNumList[4]{
                        if sortedCardNumList[4] + 1 == sortedCardNumList[5]{
                            if sortedCardNumList[5] + 1 == sortedCardNumList[6]{
                                
                                if YourHandRank <= 9{
                                    YourHandRank = 9
                                }
                            }
                        }
                    }
                }
                if sortedCardNumList.count == 7{
                    
                    if sortedCardNumList[3] + 1 == sortedCardNumList[4]{
                        if sortedCardNumList[4] + 1 == sortedCardNumList[5]{
                            if sortedCardNumList[5] + 1 == sortedCardNumList[6]{
                                if sortedCardNumList[6] + 1 == sortedCardNumList[7]{
                                    if YourHandRank <= 9{
                                        YourHandRank = 9
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if result.count >= 1{
            if YourHandRank <= 5{
                YourHandRank = 5
            }
        }
        
    }
    func RateHands(){
        let suit1 = yourHand[0].first!
        value1 = String(yourHand[0].dropFirst())
        let suit2 = yourHand[1].first!
        value2 = String(yourHand[1].dropFirst())
        let Rsuit1 = yourHand[0].first!
        Rvalue1 = String(River[0].dropFirst())
        let Rsuit2 = River[1].first!
        Rvalue2 = String(River[1].dropFirst())
        let Rsuit3 = River[2].first!
        Rvalue3 = String(River[2].dropFirst())
        let Rsuit4 = River[3].first!
        Rvalue4 = String(River[3].dropFirst())
        let Rsuit5 = River[4].first!
        Rvalue5 = String(River[4].dropFirst())
        
        
        if value1 == "A"{
            value1 = "14"
        }
        if value1 == "K"{
            value1 = "13"
        }
        if value1 == "Q"{
            value1 = "12"
        }
        if value1 == "J"{
            value1 = "11"
        }
        if value2 == "A"{
            value2 = "14"
        }
        if value2 == "K"{
            value2 = "13"
        }
        if value2 == "Q"{
            value2 = "12"
        }
        if value2 == "J"{
            value2 = "11"
        }
        if Rvalue1 == "A"{
            Rvalue1 = "14"
        }
        if Rvalue1 == "K"{
            Rvalue1 = "13"
        }
        if Rvalue1 == "Q"{
            Rvalue1 = "12"
        }
        if Rvalue1 == "J"{
            Rvalue1 = "11"
        }
        if Rvalue2 == "A"{
            Rvalue2 = "14"
        }
        if Rvalue2 == "K"{
            Rvalue2 = "13"
        }
        if Rvalue2 == "Q"{
            Rvalue2 = "12"
        }
        if Rvalue2 == "J"{
            Rvalue2 = "11"
        }
        if Rvalue3 == "A"{
            Rvalue3 = "14"
        }
        if Rvalue3 == "K"{
            Rvalue3 = "13"
        }
        if Rvalue3 == "Q"{
            Rvalue3 = "12"
        }
        if Rvalue3 == "J"{
            Rvalue3 = "11"
        }
        if Rvalue4 == "A"{
            Rvalue4 = "14"
        }
        if Rvalue4 == "K"{
            Rvalue4 = "13"
        }
        if Rvalue4 == "Q"{
            Rvalue4 = "12"
        }
        if Rvalue4 == "J"{
            Rvalue4 = "11"
        }
        if Rvalue5 == "A"{
            Rvalue5 = "14"
        }
        if Rvalue5 == "K"{
            Rvalue5 = "13"
        }
        if Rvalue5 == "Q"{
            Rvalue5 = "12"
        }
        if Rvalue5 == "J"{
            Rvalue5 = "11"
        }
        
        //        PlayerCardNum = [Int(value1)!:String(describing: suit1),Int(value2)!:String(describing: suit2),Int(Rvalue1)!:String(describing: Rsuit1),Int(Rvalue2)!:String(describing: Rsuit2),Int(Rvalue3)!:String(describing: Rsuit3),Int(Rvalue4)!:String(describing: Rsuit4),Int(Rvalue5)!:String(describing: Rsuit5)]
        
        PlayerCardNum = [1:[Int(value1)!:String(describing: suit1)],2:[Int(value2)!:String(describing: suit2)],3:[Int(Rvalue1)!:String(describing: Rsuit1)],4:[Int(Rvalue2)!:String(describing: Rsuit2)],5:[Int(Rvalue3)!:String(describing: Rsuit3)],6:[Int(Rvalue4)!:String(describing: Rsuit4)],7:[Int(Rvalue5)!:String(describing: Rsuit5)]]
        
        PairPlayer()
        PlayerFlush()
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
