//
//  ReachabilityManager.swift
//  Application Registration
//
//  Created by Hiem Seyha on 7/11/17.
//  Copyright © 2017 seyha. All rights reserved.
//

import Foundation
import RxSwift
import ReachabilitySwift


class ReachabilityManager: NSObject {
    
    static let shared = ReachabilityManager()
    
    var isNetworkAvailable: Bool {
        return reachabilityStatus != .notReachable
    }
   
   var isConnected = PublishSubject<Bool>()
    
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    
     let reachability = Reachability()!
    
   @objc func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability
        
        // Check existing object
        
        switch reachability.currentReachabilityStatus {
            
        case .reachableViaWiFi:
            reachabilityStatus = .reachableViaWiFi
            isConnected.onNext(isNetworkAvailable)
            debugPrint("============ reachableViaWiFi ", isNetworkAvailable)
            
        case .reachableViaWWAN:
            reachabilityStatus = .reachableViaWWAN
            isConnected.onNext(isNetworkAvailable)
            debugPrint("============ reachableViaWWAN ", isNetworkAvailable)
        case .notReachable:
            reachabilityStatus = .notReachable
            isConnected.onNext(isNetworkAvailable)
             debugPrint("============ notReachable ", isNetworkAvailable)
         
        }
    }
    
    // Start Monitoring wifi
    func startMonitoring() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification, object: reachability)
    
        do {
            
            try reachability.startNotifier()
            
        } catch {
            
            debugPrint("Could not start reachability notifier")
        }
    }
   
    // Stop Monitoring wifi
    func stopMonitoring() {
        
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
       
    }

}
