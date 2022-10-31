//
//  NetworkConstants.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 28/10/22.
//

import Foundation

class NetworkConstants {

    
    //Headers
    static let kContentType = "Content-Type"
    static let kAccept = "Accept"
    static let kFormEncoded = "application/x-www-form-urlencoded"
    static let kApplicationJSON = "application/json"
    
    
    //Base url
    static private let charactersBaseURL = "https://rickandmortyapi.com/api/character"
    
}

extension NetworkConstants {
    
    static var getCharactersBaseURL: String {
        return charactersBaseURL
    }
}
