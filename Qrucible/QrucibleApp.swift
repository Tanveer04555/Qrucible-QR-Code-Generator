
import SwiftUI

@main
struct QrucibleApp: App {
    @State var isShowingSplash = true
    var body: some Scene {
        WindowGroup {
            if isShowingSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                isShowingSplash = false
                            }
                        }
                    }
            } else {
                NavigationView{
                    ContentView()
                }
            }
        }
    }
}
