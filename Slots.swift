import SwiftUI

struct Slots: View {
    @State var slot1 = 0
    @State var slot2 = 0
    @State var slot3 = 0
//    @State var IsSpinning = true
//    @State var count = 0
    @AppStorage("cash") var cash: Int = 5000
    @State var canSpin = true
    @State var YourHandRank = 0
    @State var AIHandRank = 0
    var body: some View {
        VStack {
            Text("Cash $\(cash)")
            HStack{
                ZStack{
                    Rectangle()
                        .foregroundStyle(.gray)
//                    Text("\(slot1)")
                    Image("Image\(slot1)")
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                }
                .frame(width: 100, height: 200, alignment: .leading)
                ZStack{
                    Rectangle()
                        .foregroundStyle(.gray)
//                    Text("\(slot2)")
                    Image("Image\(slot2)")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .frame(width: 100, height: 200, alignment: .center)
                ZStack{
                    Rectangle()
                        .foregroundStyle(.gray)
//                    Text("\(slot3)")
                    Image("Image\(slot3)")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .frame(width: 100, height: 200, alignment: .trailing)
            }
            Button {
                //                slot1 = Int.random(in: 1..<4)
                //                slot2 = Int.random(in: 1..<4)
                //                slot3 = Int.random(in: 1..<4)
                if canSpin == true{
                    
                    
                    cash -= 100
                    Spin()
                }
                //                                IsSpinning = false
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: 300, height: 100, alignment: .center)
                    Text("Spin!!!")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                }
            }
            Text("$100 Per Spin")
                .font(.largeTitle)
            Image("Chart1")
                .resizable()
                .frame(width: 300, height: 200, alignment: .center)
        }
    }

    func AddMoney() {
        if slot1 == 2{
            if slot2 == 2{
                if slot3 == 2{
                    cash += 9000
                }
            }
        }
        if slot1 == slot2{
            if slot2 == slot3{
                cash += 1000
            }
            else{
                cash += 200
            }
        }
        else{
            if slot2 == slot3{
                cash += 200
            }
            else{
                if slot1 == slot3{
                    cash += 200
                    
                }
            }
                
        }
    }
    
    
    func Spin() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            let randomNumber = Int.random(in: 1...20)
//            print("Number: \(randomNumber)")

            DispatchQueue.main.async {
                self.canSpin = false
                self.slot1 = Int.random(in: 1..<7)
                self.slot2 = Int.random(in: 1..<7)
                self.slot3 = Int.random(in: 1..<7)
            }

            if randomNumber == 10 {
                DispatchQueue.main.async {
                    self.canSpin = true
                    self.AddMoney()
                    
                }
                timer.invalidate()
            }
        }
    }
    
    
}
