//
//  RepositoryConteiner.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/02.
//

import Foundation

import Foundation

extension DIContainer {
    struct Repositories {
        let deviceRepository: ConnectionsRepository
        let connectionRepository: WifiRepository
        
        init(
            deviceRepository: ConnectionsRepository,
            connectionRepository: WifiRepository
        ) {
            self.deviceRepository = deviceRepository
            self.connectionRepository = connectionRepository
        }
        
        static var stub: Self {
            .init(
                deviceRepository: StubConnectionsRepository(),
                connectionRepository: StubWifiRepository()
            )
        }
    }
}
