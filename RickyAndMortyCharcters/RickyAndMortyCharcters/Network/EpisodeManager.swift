//
//  EpisodeManager.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 06/11/22.
//

import Foundation

class EpisodeManager {
    
    func getEpisode(url: String, completionHandler: @escaping (Episode?, RAMError?)->()) {
        
        let session = RAMSession()
        let url = URL(string: url)!
        
        func callAPI() {
            let task = session.ephemeralSession.dataTask(with: url) { data, response, error in
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
                    let parsedData = try decoder.decode(Episode.self, from: data)
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
