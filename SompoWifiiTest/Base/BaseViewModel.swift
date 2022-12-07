//
//  BaseViewModel.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/07.
//

import SwiftUI

class BaseViewModel {
    
    let container: DIContainer
    
    @Published var appAlertModel: AppAlertModel?
    @Published var snackBarMessage: String?
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func updateSnackBarMessage(message: String) {
        self.snackBarMessage = message
    }
    
    func updateAlertModel(appAlertModel: AppAlertModel) {
        self.appAlertModel = appAlertModel
    }
    
    func resetAlertModel() {
        self.appAlertModel = nil
    }
}
