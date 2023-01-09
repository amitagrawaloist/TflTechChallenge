//
//  NetworkMonitor.swift
//  TfLTechTestApplication
//
//  Created by Amit Agrawal on 06/01/2023.
//

import Foundation
import Network

class NetworkMonitor {
    // MARK: Properties
    static let shared = NetworkMonitor()
    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular = true
    let queueTestLabel = "NetworkMonitor"
    
    // MARK: Methods
    /**
    This function checks if internet connection is available.
     Use status property to check the updated value.
     */
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
            
            if path.status == .satisfied {
                // post connected notification
            } else {
                // post disconnected notification
            }
        }
        
        let queue = DispatchQueue(label: queueTestLabel)
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
