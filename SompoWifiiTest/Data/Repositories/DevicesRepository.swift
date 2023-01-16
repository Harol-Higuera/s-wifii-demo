//
//  DevicesRepository.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2023/01/16.
//

import SwiftUI

fileprivate let keyDevicesOnMemory = "key_devices_on_memory"


protocol DevicesRepository {
    func addDeviceToMemory(_ device: DeviceModel, completion: @escaping  (_ error: String?) -> Void)
    func loadDevicesFromMemory() -> [DeviceModel]
    func deleteDeviceToMemory(_ device: DeviceModel, completion: @escaping  (_ error: String?) -> Void)
}

final class DevicesRepositoryImpl: DevicesRepository {
    
    let userDefaults: UserDefaults
    
    init(
        userDefaults: UserDefaults
    ) {
        self.userDefaults = userDefaults
    }
    
    func addDeviceToMemory(_ device: DeviceModel, completion: @escaping  (_ error: String?) -> Void) {
        var currentDevices = loadDevicesFromMemory()
        if (currentDevices.contains(where: { item in
            item.deviceSsid == device.deviceSsid
        })) {
            completion("エラー。SSIDが追加されています。")
            return
        }
        
        currentDevices.append(device)
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            // Encode DeviceModel
            let data = try encoder.encode(currentDevices)
            
            // Write/Set Data
            userDefaults.set(data, forKey: keyDevicesOnMemory)
            completion(nil)
            
        } catch (let error)  {
            completion("SSIDをメモリに追加することできませんでした！。\(error)")
        }
    }
    
    func loadDevicesFromMemory() -> [DeviceModel] {
        // Read/Get Data
        if let data = userDefaults.data(forKey: keyDevicesOnMemory) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Data
                let list = try decoder.decode([DeviceModel].self, from: data)
                
                return list
            } catch (let error) {
                print("Unable to loadDevicesFromMemory (\(error))")
                return []
            }
        }
        return []
    }
    
    func deleteDeviceToMemory(_ device: DeviceModel, completion: @escaping  (_ error: String?) -> Void) {
        var currentDevices = loadDevicesFromMemory()
        if (currentDevices.isEmpty) {
            completion("エラー。SSIDsが何もありませんでした。")
        }
        
        if (!currentDevices.contains(where: { item in
            item.deviceSsid == device.deviceSsid
        })) {
            completion("エラー。SSIDがありませんでした。")
            return
        }
        currentDevices.removeAll { item in
            item.deviceSsid == device.deviceSsid
        }
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            // Encode DeviceModel
            let data = try encoder.encode(currentDevices)
            
            // Write/Set Data
            userDefaults.set(data, forKey: keyDevicesOnMemory)
            completion(nil)
            
        } catch (let error)  {
            completion("SSIDをメモリに追加することできませんでした！。\(error)")
        }
    }
    
    deinit {
        
    }
}

struct StubDevicesRepository: DevicesRepository {

    func addDeviceToMemory(_ device: DeviceModel, completion: @escaping  (_ error: String?) -> Void) {
        
    }
    func loadDevicesFromMemory() -> [DeviceModel] {
        return []
    }
    func deleteDeviceToMemory(_ device: DeviceModel, completion: @escaping  (_ error: String?) -> Void) {
        
    }
}
