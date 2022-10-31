//
//  CharactersManager.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 28/10/22.
//

import Foundation

class CharactersManager {
    
    let session = RAMSession()
    
    func getCharacters(page: Int, completionHandler: @escaping (Character?, RAMError?) -> ()) {
        
        let page = URLQueryItem(name: "page", value: "\(page)")
        let queryItems = [page]
        
        var urlComps = URLComponents(string: NetworkConstants.getCharactersBaseURL)!
        urlComps.queryItems = queryItems
        
        let url = urlComps.url!
        
        var urlRequest = URLRequest(url: url)
        
        let headers = [NetworkConstants.kContentType : NetworkConstants.kApplicationJSON]
        urlRequest.allHTTPHeaderFields = headers
        
        func callAPI() {
            
            let task = session.ephemeralSession.dataTask(with: urlRequest) { data, response, error in
                
                if let error = error {
                    completionHandler(nil, RAMError.invalidResponse(statusCode: 404))
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    completionHandler(nil, RAMError.invalidResponse(statusCode: response.statusCode))
                }
                
                guard let data = data else {
                    completionHandler(nil, RAMError.noDataReceived)
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let parsedData = try decoder.decode(Character.self, from: data)
                    completionHandler(parsedData, nil)
                    return
                } catch {
                    completionHandler(nil, RAMError.serializationFailed)
                }
                
            }
            task.resume()
        }
        callAPI()
    }
}
