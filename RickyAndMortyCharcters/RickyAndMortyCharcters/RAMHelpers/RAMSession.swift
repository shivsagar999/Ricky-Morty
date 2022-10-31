//
//  RAMSession.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 28/10/22.
//

import Foundation

class RAMSession: NSObject {
    
    lazy var ephemeralSession: URLSession = {
        return URLSession(configuration: URLSessionConfiguration.ephemeral,
                          delegate: nil,
                          delegateQueue: OperationQueue.main)
    }()
        
}
