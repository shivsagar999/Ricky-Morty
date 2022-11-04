//
//  RAMNetworkHandler.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 03/11/22.
//

import Foundation

class RAMNetworkHandler {
    
    let networkStatus = RAMNetworkStatus.shared
    
    var networkStatusChanged: ((Bool) -> ())?
    
    
    func initiateNetworkStatusCheck(completionHandler: @escaping ((Bool) -> ())) {
        networkStatus.startMonitoring()
        networkStatus.netStatusChangehandler = { isConnected in
            self.networkStatusChanged?(isConnected)
        }
        completionHandler(networkStatus.isConnected)
    }
    
}
