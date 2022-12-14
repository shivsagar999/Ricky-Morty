//
//  CharacterProfile.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 30/10/22.
//

import Foundation


struct Character: Decodable {
    var results: [Profile]
}

struct Profile: Decodable, Identifiable, Equatable {
    
    var id: Int
    var name: String
    var status: String
    var species: String
    var image: String
    var location: Location
    var episode: [String]

    var statusAndSpecies: String {
        return "\(status) - \(species)"
    }
}

struct Location: Decodable, Equatable {
    var name: String
    var url: String
}


