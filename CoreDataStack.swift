//
//  Basket.swift
//  CodeRedStore
//
//  Created by denisok on 15/03/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import CoreData

protocol CoreDataStackDelegate: class {
    func dataDidChanged()
}

class CoreDataStack {
    
    static let shared = CoreDataStack()
    private init() {}
    
    weak var delegate: CoreDataStackDelegate?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Basket")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        return container
    }()
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func createProduct(sizeItem: String, descriptionModel: DescriptionModel, imageStr: String) {
        
        if productInBasket(name: descriptionModel.name, size: sizeItem) {
            
            updateProductInBasket(for: descriptionModel.name, sizeItem: sizeItem, descriptionModel: descriptionModel)
            
            print("inceate count prouct +1")
            
        } else {
            
            createNewProduct(sizeItem: sizeItem, descriptionModel: descriptionModel, imageStr: imageStr)
            
            print("create data core dataa")
    
        }
        
    }
    
    func createNewProduct(sizeItem: String, descriptionModel: DescriptionModel, imageStr: String) {
        let managedContext = CoreDataStack.shared.getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Basket", in: managedContext) else { return }
        
        let basket = NSManagedObject(entity: entity, insertInto: managedContext)
        
        let fileManagerStore = FileManagerStore()
        
        fileManagerStore.saveImage(imageStr: imageStr, name: descriptionModel.name)
        
        basket.setValue(descriptionModel.name, forKey: "name")
        basket.setValue(descriptionModel.coast, forKey: "price")
        basket.setValue(sizeItem, forKey: "size")
        basket.setValue(1, forKey: "count")
        basket.setValue(fileManagerStore.createFileName(fileName: descriptionModel.name), forKey: "imageName")
        
        do {
            try managedContext.save()
            self.delegate?.dataDidChanged()
        } catch  {
            print(error.localizedDescription)
        }
        
    }
    
    func productInBasket(name: String, size: String) -> Bool {
        let managedContext = CoreDataStack.shared.getContext()
        
        do {
            let product = try managedContext.fetch(serachPorductInBasket(for: name, size: size))
            
            if !product.isEmpty {
                return true
            } else {
                return false
            }
            
        } catch  {
            print("Error")
            return false
        }
        
    }
    
    func serachPorductInBasket(for name: String, size: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Basket")
        fetchRequest.predicate = NSPredicate(format: "name == %@ AND #size == %@", argumentArray: [name, size])
        return fetchRequest
    }
    
    func updateProductInBasket(for name: String, sizeItem: String, descriptionModel: DescriptionModel) {
        
        let managedContext = CoreDataStack.shared.getContext()
        
        do {
            let result = try managedContext.fetch(serachPorductInBasket(for: name, size: sizeItem))
            
            let product = result.first as! NSManagedObject
            
            var countProduct = product.value(forKey: "count") as! Int
            countProduct += 1
            
            product.setValue(descriptionModel.name, forKey: "name")
            product.setValue(descriptionModel.coast, forKey: "price")
            product.setValue(sizeItem, forKey: "size")
            product.setValue(countProduct, forKey: "count")
            
            try managedContext.save()
            delegate?.dataDidChanged()
            
            
        } catch {
            print("error")
        }
        
    }
    
    func fetchData() -> [Basket] {
        let managedContext = CoreDataStack.shared.getContext()
        
        let fetchRequest = NSFetchRequest<Basket>(entityName: "Basket")
        var result: [Basket] = []
        
        do {
            result = try managedContext.fetch(fetchRequest)
            
        } catch  {
            print(error)
        }
        
        return result
    }
    
    func getCountProduct() -> String {
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Basket")
        return try! "\(managedContext.fetch(fetchRequest).count)"
    }
    
}
