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
        
        // MARK: DeviceRepositoryの初期化
        let deviceRepository = DeviceRepositoryImpl(userDefaults: UserDefaults.standard)

        // MARK: ConnectionRepositoryの初期化
        let connectionRepository = ConnectionRepositoryImpl()
        
        return .init(
            deviceRepository: deviceRepository,
            connectionRepository: connectionRepository
        )
    }
}
