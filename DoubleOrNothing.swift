import SwiftUI

struct DoubleOrNothing: View {
    let myColor = Color(red: 107/255, green: 13/255, blue: 14/255)
    
        let coinImages = ["Heads", "Tails"]
        @State var currentIndex = 0
        @State var rotationY = 0.0

        var body: some View {
            VStack(spacing: 30) {
                Image(coinImages[currentIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .rotation3DEffect(Angle(degrees: rotationY), axis: (x: 0, y: 1, z: 0))
                    .onTapGesture { flipCoin() }

                Button("Flip Coin") {
                    flipCoin()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }

        func flipCoin() {
            let nextIndex = Int.random(in: 0...1)
            withAnimation(.easeIn(duration: 0.6)) {
                rotationY += 180
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                currentIndex = nextIndex
                rotationY.formTruncatingRemainder(dividingBy: 360)
            }
        }
    }
