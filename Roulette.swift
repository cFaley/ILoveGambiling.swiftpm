import SwiftUI

struct Bet {
    let name: String
    let covers: [Int]
    let payout: Int
}

struct Roulette: View {
    @AppStorage("cash") var cash: Int = 5000
    
    let pockets = [0, 32, 15, 19, 4, 21, 2, 25, 17, 34,
                   6, 27, 13, 36, 11, 30, 8, 23, 10, 5,
                   24, 16, 33, 1, 20, 14, 31, 9, 22, 18,
                   29, 7, 28, 12, 35, 3, 26]
    let slice = 360.0 / 37.0
    
    private var bets: [Bet] {
        var b = [Bet]()
        
        // Even-money (1:1)
        let reds   = Set([1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36])
        let blacks = Set((1...36).filter { !reds.contains($0) })
        b += [
            Bet(name: "Red",        covers: Array(reds),   payout: 1),
            Bet(name: "Black",      covers: Array(blacks), payout: 1),
            Bet(name: "Odd",        covers: (1...36).filter{$0%2==1}, payout:1),
            Bet(name: "Even",       covers: (1...36).filter{$0%2==0}, payout:1),
            Bet(name: "Low (1–18)", covers: Array(1...18), payout: 1),
            Bet(name: "High (19–36)",covers: Array(19...36), payout: 1)
        ]
        
        // Dozens (2:1)
        b += [
            Bet(name: "1st 12", covers: Array(1...12),   payout: 2),
            Bet(name: "2nd 12", covers: Array(13...24),  payout: 2),
            Bet(name: "3rd 12", covers: Array(25...36),  payout: 2)
        ]
        
        // Straight-up (35:1)
        b += (0...36).map { n in
            Bet(name: "\(n)", covers: [n], payout: 35)
        }
        
        return b
    }
    
    @State var rotation  = 0.0
       @State var wagerText = "100"
       @State var toast     = ""
       @State var showToast = false
    
    var body: some View {
        Image(systemName: "arrow.down")
            .resizable()
            .frame(width:75, height: 75)
            .offset(x:-20,y:30)
        HStack{
            Image("rouletteWheel")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .rotationEffect(.degrees(rotation))
                .animation(.easeOut(duration: 4), value: rotation)
            
            if let uiImage = loadWheelImage() {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .rotationEffect(.degrees(rotation))
                    .animation(.easeOut(duration: 4), value: rotation)
            }
            
            Button("Spin", action: spin)
                .frame(width:50, height:25)
                .background(.green)
                .foregroundColor(.white)
        }
        Text("Make your choice:")
            .font(.title)
            .bold()
        HStack{
            Button("Red") {
                
            }
            Button("Black") {
                
            }
            Button("Even") {
                
            }
            Button("Odd") {
                
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
    func loadWheelImage() -> UIImage? {
        let path = "/mnt/data/a34fad5f-2621-4067-aca1-7f9ecaff2ba7-removebg-preview.png"
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return nil }
        return UIImage(data: data)
    }
    func spin() {
        let extra = Double.random(in: 3...5) * 360
        rotation += extra
    }
}
