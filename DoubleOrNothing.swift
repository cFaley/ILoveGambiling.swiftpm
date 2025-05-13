import SwiftUI

struct DoubleOrNothing: View {
    let myColor = Color(red: 107/255, green: 13/255, blue: 14/255)
var body: some View {
    ZStack{
        myColor.ignoresSafeArea()
        VStack{
            Text("Double or Nothing!")
        }
    }
       
    }
}
