//
//  Loader.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/07.
//

import SwiftUI

struct Loader: View {
    var body: some View {
        ZStack(alignment: .center) {
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color.white.opacity(0.0001))
        .onTapGesture {
            print("Tap tap")
        }
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Loader()
        }
    }
}
