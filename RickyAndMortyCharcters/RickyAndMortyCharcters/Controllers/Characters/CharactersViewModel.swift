//
//  CharactersViewModel.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 28/10/22.
//

import Foundation

class CharactersViewModel {
    
    var reloadTableView: (() -> ())?
    
    var id: Int = 1
    var charcterProfiles = [Profile]()
    
    func getCharacters() {
        
        APIEngine.shared.getCharcaters(page: id) { result, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            guard let result = result else {
                print("No data found")
                return
            }
            
            self.charcterProfiles.append(contentsOf: result.results)
            self.reloadTableView?()
            self.id += 1
            
        }
    }
    
//    func parseResult(data: Profile) {
//
//
//        guard let results = data["results"] as? [[String: Any]] else {
//            return
//        }
//
//        for result in results {
//            let name = result["name"] as? String
//            let status = result["status"] as? String
//            let species = result["species"] as? String
//            let imageUrl = result["image"] as? String
//            self.charcterProfiles.append(CharacterProfile(name: name ?? "", status: status ?? "", species: species ?? "", imageUrl: imageUrl ?? ""))
//        }
//
//        self.reloadTableView?()
//    }
}
