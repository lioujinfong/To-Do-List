//
//  NewWork.swift
//  To-Do-List
//
//  Created by Mac2_iparknow on 2023/5/25.
//

import Foundation
import Network
import SwiftUI

class NetworkManager: ObservableObject {
    @ObservedObject var viewModel = ViewModel()
    @Published var isConnected = true
    
    private var monitor: NWPathMonitor?
    private var queue = DispatchQueue(label: "NetworkMonitor")
    
    init() {
        // 初始化 `NetworkManager` 之後開始監測
        DispatchQueue.main.async {
            self.startMonitoring()
        }
    }
    
    func startMonitoring() {
        monitor = NWPathMonitor()
        
        monitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                print(self?.isConnected)
                
            }
        }
        
        monitor?.start(queue: queue)
    }
    
}

