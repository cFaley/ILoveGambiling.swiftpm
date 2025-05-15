import SwiftUI

struct DoubleOrNothing: View {
    @AppStorage("cash") var cash: Int = 5000
    let heads = "Heads"
    let tails = "Tails"
    @State var current = "Heads"
    @State var spin = 0.0
    @State var flipping = false
    @State var showAlert = false
    @State var selection = "Heads"
    
    var body: some View {
        ZStack {
            Color(red: 107/255, green: 13/255, blue: 14/255)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Menu("Bet: \(selection)") {
                    Button(heads) { selection = heads }
                    Button(tails) { selection = tails }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                
                if flipping {
                    Image(heads)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .rotation3DEffect(.degrees(spin), axis: (x: 0, y: 1, z: 0))
                } else {
                    Image(current)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                
                Button("Flip") {
                    flip()
                }
                .disabled(flipping)
            }
            .padding()
        }
        .alert("Cannot Play", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Your cash must be positive to play")
        }
    }
    
    func flip() {
        guard cash > 0 else {
            showAlert = true
            return
        }
        let outcomeIsHeads = Bool.random()
        flipping = true
        spin = 0
        let spins = Int.random(in: 6...12)
        let totalDegrees = Double(spins * 360)
        let duration = Double(spins) * 0.1
        
        withAnimation(.linear(duration: duration)) {
            spin += totalDegrees
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            flipping = false
            current = outcomeIsHeads ? heads : tails
            if (outcomeIsHeads && selection == heads) ||
                (!outcomeIsHeads && selection == tails) {
                cash *= 2
            } else {
                cash = 0
            }
        }
    }
}
