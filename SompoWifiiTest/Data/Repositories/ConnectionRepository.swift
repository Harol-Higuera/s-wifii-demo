//
//  ConnectionRepository.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/02.
//

import SwiftUI
import SystemConfiguration.CaptiveNetwork
import NetworkExtension

protocol ConnectionRepository {
    func removeConfiguration()
    func connect(deviceModel: DeviceModel, completion: @escaping  (_ error: String?) -> Void)
}

final class ConnectionRepositoryImpl: ConnectionRepository {
    

    let deviceRepository: DeviceRepository

    init(
        deviceRepository: DeviceRepository
    ) {
        self.deviceRepository = deviceRepository
    }
    
    deinit {
       
    }
    
    /// @function removeConfiguration
    /// @discussion Remove the hotspot configuration.
    ///
    func removeConfiguration() {
        guard let device = deviceRepository.getDevice() else {
            return
        }
        NEHotspotConfigurationManager.shared.removeConfiguration(forSSID: device.deviceSsid)
    }
    
    /// WEP (Wired Equivalent Privacy) is the oldest and most common Wi-Fi security protocol.
    /// WPA (Wi-Fi Protected Access) is a wireless security protocol released in 2003 to address the growing vulnerabilities of its predecessor, WEP.
    ///
    /// When joinOnce is set to true, the hotspot remains configured and connected only as long as the app that configured it is running in the foreground. The hotspot is disconnected and its configuration is removed when any of the following events occurs:
    /// - The app stays in the background for more than 15 seconds.
    /// - The device sleeps.
    /// - The app crashes, quits, or is uninstalled.
    /// - The app connects the device to a different Wi-Fi network.
    /// - The user connects the device to a different Wi-Fi network.
    ///
    func connect(deviceModel: DeviceModel, completion: @escaping  (_ error: String?) -> Void) {
    
          if #available(iOS 11.0, *) {
              
              let config = NEHotspotConfiguration(ssid: deviceModel.deviceSsid,
                                                  passphrase: deviceModel.devicePassword,
                                                  isWEP: false)
              config.joinOnce = true

              NEHotspotConfigurationManager.shared.apply(config) { [weak self] (error) in
                  guard let weakSelf = self else {
                      completion("WiFi network not found")
                      return
                  }
                  
                  // This error represents NEHotspotConfigurationError.
                  if let configError = error {
                      completion(configError.localizedDescription)
                      return
                  }
                  
                  weakSelf.associatedSSIDs { associatedSSIDs in
                      if (associatedSSIDs.contains(deviceModel.deviceSsid)) {
                          weakSelf.deviceRepository.setDevice(deviceModel: deviceModel) { success in
                              if success {
                                  completion(nil)
                                  return
                              }
                          }
                      }
                      completion("Connection failed!")
                  }
              }
          } else {
              completion("Not Connected")
              return
          }
      }
    
    
    /// @function associatedSSIDs
    /// @discussion Get the supported interfaces at the time of the call and map an SSID with the current network information.
    /// @return An array of associated SSIDs for the device.
    /// @NOTE: CNCopyCurrentNetworkInfo is deprecated in iOS 13, so use NEHotspotNetwork.fetchCurrent in iOS 14.
    func associatedSSIDs(completion: @escaping ((_ result: [String]) -> Void)) {
        if #available(iOS 14, *) {
            NEHotspotNetwork.fetchCurrent() { (network) in
                let networkSSID = network.flatMap { [$0.ssid] } ?? []
                completion(networkSSID)
            }
        } else {
            // For iOS 13 and earlier.
            guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else {
                completion([])
                return
            }
            
            completion(interfaceNames.compactMap { name in
                guard let info = CNCopyCurrentNetworkInfo(name as CFString) as? [String: AnyObject] else {
                    return nil
                }
                
                guard let ssid = info[kCNNetworkInfoKeySSID as String] as? String else {
                    return nil
                }
                return ssid
            })
        }
    }
}

struct StubConnectionRepository: ConnectionRepository {
    func removeConfiguration() {
    }
    
    func connect(deviceModel: DeviceModel, completion: @escaping  (_ error: String?) -> Void) {
    }
}
