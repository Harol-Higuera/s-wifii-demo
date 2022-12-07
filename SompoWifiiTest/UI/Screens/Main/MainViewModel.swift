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
        
        override init(container: DIContainer) {
            super.init(container: container)
            self.initializeState()
        }
        
        deinit {
            
        }
        
        func initializeState() {
            let deviceModel = container.repositories.deviceRepository.getDevice()
            isConnectedToWifii = deviceModel != nil
            guard let deviceModel = deviceModel else {
                return
            }
            deviceSSid = deviceModel.deviceSsid
        }
        
        
        
        func registerDevice (
            ssid: String,
            password: String,
            onError: @escaping (_ errorMessage: String) -> Void
        ) {
            if (ssid.isEmpty || password.isEmpty) {
                onError("SSIDとパスワードを入力してください！")
            }
        }
    }
}
