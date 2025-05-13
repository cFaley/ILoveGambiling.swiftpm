import SwiftUI

struct ContentView: View {
    
    let myColor = Color(red: 107/255, green: 13/255, blue: 14/255)
    
    var body: some View {
        ZStack{
            myColor.ignoresSafeArea()
         
            ZStack{
                
                VStack {
                    Text("I Love Gambling❤️")
                        .foregroundStyle(.white)
                        .padding()
                    Text("Welcom to the CCC!!!")
                        .foregroundStyle(.white)
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
                                    
                                    NavigationLink(destination: Slots()) {
                                        ZStack{
                                            Rectangle()
                                                .fill()
                                                .foregroundStyle(myColor)
                                            RoundedRectangle(cornerRadius: 100)
                                                .frame(width: 300, height: 75, alignment: .center)
                                            Text("Slots")
                                                .font(.largeTitle)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                    
                                    NavigationLink(destination: BlackJack()) {
                                        ZStack{
                                            Rectangle()
                                                .fill()
                                                .foregroundStyle(myColor)
                                            RoundedRectangle(cornerRadius: 100)
                                                .frame(width: 300, height: 75, alignment: .center)
                                            Text("BlackJack")
                                                .font(.largeTitle)
                                                .foregroundStyle(.white)
                                            
                                        }
                                    }
                                    NavigationLink(destination: Poker()) {
                                        ZStack{
                                            Rectangle()
                                                .fill()
                                                .foregroundStyle(myColor)
                                            RoundedRectangle(cornerRadius: 100)
                                                .frame(width: 300, height: 75, alignment: .center)
                                            Text("Poker")
                                                .font(.largeTitle)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                    NavigationLink(destination: Roulette()) {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 100)
                                                .frame(width: 300, height: 75, alignment: .center)
                                            Text("Roulette")
                                                .font(.largeTitle)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                    NavigationLink(destination: DoubleOrNothing()) {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 100)
                                                .frame(width: 300, height: 75, alignment: .center)
                                            Text("Double or Nothing")
                                                .font(.largeTitle)
                                                .foregroundStyle(.white)
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
