//
//  BasicSwiftApp.swift
//  BasicSwift
//
//  Created by remotestate on 13/03/23.
//

import SwiftUI

import FirebaseCore
import FirebaseAuth
import GoogleSignIn

@main
struct BasicSwiftApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var userInfoEvn = UserInfoEvn()
    // inject into SwiftUI life-cycle via adaptor !!!
      @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            /*
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
             */
            AppRootView().environmentObject(userInfoEvn)
            
         
            /*
            var url = "https://media.istockphoto.com/id/1346932521/photo/virtual-video-conference-business-meeting.jpg?b=1&s=170667a&w=0&k=20&c=CajphXYbFBefU2j8Q56SDVFd8YkBOD8eruR4pSrr5cM="
            
            URLImage(url: url)

               
            */
        }
    }
    
}



class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print(">> your code here !!")
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print(">> your code here !!")
      let r =  GIDSignIn.sharedInstance.handle(url)
        return r
    }
}
