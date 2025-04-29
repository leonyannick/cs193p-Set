//
//  SetApp.swift
//  Set
//
//  Created by Leon Baumann on 07.04.25.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            ClassicSetGameView(classicSet: ClassicSetGame())
        }
    }
}
