//
//  AppEnvironment.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/02.
//

import Foundation

struct AppEnvironment {
    let container: DIContainer
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let repositories = configuredRepositories()
        let diContainer = DIContainer(repositories: repositories)
        return AppEnvironment(container: diContainer)
    }
    
    private static func configuredRepositories() -> DIContainer.Repositories {
        
        // MARK: ConnectionsRepositoryの初期化
        let connectionsRepository = ConnectionsRepositoryImpl(userDefaults: UserDefaults.standard)
        
        // MARK: ConnectionsRepositoryの初期化
        let devicesRepository = DevicesRepositoryImpl(userDefaults: UserDefaults.standard)

        // MARK: WifiRepositoryの初期化
        let wifiRepositoryRepository = WifiRepositoryImpl(connectionsRepository: connectionsRepository)
        
        return .init(
            connectionsRepository: connectionsRepository,
            devicesRepositoryRepository: devicesRepository,
            wifiRepositoryRepository: wifiRepositoryRepository
        )
    }
}
