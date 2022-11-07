//
//  CharactersProfileViewModel.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 06/11/22.
//

import Foundation

class CharacterProfileViewModel {
    
    var updateEpisode: ((Episode)->())?
    
    
    
    func getEpisodeName(url: String) {
        
        APIEngine.shared.getEpisode(url: url) { episode, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            guard let episode = episode else {
                print("No data found")
                return
            }
            
            self.updateEpisode?(episode)
        }
        
    }
}
