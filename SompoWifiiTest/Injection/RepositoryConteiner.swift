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
        let deviceRepository: DeviceRepository
        let connectionRepository: ConnectionRepository
        
        init(
            deviceRepository: DeviceRepository,
            connectionRepository: ConnectionRepository
        ) {
            self.deviceRepository = deviceRepository
            self.connectionRepository = connectionRepository
        }
        
        static var stub: Self {
            .init(
                deviceRepository: StubDeviceRepository(),
                connectionRepository: StubConnectionRepository()
            )
        }
    }
}
