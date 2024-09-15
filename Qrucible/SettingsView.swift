
import SwiftUI

struct SettingsView: View {
    var body: some View {
        
        ZStack{
            Image("bg")
                .resizable()
            VStack{
                
                Image("t3")
                    .resizable()
                    .frame(width: 124 , height: 22)
                    .padding()
                NavigationLink{
                   AboutView()
                }label: {
                    Image("about")
                        .resizable()
                        .frame(width: 190 , height: 50)
                }
                .frame(maxWidth: .infinity , alignment: .leading)
                .padding()
                
                Button{
                    openPrivacyPolicy()
                }label: {
                    Image("pp")
                        .resizable()
                        .frame(width: 190 , height: 50)
                }
                .padding()
                .frame(maxWidth: .infinity , alignment: .leading)
                
                
                Image("logo")
                    .resizable()
                    .frame(width: 161 , height: 221)
                    .padding(.top , 80)
                
                Spacer()
                
            }
            .padding(.top , 70)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func openPrivacyPolicy() {
            if let url = URL(string: "https://doc-hosting.flycricket.io/qrucible-privacy-policy/48617748-de81-4ff9-97a6-24ae7acbca32/privacy") {
                UIApplication.shared.open(url)
            }
        }
}

#Preview {
    SettingsView()
}
