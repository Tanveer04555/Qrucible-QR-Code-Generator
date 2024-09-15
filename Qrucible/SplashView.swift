


import SwiftUI

struct SplashView: View {
    var body: some View {
      
        ZStack{
            Image("bg")
                .resizable()
            
            Image("logo")
                .resizable()
                .frame(width: 161 , height: 221)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SplashView()
}
