//
//  DeviceRepository.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/02.
//

import SwiftUI

fileprivate let keyDeviceModel = "key_device_model"


protocol DeviceRepository {
    func getDevice() -> DeviceModel?
    
    func setDevice(
        ssid:  String,
        password: String,
        completion: @escaping (Bool) -> Void
    )
}

final class DeviceRepositoryImpl: DeviceRepository {
    
    let userDefaults: UserDefaults
    
    init(
        userDefaults: UserDefaults
    ) {
        self.userDefaults = userDefaults
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
    
    func setDevice(ssid: String, password: String, completion: @escaping (Bool) -> Void) {
        let model = DeviceModel(deviceSsid: ssid, devicePassword: password)
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            // Encode Note
            let data = try encoder.encode(model)
            
            // Write/Set Data
            userDefaults.set(data, forKey: keyDeviceModel)
            completion(true)
            
        } catch {
            print("Unable to Encode Note (\(error))")
            completion(false)
        }
    }
    
    deinit {
        
    }
    
    
}

struct StubDeviceRepository: DeviceRepository {
    func setDevice(ssid: String, password: String, completion: @escaping (Bool) -> Void) {
    }
    
    func getDevice() -> DeviceModel? {
        return nil
    }
    
}
