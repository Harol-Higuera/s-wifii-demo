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
        let connectionsRepository: ConnectionsRepository
        let wifiRepositoryRepository: WifiRepository
        
        init(
            connectionsRepository: ConnectionsRepository,
            wifiRepositoryRepository: WifiRepository
        ) {
            self.connectionsRepository = connectionsRepository
            self.wifiRepositoryRepository = wifiRepositoryRepository
        }
        
        static var stub: Self {
            .init(
                connectionsRepository: StubConnectionsRepository(),
                wifiRepositoryRepository: StubWifiRepository()
            )
        }
    }
}
