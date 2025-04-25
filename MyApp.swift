import SwiftUI

@main
struct MyApp: App {
    
    class GameState: ObservableObject {
        @AppStorage("cash") var cash: Int = 5000
    }
    
    @StateObject var gameState = GameState()

      var body: some Scene {
          WindowGroup {
              ContentView()
                .environmentObject(gameState)
          }
      }
  }
