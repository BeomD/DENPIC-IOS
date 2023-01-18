//
//  TESTApp.swift
//  TEST
//
//  Created by BJ Man on 2022/12/18.
//

import SwiftUI
import Firebase
import AVFoundation

@main
struct TESTApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
        var body: some Scene {
            let cameraViewModel = CameraViewModel()
            let webViewModel = WebViewModel()
            let appViewModel = AppViewModel()
            WindowGroup {
                ContentView().environmentObject(webViewModel).environmentObject(appViewModel).environmentObject(cameraViewModel)
            }
        }
}


class AppDelegate : NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
