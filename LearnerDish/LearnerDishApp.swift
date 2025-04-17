//
//  LearnerDishApp.swift
//  LearnerDish
//
//  Created by 이시은 on 4/15/25.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
struct LearnerDishApp: App {
    @StateObject var user = UserModel()

    init() {
            FirebaseApp.configure()
            //FirebaseConfiguration.shared.setLoggerLevel(.debug)
        }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
        }
    }
}
