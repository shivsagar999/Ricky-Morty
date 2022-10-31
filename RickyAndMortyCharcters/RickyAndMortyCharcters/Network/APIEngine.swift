//
//  APIEngine.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 28/10/22.
//

import Foundation



protocol APIEngineProtocol {
    
    func getCharcaters(page: Int,
                       completionHandler: @escaping (Character?, RAMError?) -> ())
    
}

class APIEngine: APIEngineProtocol {
    
    static let shared = APIEngine()
    
    private init() {}
    
    func getCharcaters(page: Int, completionHandler: @escaping (Character?, RAMError?) -> ()) {
        
        var result: Character?
        var error: RAMError?
        DispatchQueue.global().async {
            let charctersManager = CharactersManager()
            charctersManager.getCharacters(page: page) { res, err in
                result = res
                error = err
                completionHandler(result, error)
            }
        }
    }
    
    
    
    
}
