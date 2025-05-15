import SwiftUI
struct Poker: View {
    let myColor = Color(red: 107/255, green: 13/255, blue: 14/255)
    @State var cardPool = [""]
    @State var yourHand = [""]
    @State var AIHand = [""]
    @State var AIHandVisual = ["BC","BC"]
    @State var River = [""]
    @State var RoundNum = 0
    @State var YourHandRank = 0
    @State var AIHandRank = 0
    @State var YourHighCard = 0
    @State var AIHighCard = 0
    @State var value1 = ""
    @State var value2 = ""
    @State var AIvalue1 = ""
    @State var AIvalue2 = ""
    @State var Rvalue1 = ""
    @State var Rvalue2 = ""
    @State var Rvalue3 = ""
    @State var Rvalue4 = ""
    @State var Rvalue5 = ""
    @State var TwoPairDict: [String : Int] = ["2":0,"3":0,"4":0,"5":0,"6":0,"7":0,"8":0,"9":0,"10":0,"J":0,"Q":0,"K":0,"A":0]
    @State var FlushDict: [String : Int] = ["C":0,"S":0,"D":0,"H":0]
    @State var AIFlushDict: [String : Int] = ["C":0,"S":0,"D":0,"H":0]
    @State var PlayerCardNum: [Int : [Int:String]] = [:]
    @State var AICardNum: [Int : [Int:String]] = [:]
    @State var RiverShown = [""]
    @State var YourBet = 100
    @State var AIBet = 100
    @State var addToBet = 0
    @State var IsBetting = false
    @State var AIfolded = false
    @AppStorage("cash") var cash: Int = 5000
    var body: some View {
        ZStack{
            myColor.ignoresSafeArea()
            
            VStack{
                
                //            ForEach(0..<cardPool.count, id: \.self){card in
                //                Text("\(cardPool[card])")
                //            }
                //            Circle()
                //                .frame(width: 100, height: 100, alignment: .center)
                //                .onTapGesture {
                //                    River = ["HJ","HK","HQ","CA","C10"]
                //                    yourHand = ["H10","HA"]
                //                }
                
                
                
                if AIfolded{
                    Text("AI Folds")
                        .foregroundStyle(.white)
                        .font(.title)
                    
                        .onAppear(){
                            RoundNum = 5
                            AIHandVisual = AIHand
                        }
                }
                if RoundNum >= 4{
                    
                    
                    if YourHandRank > AIHandRank{
                        Text("You Win!")
                            .foregroundStyle(.white)
                            .font(.title)
                        
                            .onAppear(){
                                cash += YourBet
                                YourBet = 0
                            }
                    }
                    if AIHandRank > YourHandRank{
                        Text("AIWins")
                            .foregroundStyle(.white)
                            .font(.title)
                        
                            .onAppear(){
                                cash -= YourBet
                                YourBet = 0
                            }
                    }
                    if YourHandRank == AIHandRank{
                        if YourHighCard > AIHighCard{
                            Text("You Win!")
                                .foregroundStyle(.white)
                                .font(.title)
                            
                                .onAppear(){
                                    cash += YourBet
                                    YourBet = 0
                                }
                        }
                        else{
                            Text("AIWins")
                                .foregroundStyle(.white)
                                .font(.title)
                            
                                .onAppear(){
                                    cash -= YourBet
                                    YourBet = 0
                                }
                        }
                    }
                }
                //            Text("\(AIHandRank)")
                Text("AI hand:")
                    .foregroundStyle(.white)
                    .font(.title)
                
                ZStack{
                    Rectangle()
                        .fill(.gray.gradient)
                        .frame(width: 125, height: 100, alignment: .center)
                    HStack{
                        ForEach(0..<AIHandVisual.count, id: \.self){card in
                            //                    Text("\(AIHand[card])")
                            Image("\(AIHandVisual[card])")
                                .resizable()
                                .frame(width: 50, height: 75, alignment: .center)
                        }
                    }
                }
                Text("AI Bet:$\(AIBet)")
                    .foregroundStyle(.white)
                    .font(.title)
                
                Text("river:")
                    .foregroundStyle(.white)
                    .font(.title)
                ZStack{
                    Rectangle()
                        .fill(.gray.gradient)
                        .frame(width: 300, height: 100, alignment: .center)
                    HStack{
                        ForEach(0..<RiverShown.count, id: \.self){card in
                            //                    Text("\(River[card])")
                            Image("\(RiverShown[card])")
                                .resizable()
                                .frame(width: 50, height: 75, alignment: .center)
                        }
                    }
                }
                Text("Your Hand:")
                    .foregroundStyle(.white)
                    .font(.title)
                ZStack{
                    Rectangle()
                        .fill(.gray.gradient)
                        .frame(width: 125, height: 100, alignment: .center)
                    
                    HStack{
                        ForEach(0..<yourHand.count, id: \.self){card in
                            //                    Text("\(yourHand[card])")
                            Image("\(yourHand[card])")
                                .resizable()
                                .frame(width: 50, height: 75, alignment: .center)
                        }
                    }
                }
                //            Text("\(YourHandRank)")
                Text("Current bet:$\(YourBet)")
                    .foregroundStyle(.white)
                    .font(.title)
                
                HStack{
                    if RoundNum < 4{
                        
                        
                        Button("Call") {
                            if RoundNum == 3{
                                RateHands()
                                AIHandVisual = AIHand
                            }
                            YourBet = AIBet
                            NextRound()
                        }
                        .font(.title)
                        .padding()
                        
                    }
                    if RoundNum > 0{
                        if RoundNum < 4{
                            
                            Menu("Bet") {
                                ForEach([50, 100, 150, 200, 1000], id: \.self) { amt in
                                    Button("$\(amt)") {
                                        YourBet = AIBet
                                        YourBet += amt
                                        //                                    IsBetting = true
                                        NextRound()
                                    }
                                    .buttonStyle(.borderedProminent)
                                }
                            }
                            .font(.title)
                            .padding()
                            Button("Fold") {
                                StartGame()
                            }
                            .font(.title)
                            .padding()
                            
                        }
                    }
                    
                }
                if RoundNum >= 4{
                    Button("New Game") {
                        StartGame()
                    }
                    .font(.title)
                    .padding()
                }
            }
            .onAppear(){
                StartGame()
                
            }
            
        }
    }
    func StartGame(){
        cash -= YourBet
        YourHandRank = 0
        AIHandRank = 0
        RoundNum = 0
        YourBet = 0
        AIBet = 0
        River = []
        RiverShown = []
        cardPool = []
        yourHand = []
        AIHand = []
        AIfolded = false
        AIHandVisual = ["BC","BC"]
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
    func PairAI(){
        //        var cards: [String : Int] = [:]
        TwoPairDict = ["2":0,"3":0,"4":0,"5":0,"6":0,"7":0,"8":0,"9":0,"10":0,"J":0,"Q":0,"K":0,"A":0]
        for card in AIHand{
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
                if AIHandRank <= 1{
                    AIHandRank = 1
                }
            }
            else {
                if AIHandRank <= 2{
                    AIHandRank = 2
                }
            }
        }
        if result2.count >= 1{
            if AIHandRank <= 3{
                AIHandRank = 3
            }
            if result.count >= 1{
                if AIHandRank <= 6{
                    AIHandRank = 6
                }
            }
        }
        
        if result3.count >= 1{
            if AIHandRank <= 7{
                AIHandRank = 7
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
        print(sortedCardNumList)
        
        
        if sortedCardNumList.count >= 5 {
            if sortedCardNumList.last == 14{
                if sortedCardNumList[sortedCardNumList.count - 2] == 13{
                    if sortedCardNumList[sortedCardNumList.count - 3] == 12{
                        if sortedCardNumList[sortedCardNumList.count - 4] == 11{
                            if sortedCardNumList[sortedCardNumList.count - 5] == 10{
                                YourHandRank = 10
                            }
                        }
                    }
                }
            }
            
            if sortedCardNumList[0] + 1 == sortedCardNumList[1]{
                print("1")
                if sortedCardNumList[1] + 1 == sortedCardNumList[2]{
                    print("2")
                    if sortedCardNumList[2] + 1 == sortedCardNumList[3]{
                        print("3")
                        if sortedCardNumList[3] + 1 == sortedCardNumList[4]{
                            print("4")
                            
                            if YourHandRank <= 9{
                                print("5")
                                YourHandRank = 9
                                
                            }
                        }
                    }
                }
            }
            if sortedCardNumList.count >= 6{
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
                if sortedCardNumList.count == 7{
                    
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
                }
            }
        }
        if result.count >= 1{
            if YourHandRank <= 5{
                YourHandRank = 5
            }
        }
        
    }
    func AIFlush(){
        AIFlushDict = ["C":0,"S":0,"D":0,"H":0]
        var currentSuit = ""
        //                var SortedNums = PlayerCardNum.sorted
        for card in AIHand{
            //            var counter = 1
            AIFlushDict["\(String(card.first!))"]! += 1
        }
        for card in River{
            //            var counter = 1
            AIFlushDict["\(String(card.first!))"]! += 1
        }
        
        var result = [String]()
        for (key, value) in AIFlushDict {
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
        for (key, value) in AICardNum {
            for (key, value) in value {
                if value == currentSuit  {
                    cardNumList.append(key)
                }
            }
        }
        
        let sortedCardNumList:[Int] = cardNumList.sorted()
        print(sortedCardNumList)
        
        
        if sortedCardNumList.count >= 5 {
            if sortedCardNumList.last == 14{
                if sortedCardNumList[sortedCardNumList.count - 2] == 13{
                    if sortedCardNumList[sortedCardNumList.count - 3] == 12{
                        if sortedCardNumList[sortedCardNumList.count - 4] == 11{
                            if sortedCardNumList[sortedCardNumList.count - 5] == 10{
                                AIHandRank = 10
                            }
                        }
                    }
                }
            }
            
            if sortedCardNumList[0] + 1 == sortedCardNumList[1]{
                print("1")
                if sortedCardNumList[1] + 1 == sortedCardNumList[2]{
                    print("2")
                    if sortedCardNumList[2] + 1 == sortedCardNumList[3]{
                        print("3")
                        if sortedCardNumList[3] + 1 == sortedCardNumList[4]{
                            print("4")
                            
                            if AIHandRank <= 9{
                                print("5")
                                AIHandRank = 9
                                
                            }
                        }
                    }
                }
            }
            if sortedCardNumList.count >= 6{
                if sortedCardNumList[1] + 1 == sortedCardNumList[2]{
                    if sortedCardNumList[2] + 1 == sortedCardNumList[3]{
                        if sortedCardNumList[3] + 1 == sortedCardNumList[4]{
                            if sortedCardNumList[4] + 1 == sortedCardNumList[5]{
                                
                                if AIHandRank <= 9{
                                    AIHandRank = 9
                                }
                            }
                        }
                    }
                }
                if sortedCardNumList.count == 7{
                    
                    if sortedCardNumList[2] + 1 == sortedCardNumList[3]{
                        if sortedCardNumList[3] + 1 == sortedCardNumList[4]{
                            if sortedCardNumList[4] + 1 == sortedCardNumList[5]{
                                if sortedCardNumList[5] + 1 == sortedCardNumList[6]{
                                    if AIHandRank <= 9{
                                        AIHandRank = 9
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if result.count >= 1{
            if AIHandRank <= 5{
                AIHandRank = 5
            }
        }
        
    }
    func HighCard(){
        if Int(value1)! > Int(value2)!{
            YourHighCard = Int(value1)!
        }
        else{
            YourHighCard = Int(value2)!
        }
        if Int(AIvalue1)! > Int(AIvalue2)!{
            AIHighCard = Int(AIvalue1)!
        }
        else{
            AIHighCard = Int(AIvalue2)!
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
        let AIsuit1 = AIHand[0].first!
        AIvalue1 = String(AIHand[0].dropFirst())
        let AIsuit2 = AIHand[1].first!
        AIvalue2 = String(AIHand[1].dropFirst())
        
        
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
        if AIvalue1 == "A"{
            AIvalue1 = "14"
        }
        if AIvalue1 == "K"{
            AIvalue1 = "13"
        }
        if AIvalue1 == "Q"{
            AIvalue1 = "12"
        }
        if AIvalue1 == "J"{
            AIvalue1 = "11"
        }
        if AIvalue2 == "A"{
            AIvalue2 = "14"
        }
        if AIvalue2 == "K"{
            AIvalue2 = "13"
        }
        if AIvalue2 == "Q"{
            AIvalue2 = "12"
        }
        if AIvalue2 == "J"{
            AIvalue2 = "11"
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
        AICardNum = [1:[Int(AIvalue1)!:String(describing: AIsuit1)],2:[Int(AIvalue2)!:String(describing: AIsuit2)],3:[Int(Rvalue1)!:String(describing: Rsuit1)],4:[Int(Rvalue2)!:String(describing: Rsuit2)],5:[Int(Rvalue3)!:String(describing: Rsuit3)],6:[Int(Rvalue4)!:String(describing: Rsuit4)],7:[Int(Rvalue5)!:String(describing: Rsuit5)]]
        HighCard()
        PairPlayer()
        PairAI()
        PlayerFlush()
        AIFlush()
    }
    
    func AIPlay(){
        let RandomNum = Int.random(in: 1..<100)
        RateHands()
        if RoundNum == 2{
            
        }else{
            if AIHandRank >= 8 {
                AIBet += 10000
            }else{
                
                
                if AIHandRank >= 6 {
                    if RandomNum < 2 {
                        cash += AIBet
                        YourBet = 0
                        AIBet = 0
                        AIfolded = true
                        
                    }else{
                        
                        
                        if RandomNum < 20 {
                            AIBet += 100
                            
                        }else{
                            AIBet += 1000
                        }
                    }
                }else{
                    if AIHandRank >= 4 {
                        if RandomNum < 5 {
                            cash += AIBet
                            YourBet = 0
                            AIBet = 0
                            AIfolded = true
                            
                        }else{
                            
                            
                            if RandomNum < 60 {
                                AIBet += 500
                                
                            }else{
                                AIBet += 1000
                            }
                        }
                    }else{
                        if RandomNum < 10 {
                            cash += AIBet
                            YourBet = 0
                            AIBet = 0
                            AIfolded = true
                            
                        }else{
                            if RandomNum < 40 {
                                
                            }else{
                                if RandomNum < 70 {
                                    AIBet += 100
                                }
                                
                                if RandomNum < 90 {
                                    AIBet += 200
                                    
                                }else{
                                    AIBet += 1000
                                }
                            }
                        }
                    }
                }
            }
        }
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
            let RiverCard4 = Int.random(in: 1..<cardPool.count)
            River.append(cardPool[RiverCard4])
            cardPool.remove(at: RiverCard4)
            let RiverCard5 = Int.random(in: 1..<cardPool.count)
            River.append(cardPool[RiverCard5])
            cardPool.remove(at: RiverCard5)
            YourBet = 100
            AIBet = YourBet
            RiverShown = [River[0],River[1],River[2]]
            AIPlay()
        }
        if RoundNum == 1{
            AIBet = YourBet
            RiverShown.append(River[3])
            AIPlay()
        }
        if RoundNum == 2{
            AIPlay()
            RiverShown.append(River[4])
            AIBet = YourBet
            
        }
        
        RoundNum += 1
    }
}
