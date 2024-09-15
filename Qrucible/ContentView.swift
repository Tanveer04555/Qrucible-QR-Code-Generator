
import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection:$selectedTab) {
            
            HistoryView()
                .tabItem {
                    Image(selectedTab == 0  ? "0.fill" : "0")
                    
                }
                .onAppear{
                    selectedTab = 0
                }
                .tag(0)
            EnterLinkView()
                .tabItem {
                    Image(selectedTab == 1  ? "1.fill" : "1")
                }
                .onAppear{
                    selectedTab = 1
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Image(selectedTab == 2  ? "2.fill" : "2")
                }
                .onAppear{
                    selectedTab = 2
                }
                .tag(2)
            
        }
        
        .onAppear {
            let tabBarAppearance = UITabBar.appearance()
            tabBarAppearance.backgroundImage = UIImage()
            tabBarAppearance.shadowImage = UIImage()
            tabBarAppearance.backgroundColor = .clear
        }
        
    }
}

#Preview {
    ContentView()
}
