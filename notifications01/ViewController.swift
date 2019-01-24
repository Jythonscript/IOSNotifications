//
//  ViewController.swift
//  notifications01
//
//  Created by 90302927 on 11/12/18.
//  Copyright © 2018 90302927. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

//    var window: UIWindow?
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.registerForRemoteNotifications()
        center.requestAuthorization(options: [.alert, .sound, /*.badge,*/ /*.criticalAlert,*/ .providesAppNotificationSettings])
        { (granted, error) in
//            print(granted)
        }
        
        let action1 = UNNotificationAction(identifier: "action1", title: "Action 1", options:[])
        let action2 = UNNotificationAction(identifier: "action2", title: "Action 2", options:[])
        
        let category = UNNotificationCategory(identifier: "buttonNotification", actions:[action1, action2], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
//        print("hi!")
//        print(response.actionIdentifier)
        
        if response.actionIdentifier == "action1" {
            print("You picked option 1")
        }
        else if response.actionIdentifier == "action2" {
            print("You picked option 2")
        }
        else {
            print("another option: \(response.actionIdentifier)")
        }
        completionHandler()
    }
    
    func appUpdateAlert() {
        
        //send an alert that
        let alert = UIAlertController(title: "A newer version of this app was detected", message: "Would you like to update?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            guard let url = URL(string: "https://testflight.apple.com/") else { return }
            UIApplication.shared.open(url)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
        //get app version as string and put it into appVersion
        var appVersion:String = ""
        var appBuildVersion:String = ""
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            appVersion = version
        }
        
        if let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            appBuildVersion = buildVersion
        }
        
        print("App Version:")
        print(appVersion)
        print("App Build Number:")
        print(appBuildVersion)
        
    }
        
    
    @IBAction func button1pressed(_ sender: UIButton) {
//        print("button1")
        /*
        UNUserNotificationCenter.current().delegate = self
        let content = UNMutableNotificationContent()
        //content.title = NSString.localizedUserNotificationString(forKey: "This is the title of the notification", arguments: nil)
        content.title = "This is the title of the notification"
        //content.body = NSString.localizedUserNotificationString(forKey: "This is the body of the notification", arguments: nil)
        content.body = "This is the body of the notification"
//        content.sound = UNNotificationSound.defaultCriticalSound(withAudioVolume: 1.0)
//        content.sound = UNNotificationSound.criticalSoundNamed(name: UNNotificationSoundName., withAudioVolume: <#T##Float#>)
//        content.sound = UNNotificationSound.criticalSoundNamed(UNNotificationSoundName.init("scream.mp3"), withAudioVolume: 1.0)
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "scream.mp3"))
//        content.badge = NSNumber(integerLiteral: content.badge?.intValue ?? 0 + 1)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
        
//        print(trigger.nextTriggerDate())
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let request = UNNotificationRequest(identifier: "request1", content: content, trigger: trigger)
        
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
                // Handle any errors
                
            }
        }
         */
        appUpdateAlert()
    }
    
    @IBAction func button2pressed(_ sender: UIButton) {
//        print("button2")
        UNUserNotificationCenter.current().delegate = self
        let content = UNMutableNotificationContent()
        //content.title = NSString.localizedUserNotificationString(forKey: "This is the title of the notification", arguments: nil)
        content.title = "This is the title of the notification"
        //content.body = NSString.localizedUserNotificationString(forKey: "This is the body of the notification", arguments: nil)
        content.body = "This is the body of the notification (swipe notification down for options)"
        //        content.sound = UNNotificationSound.defaultCriticalSound(withAudioVolume: 1.0)
        //        content.sound = UNNotificationSound.criticalSoundNamed(name: UNNotificationSoundName., withAudioVolume: <#T##Float#>)
//        content.sound = UNNotificationSound.criticalSoundNamed(UNNotificationSoundName.init("Descent"), withAudioVolume: 1.0)
//        content.badge = NSNumber(integerLiteral: content.badge?.intValue ?? 0 + 1)
        content.categoryIdentifier = "buttonNotification"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
        
        //        print(trigger.nextTriggerDate())
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let request = UNNotificationRequest(identifier: "request2", content: content, trigger: trigger)
        
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
                // Handle any errors
                
            }
        }
    }

}

