
import SwiftUI
import CoreData

struct QRView: View {
    var qrCodeImage: UIImage?
    var text: String?
    var link: String?
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
                        .frame(height: 70)
                    HStack(spacing:30){
                        
                        Button{
                            saveQRCode()
                        }label: {
                            Image("save")
                                .resizable()
                                .frame(width: 142 , height: 41)
                        }
                        
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
                
                if let qrCodeImage = qrCodeImage {
                    Image(uiImage: qrCodeImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .cornerRadius(10)
                        .padding()
                }
            }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func downloadQRCode() {
        if let qrCodeImage = qrCodeImage {
            UIImageWriteToSavedPhotosAlbum(qrCodeImage, nil, nil, nil)
            showAlert = true
            alertMessage = "QR Code has been downloaded successfully"
        }
    }
    
    private func saveQRCode()  {
     
            let image = self.qrCodeImage
            guard let imageData = image?.jpegData(compressionQuality: 1.0) else {
                print("unable to conert image ")
                return
            }
            let context = PersistenceController.shared.container.viewContext
            let qr = Item(context: context)
        qr.txt = self.text
        qr.link = self.link
          
            qr.img = imageData
            qr.id = UUID()
            save(context: context)
       
        
    }
    func save(context: NSManagedObjectContext) {
        do{
            try context.save()
            print("Plan saved")
          
            showAlert = true
            alertMessage = "QR Code has been saved successfully"
        }catch{
            
            print(" Error Saving QR Code")
            
        }
    }

    
}

#Preview {
    QRView()
}
