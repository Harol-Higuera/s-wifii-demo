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
        let sessionRepository: SessionRepository
        let connectionRepository: ConnectionRepository
        
        init(
            sessionRepository: SessionRepository,
            connectionRepository: ConnectionRepository
        ) {
            self.sessionRepository = sessionRepository
            self.connectionRepository = connectionRepository
        }
        
        static var stub: Self {
            .init(
                sessionRepository: StubSessionRepository(),
                connectionRepository: StubConnectionRepository()
            )
        }
    }
}
