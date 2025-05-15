import SwiftUI

struct ContentView: View {
    
    let myColor = Color(red: 107/255, green: 13/255, blue: 14/255)
    @AppStorage("cash") var cash: Int = 5000
    var body: some View {
        ZStack{
            myColor.ignoresSafeArea()
            
            ZStack{
                
                VStack {
                    Text("I Love Gambling❤️")
                        .foregroundStyle(.white)
                        .font(.headline)
                    
                    Text("Welcom to the CCC!!!")
                        .foregroundStyle(.white)
                        .font(.headline)
                    Text("Cash:\(cash)")
                        .foregroundStyle(.white)
                        .font(.title)
                    ZStack{
                        
                        Rectangle()
                            .fill()
                            .foregroundStyle(myColor)
                        NavigationStack{
                            ZStack{
                                myColor.ignoresSafeArea()
                                VStack{
                                    
                                    Image("gambilingMan")
                                        .resizable()
                                        .scaledToFill()
                                    HStack{
                                        NavigationLink(destination: Slots()) {
                                            ZStack{
                                                //                                            Rectangle()
                                                //                                                .fill()
                                                //                                                .foregroundStyle(myColor)
                                                //                                            RoundedRectangle(cornerRadius: 100)
                                                //                                                .frame(width: 300, height: 75, alignment: .center)
                                                //                                            Text("Slots")
                                                //                                                .font(.largeTitle)
                                                //                                                .foregroundStyle(.white)
                                                Rectangle()
                                                    .fill(.green.gradient)
                                                    .frame(width: 175, height: 175, alignment: .center)
                                                Image("SlotsButton")
                                                    .resizable()
                                                    .frame(width: 150, height: 150, alignment: .center)
                                            }
                                        }
                                        
                                        NavigationLink(destination: BlackJack()) {
                                            ZStack{
                                                //                                            Rectangle()
                                                //                                                .fill()
                                                //                                                .foregroundStyle(myColor)
                                                //                                            RoundedRectangle(cornerRadius: 100)
                                                //                                                .frame(width: 300, height: 75, alignment: .center)
                                                //                                            Text("BlackJack")
                                                //                                                .font(.largeTitle)
                                                //                                                .foregroundStyle(.white)
                                                Rectangle()
                                                    .fill(.green.gradient)
                                                    .frame(width: 175, height: 175, alignment: .center)
                                                Image("BlackJackButton")
                                                    .resizable()
                                                    .frame(width: 150, height: 150, alignment: .center)
                                                
                                            }
                                        }
                                    }
                                    HStack{
                                        NavigationLink(destination: Poker()) {
                                            ZStack{
                                                Rectangle()
                                                    .fill(.green.gradient)
                                                    .frame(width: 175, height: 175, alignment: .center)
                                                Image("PokerButton")
                                                    .resizable()
                                                    .frame(width: 150, height: 150, alignment: .center)
                                            }
                                        }
                                        NavigationLink(destination: Roulette()) {
                                            ZStack{
                                                Rectangle()
                                                    .fill(.green.gradient)
                                                    .frame(width: 175, height: 175, alignment: .center)
                                                Image("RouletteButton")
                                                    .resizable()
                                                    .frame(width: 150, height: 150, alignment: .center)
                                            }
                                        }
                                    }
                                    NavigationLink(destination: DoubleOrNothing()) {
                                        ZStack{
                                            Rectangle()
                                                .fill(.green.gradient)
                                                .frame(width: 175, height: 175, alignment: .center)
                                            Image("DoubbleOrNothingButton")
                                                .resizable()
                                                .frame(width: 150, height: 150, alignment: .center)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
