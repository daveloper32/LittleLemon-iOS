//
//  HomeViewModel.swift
//  LittleLemon
//
//  Created by David Esteban Hernández Garzón on 19/04/23.
//

import Foundation
import CoreData

class HomeViewModel {
    func getMenuData(context: NSManagedObjectContext) async {
        let urlServer: URL = URL(string: NetworkUtils().API_URL)!
        //let request = URLRequest(url: urlServer)
        let task = URLSession
            .shared
            .dataTask(with: urlServer) { data, response, error in
                if let data = data,
                   let response = String(data: data, encoding: .utf8) {
                    let responseAsData = response.data(using: .utf8)
                    if let responseAsData = responseAsData {
                        let responseDataMapped = try? JSONDecoder().decode(MenuList.self, from: responseAsData)
                        if let responseDataMapped = responseDataMapped {
                            print(responseDataMapped)
                            responseDataMapped.menu.forEach { menuItem in
                                if (!self.someMenuItemIsAlreadyRegisteredOnLocal(menuItem: menuItem, context)) {
                                    let newDish: Dish = Dish(context: context)
                                    newDish.id = Int16(menuItem.id)
                                    newDish.title = menuItem.title
                                    newDish.dishDescription = menuItem.description
                                    newDish.image = menuItem.image
                                    newDish.price = menuItem.price
                                    newDish.category = menuItem.category
                                }
                            }
                            try? context.save()
                        }
                    }
                }
                let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()

                do {
                    // Obtenemos los objetos de la entidad Dish
                    let dishes = try context.fetch(fetchRequest)

                    // Iteramos sobre los resultados e imprimimos el nombre de cada objeto
                    for dish in dishes {
                        print(dish.title)
                    }
                } catch {
                    print("Error al obtener los objetos: \(error)")
                }
            }
        task.resume()
    }
    
    private func someMenuItemIsAlreadyRegisteredOnLocal(
        menuItem: MenuItem,
        _ context: NSManagedObjectContext
    ) -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        fetchRequest.predicate = NSPredicate(
            format: "title == %@",
            menuItem.title
        )
        fetchRequest.fetchLimit = 1
        do {
            let results = try context.fetch(fetchRequest)
            print("on menuItem name \(menuItem.title) there are \(results.count) on local DB")
            return results.count > 0
        } catch {
            return false
        }
    }
    
    func deleteAllObjects(_ context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Error deleting all objects for entity Dish: \(error.localizedDescription)")
        }
    }
}
