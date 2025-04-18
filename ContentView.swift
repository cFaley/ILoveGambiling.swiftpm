import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            Text("I Love Gambling❤️")
            NavigationStack{
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
                
            }
        }
    }
}
