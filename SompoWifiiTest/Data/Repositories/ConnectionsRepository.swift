//
//  ConnectionsRepository.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/02.
//

import SwiftUI

fileprivate let keyDeviceModel = "key_device_model"


protocol ConnectionsRepository {
    func getDevice() -> DeviceModel?
    func removeDevice()
    func setDevice(deviceModel: DeviceModel, completion: @escaping (Bool) -> Void)
}

final class ConnectionsRepositoryImpl: ConnectionsRepository {
    
    let userDefaults: UserDefaults
    
    init(
        userDefaults: UserDefaults
    ) {
        self.userDefaults = userDefaults
    }
    
    func removeDevice() {
        userDefaults.removeObject(forKey: keyDeviceModel)
    }
    
    func getDevice() -> DeviceModel? {
        // Read/Get Data
        if let data = userDefaults.data(forKey: keyDeviceModel) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let model = try decoder.decode(DeviceModel.self, from: data)
                
                return model
            } catch {
                print("Unable to Decode Note (\(error))")
                return nil
            }
        }
        return nil
    }
    
    func setDevice(deviceModel: DeviceModel, completion: @escaping (Bool) -> Void) {
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            // Encode DeviceModel
            let data = try encoder.encode(deviceModel)
            
            // Write/Set Data
            userDefaults.set(data, forKey: keyDeviceModel)
            completion(true)
            
        } catch {
            print("Unable to Encode DeviceModel (\(error))")
            completion(false)
        }
    }
    
    deinit {
        
    }
}

struct StubConnectionsRepository: ConnectionsRepository {
    func setDevice(deviceModel: DeviceModel, completion: @escaping (Bool) -> Void) {
    }
    func getDevice() -> DeviceModel? {
        return nil
    }
    func removeDevice() {
        
    }
}
