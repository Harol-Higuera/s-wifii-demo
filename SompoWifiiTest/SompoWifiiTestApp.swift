//
//  SompoWifiiTestApp.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/02.
//

import SwiftUI

@main
struct SompoWifiiTestApp: App {
    
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let environment = appDelegate.enviroment
            MainScreen(viewModel: MainScreen.ViewModel(container: environment.container))
                .environment(\.colorScheme, .light)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    lazy var enviroment: AppEnvironment = {
        AppEnvironment.bootstrap()
    }()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        return true
    }
}
