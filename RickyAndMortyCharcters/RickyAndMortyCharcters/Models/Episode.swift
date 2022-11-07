//
//  Episode.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 06/11/22.
//

import Foundation

struct Episode: Decodable, Identifiable, Equatable {
    var id: Int
    var name: String
}
