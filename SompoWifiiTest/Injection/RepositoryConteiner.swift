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
        let devicesRepositoryRepository: DevicesRepository
        
        init(
            connectionsRepository: ConnectionsRepository,
            devicesRepositoryRepository: DevicesRepository,
            wifiRepositoryRepository: WifiRepository
        ) {
            self.connectionsRepository = connectionsRepository
            self.devicesRepositoryRepository = devicesRepositoryRepository
            self.wifiRepositoryRepository = wifiRepositoryRepository
        }
        
        static var stub: Self {
            .init(
                connectionsRepository: StubConnectionsRepository(),
                devicesRepositoryRepository: StubDevicesRepository(),
                wifiRepositoryRepository: StubWifiRepository()
            )
        }
    }
}
