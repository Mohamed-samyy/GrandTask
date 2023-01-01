//
//  Cache.swift
//  Challenge_App
//
//  Created by Mahmoud Eissa on 12/17/17.
//  Copyright © 2017 Mahmoud El-Sayed. All rights reserved.
//

import UIKit

class Cache: NSObject {
    
    static var token : String? {
        get {
            return Cache.object(key: "token") as? String 
                
        }
    }
    
    static var FCMToken : String? {
        get {
            return Cache.object(key: "fcmToken") as? String
            
        }
    }
    
    private static func archiveUserInfo(info : Any) -> NSData {
        
        return NSKeyedArchiver.archivedData(withRootObject: info) as NSData
    }
    
    class func object(key:String) -> Any? {
        
        if let unarchivedObject = UserDefaults.standard.object(forKey: key) as? Data {
            
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data)
        }
        
        return nil
    }
    
    class func set(object : Any? ,forKey key:String) {
        
        let archivedObject = archiveUserInfo(info: object!)
        UserDefaults.standard.set(archivedObject, forKey: key)
        UserDefaults.standard.synchronize()
        
    }
    class func setToken(token: String) {
        Cache.set(object: token, forKey: "token")
    }
    
    class func setFCMToken(token: String) {
        Cache.set(object: token, forKey: "fcmToken")
    }

    class func removeObject(key:String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func clearToken() {
        Cache.removeObject(key: "token")
    }
    
    class func clearFCMToken() {
        Cache.removeObject(key: "fcmToken")
    }
    
    class func setValue(value : Bool,forKey key:String){
        let def = UserDefaults.standard
        def.set(value, forKey: key)
        def.synchronize()
    }
    
    class func getValue(key:String) -> Bool{
        let def = UserDefaults.standard
        if let defa = def.object(forKey: key) as? Bool {
            return defa
        }
        return false
    }
    
}
