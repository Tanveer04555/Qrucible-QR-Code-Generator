


import Foundation
import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    private init() {
        container = NSPersistentContainer(name: "Qrucible")
        container.loadPersistentStores {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error: \(error), \(error.userInfo)")
            }
        }
    }
}



