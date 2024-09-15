

import SwiftUI

struct HistoryCell: View {
    var qr : Item
    var body: some View {
        ZStack{
            Image("rect")
                .resizable()
                .frame(height: 85)
            HStack(spacing:20){
                
                if let imageData = qr.img,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 65 , height: 65)
                        .foregroundColor(.white)
                        .padding(.leading)
                }
                
                
                VStack(alignment:.leading, spacing:10){
                    Text(qr.txt ?? "no txt saved")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Text(qr.link ?? "")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
                .padding(.trailing)
                
                
                Spacer()
                
            }
        }
    }
}
