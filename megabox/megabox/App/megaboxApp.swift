//
//  megaboxApp.swift
//  megabox
//
//  Created by 황민지 on 9/18/25.
//

import SwiftUI

@main
struct megaboxApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
