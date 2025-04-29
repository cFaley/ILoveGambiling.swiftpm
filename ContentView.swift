import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            
            VStack {
                
                Text("I Love Gambling❤️")
                    .padding()
                Text("Welcom to the CCC!!!")
                NavigationStack{
                    Image("gambilingMan")
                        .resizable()
                        .scaledToFill()
                    NavigationLink(destination: Slots()) {
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 300, height: 100, alignment: .center)
                            Text("Slots")
                                .font(.largeTitle)
                                .foregroundStyle(.black)
                            
                        }
                    }
                    NavigationLink(destination: BlackJack()) {
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 300, height: 100, alignment: .center)
                            Text("BlackJack")
                                .font(.largeTitle)
                                .foregroundStyle(.black)
                            
                        }
                    }
                    NavigationLink(destination: Poker()) {
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 300, height: 100, alignment: .center)
                            Text("Poker")
                                .font(.largeTitle)
                                .foregroundStyle(.black)
                            
                        }
                    }
                    NavigationLink(destination: Roulette()) {
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 300, height: 100, alignment: .center)
                            Text("Roulette")
                                .font(.largeTitle)
                                .foregroundStyle(.black)
                            
                        }
                    }
                }
            }
        }
    }
}
