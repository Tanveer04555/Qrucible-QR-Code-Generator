

import SwiftUI

struct QRCodeDetailView: View {
    var qr : Item
    @State private var showAlert = false
    @State private var alertMessage = ""
    var body: some View {
        ZStack{
            Image("bg")
                .resizable()
            VStack{
                ZStack {
                    Image("value")
                        .resizable()
                        .frame(width: 180 , height: 70)
                    HStack{
                
                        Button{
                            downloadQRCode()
                        }label: {
                            Image("download")
                                .resizable()
                                .frame(width: 142 , height: 41)
                        }
                    }
                    
                  
                }
                .padding()
                
                if let imageData = qr.img,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 250 , height: 250)
                        .foregroundColor(.white)
                        .padding(.leading)
                }
            }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func downloadQRCode() {
           if let imageData = qr.img, let qrCodeImage = UIImage(data: imageData) {
               UIImageWriteToSavedPhotosAlbum(qrCodeImage, nil, nil, nil)
               showAlert = true
               alertMessage = "QR Code has been downloaded successfully"
           } else {
               showAlert = true
               alertMessage = "Failed to download QR Code"
           }
       }


    
}


