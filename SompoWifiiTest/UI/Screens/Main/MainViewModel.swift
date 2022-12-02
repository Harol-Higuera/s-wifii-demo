//
//  MainViewModel.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/02.
//

import SwiftUI

extension MainScreen {
    class ViewModel: ObservableObject {
        
        @Published var isConnectedToWifii: Bool?
        
        let container: DIContainer
        
        init(container: DIContainer) {
            self.container = container
            initializeState()
        }
        
        deinit {
            
        }
        
        func initializeState() {
            isConnectedToWifii = false
        }
    }
}
