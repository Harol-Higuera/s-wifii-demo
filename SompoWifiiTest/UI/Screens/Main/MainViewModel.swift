//
//  MainViewModel.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/02.
//

import SwiftUI

extension MainScreen {
    class ViewModel: BaseViewModel, ObservableObject {
        
        @Published var isLoading: Bool = false
        @Published var isConnectedToWifii: Bool?
        @Published var deviceSSid: String = ""
        @Published var devices: [DeviceModel] = []
        
        @Published var entrySsid: String = ""
        @Published var entryPassword: String = ""
        
        override init(container: DIContainer) {
            super.init(container: container)
            self.initializeState()
        }
        
        deinit {
            
        }
        
        func initializeState() {
            loadDevicesFromMemory()
            let deviceModel = container.repositories.connectionsRepository.getDevice()
            isConnectedToWifii = deviceModel != nil
            guard let deviceModel = deviceModel else {
                return
            }
            deviceSSid = deviceModel.deviceSsid
        }
        
        func loadDevicesFromMemory() {
            devices = container.repositories.devicesRepositoryRepository.loadDevicesFromMemory()
        }
        
        var count = 0;
        func registerDevice (
            ssid: String,
            password: String,
            onError: @escaping (_ errorMessage: String) -> Void
        ) {
            if (ssid.isEmpty || password.isEmpty) {
                onError("SSIDとパスワードを入力してください！")
                return
            }
            let deviceModel = DeviceModel(deviceSsid: ssid, devicePassword: password)
            isLoading = true
            container.repositories.wifiRepositoryRepository.connect(deviceModel: deviceModel) { [weak self] (error) in
                guard let weakSelf1 = self else {
                    return
                }
                
                Timer.scheduledTimer(withTimeInterval:  1.0, repeats: true) { timer in
                    
                    weakSelf1.container.repositories.wifiRepositoryRepository.containsIssd(deviceModel: deviceModel) { [weak self] isContained, error in
                        guard let weakSelf2 = self else {
                            return
                        }
                        
                        if let error = error {
                            timer.invalidate()
                            weakSelf2.count = 0
                            weakSelf2.isLoading = false
                            onError(error)
                            return
                        }
                        
                        if (isContained) {
                            timer.invalidate()
                            weakSelf2.count = 0
                            weakSelf2.isLoading = false
                            weakSelf2.container.repositories.devicesRepositoryRepository.addDeviceToMemory(deviceModel) { error in
                                if let error = error {
                                    print("Unable to addDeviceToMemory (\(error))")
                                }
                                weakSelf2.initializeState()
                            }
                            
                        }
                    }
                    
                    if (weakSelf1.count == 5) {
                        timer.invalidate()
                        weakSelf1.count = 0
                        weakSelf1.isLoading = false
                    }
                    
                    weakSelf1.count += 1
                    print("Timer count: \(weakSelf1.count)")
                }
                
            }
        }
        
        func disconnectDevice() {
            container.repositories.wifiRepositoryRepository.removeConfiguration { [weak self] success in
                guard let weakSelf1 = self else {
                    return
                }
                if (success) {
                    weakSelf1.initializeState()
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    weakSelf1.disconnectDevice()
                }
            }
        }
        
        func populateFields(model: DeviceModel) {
            entrySsid = model.deviceSsid
            entryPassword = model.devicePassword
        }
        
        func deleteDeviceModel(model: DeviceModel) {
            container.repositories.devicesRepositoryRepository.deleteDeviceToMemory(model) { [weak self]  error in
                guard let weakSelf1 = self else {
                    return
                }
                if let error = error {
                    print("Unable to deleteDeviceFromMemory (\(error))")
                    return
                }
                weakSelf1.loadDevicesFromMemory()
            }
        }
    }
}
