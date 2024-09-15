
import SwiftUI
import CoreData

struct HistoryView: View {
    @State var qrs = [Item]()
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
            
            VStack {
                Text("Saved QR Codes")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
           
                if  qrs.isEmpty{
                    EmptyStatesView()
                }
                else{
                    if #available(iOS 16.0, *) {
                        List{
                            ForEach(qrs){ qr in
                                NavigationLink(destination: QRCodeDetailView(qr: qr))
                                {
                                    HistoryCell(qr: qr)
                                    
                                }
                            }
                            
                            .onDelete { indexSet in
                                deleteBill(at: indexSet, context: PersistenceController.shared.container.viewContext)
                            }
                            .listRowBackground(Color.clear)
                        }
                        .scrollContentBackground(.hidden)
                       
                        .listStyle(.plain)
                    } else {
                        List{
                            ForEach(qrs){ qr in
                                NavigationLink(destination: QRCodeDetailView(qr: qr))
                                {
                                    HistoryCell(qr: qr)
                                    
                                }
                            }
                            
                            .onDelete { indexSet in
                                deleteBill(at: indexSet, context: PersistenceController.shared.container.viewContext)
                            }
                            .listRowBackground(Color.clear)
                        }
                       
                        .listStyle(.plain)
                        
                    }
                }
                
            }
            .padding(. vertical , 30)
            .padding(.bottom , 60)
            .onAppear {
                Task {
                    do {
                        await getData()
                    }
                }
            }
        .padding()
        }
        .edgesIgnoringSafeArea(.all)
        
        
    }
    func getData() async {
        do {
            let context = PersistenceController.shared.container.viewContext
            let request = NSFetchRequest<Item>(entityName: "Item")
            self.qrs = try  context.fetch(request)
        } catch {
            print("Error fetching plans: \(error)")
        }
    }
    
    private func deleteBill(at offsets: IndexSet, context: NSManagedObjectContext) {
        for index in offsets {
            let qr = qrs[index]
            context.delete(qr)
        }
        Task {
            do {
                try  context.save()
                await getData()
            } catch {
                print("Error\(error)")
            }
        }
    }
}


struct EmptyStatesView: View {
    var body: some View {
            VStack(alignment:.center){
                Text("No saved  \n QR Codes found.")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .foregroundColor(Color.white)
                
                Text("Try to save QR Codes to see here")
                    .fontWeight(.bold)
                    .padding(.top , 40)
                    .foregroundColor(.white)
            }
            .padding()
            Spacer()
      
        
    }
}


#Preview {
    HistoryView()
}
