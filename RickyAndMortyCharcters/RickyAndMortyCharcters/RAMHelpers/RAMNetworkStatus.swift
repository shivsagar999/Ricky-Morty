//
//  RAMNetworkUtils.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 02/11/22.
//

import Foundation
import Network

class RAMNetworkStatus {
    
    static let shared = RAMNetworkStatus()
    
    var monitor: NWPathMonitor?
    
    var netStatusChangehandler: ((_ isConnected: Bool) -> ())?
    var isMontoring: Bool = false
    private init() { }
    
    
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    
    // MARK: - Method Implementation
    func startMonitoring() {
        guard !isMontoring else {
            return
        }
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Network Status")
        monitor?.pathUpdateHandler = { path in
            self.netStatusChangehandler?(path.status == .satisfied)
        }
        monitor?.start(queue: queue)
        isMontoring = true
    }
    
    func stopMonitoring() {
        guard isMontoring, let monitor = monitor else {
            return
        }
        monitor.cancel()
        self.monitor = nil
        isMontoring = false
        
    }
}
