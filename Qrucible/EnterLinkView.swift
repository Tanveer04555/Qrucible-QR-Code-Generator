


import SwiftUI

struct EnterLinkView: View {
    @State private var textInput: String = ""
    @State private var linkInput: String = ""
    @State private var qrCodeImage: UIImage? = nil
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isGenerating = false
    @State private var showQRView = false
    var body: some View {
            ZStack {
                Image("bg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    Image("t1")
                        .resizable()
                        .frame(width: 297, height: 24)
              
                    
                    ZStack {
                        Image("value")
                            .resizable()
                            .frame(height: 60)
                        
                        HStack {
                            Text("Enter Text:")
                                .foregroundColor(.white)
                            
                            TextField("", text: $textInput)
                                .accentColor(.white)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    }
                    
                    ZStack {
                        Image("value")
                            .resizable()
                            .frame(height: 60)
                        
                        HStack {
                            Text("Enter Link:")
                                .foregroundColor(.white)
                            
                            TextField("", text: $linkInput)
                                .autocapitalization(.none)
                                .accentColor(.white)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    }
                    
                    Button {
                        generateQRCode()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(height: 60)
                                .cornerRadius(8)
                                .foregroundColor(.bgc)
                            
                            if isGenerating {
                                HStack(spacing: 20) {
                                    Text("Generating QR Code")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                    
                                    if #available(iOS 15.0, *) {
                                        ProgressView()
                                            .controlSize(.regular)
                                            .tint(.white)
                                    } else {
                                      
                                    }
                                }
                            } else {
                                Text("Generate QR Code")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    NavigationLink(destination: QRView(qrCodeImage: qrCodeImage , text: textInput , link: linkInput), isActive: $showQRView) {
                        EmptyView()
                    }
                }
                .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        
    }
    
    func generateQRCode() {
        if textInput.isEmpty {
            showAlert = true
            alertMessage = "Please enter reference text"
        } else if linkInput.isEmpty {
            showAlert = true
            alertMessage = "Please enter link"
        } else {
            var input = textInput
            if !linkInput.isEmpty {
                input = linkInput
            }
            isGenerating = true
            
            DispatchQueue.global(qos: .background).async {
                let qrUrl = "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=\(input)"
                if let url = URL(string: qrUrl), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.qrCodeImage = uiImage
                        self.isGenerating = false
                        self.showQRView = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isGenerating = false
                        self.showAlert = true
                        self.alertMessage = "Failed to generate QR Code"
                    }
                }
            }
        }
    }
}

#Preview {
    EnterLinkView()
}
