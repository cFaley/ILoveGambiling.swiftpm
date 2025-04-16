import SwiftUI

struct Slots: View {
    @State var slot1 = 0
    @State var slot2 = 0
    @State var slot3 = 0
//    @State var IsSpinning = true
//    @State var count = 0
    var body: some View {
        VStack {
            
            HStack{
                ZStack{
                    Rectangle()
                        .foregroundStyle(.gray)
//                    Text("\(slot1)")
                    Image("Image\(slot1)")
                        .resizable()
                    
                }
                .frame(width: 100, height: 200, alignment: .leading)
                ZStack{
                    Rectangle()
                        .foregroundStyle(.gray)
//                    Text("\(slot2)")
                    Image("Image\(slot2)")
                        .resizable()
                }
                .frame(width: 100, height: 200, alignment: .center)
                ZStack{
                    Rectangle()
                        .foregroundStyle(.gray)
//                    Text("\(slot3)")
                    Image("Image\(slot3)")
                        .resizable()
                }
                .frame(width: 100, height: 200, alignment: .trailing)
            }
            Button {
                //                slot1 = Int.random(in: 1..<4)
                //                slot2 = Int.random(in: 1..<4)
                //                slot3 = Int.random(in: 1..<4)
                Spin()
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
            
        }
    }

    func Spin() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            let randomNumber = Int.random(in: 1...20)
            print("Number: \(randomNumber)")

            DispatchQueue.main.async {
                self.slot1 = Int.random(in: 1..<4)
                self.slot2 = Int.random(in: 1..<4)
                self.slot3 = Int.random(in: 1..<4)
            }

            if randomNumber == 10 {
                timer.invalidate()
            }
        }
    }

    
}
