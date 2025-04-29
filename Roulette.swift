import SwiftUI

struct Roulette: View {
    
    @AppStorage("cash") var cash: Int = 5000
    @State var rotation: Double = 0
    var body: some View {
        Text("Welcome to Roulette!")
        HStack{
            Image("rouletteWheel")
              .resizable()
              .aspectRatio(1, contentMode: .fit)
              .rotationEffect(.degrees(rotation))
              .animation(.easeOut(duration: 4), value: rotation)
            VStack{
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width:50, height: 50)
                    .offset(x:-20, y: -3)
                
                Button("Spin", action: spinWheel)
                    .frame(width:50, height:25)
                    .background(.green)
                    .foregroundColor(.white)
            }
        }
        Text("Make your choice:")
            .font(.title)
            .bold()
        HStack{
            Button("Red") {
                
            }
            Button("Black") {
                
            }
        }
        HStack{
            Button("0") {
                
            }
            Button("1") {
                
            }
            Button("2") {
                
            }
            Button("3") {
                
            }
            Button("4") {
                
            }
        }
        HStack{
            Button("5") {
                
            }
            Button("6") {
                
            }
            Button("7") {
                
            }
            Button("8") {
                
            }
            Button("10") {
                
            }
            Button("11") {
                
            }
        }
        HStack{
            Button("12") {
                
            }
            Button("13") {
                
            }
            Button("14") {
                
            }
            Button("15") {
                
            }
            Button("16") {
                
            }
            Button("17") {
                
            }
        }
        HStack{
            Button("18") {
                
            }
            Button("19") {
                
            }
            Button("20") {
                
            }
            Button("21") {
                
            }
            Button("22") {
                
            }
            Button("23") {
                
            }
        }
        HStack{
            Button("24") {
                
            }
            Button("25") {
                
            }
            Button("26") {
                
            }
            Button("27") {
                
            }
            Button("28") {
                
            }
            Button("29") {
                
            }
        }
        HStack{
            Button("30") {
                
            }
            Button("31") {
                
            }
            Button("32") {
                
            }
            Button("33") {
                
            }
            Button("34") {
                
            }
            Button("35") {
                
            }
            Button("36") {
                
            }
        }
    }
    func spinWheel() {
        let extraTurns = Double.random(in: 720...1440)
        rotation += extraTurns
    }
}
