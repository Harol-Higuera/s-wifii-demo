//
//  DependencyInjector.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/02.
//

import SwiftUI

struct DIContainer {
    
    let repositories: Repositories
        
    init(repositories: DIContainer.Repositories) {
        self.repositories = repositories
    }

}

extension DIContainer {
    static var preview: Self {
        .init(repositories: .stub)
    }
}
