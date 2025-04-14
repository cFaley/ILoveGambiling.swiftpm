import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            Text("I Love Gambling❤️")
            
            Button {
                
            } label: {
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: 300, height: 100, alignment: .center)
                    Text("Slots")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                        
                }
            }
            
        }
    }
}
