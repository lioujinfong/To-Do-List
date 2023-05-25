//
//  M_ToDoList.swift
//  To-Do-List
//
//  Created by Mac2_iparknow on 2023/5/23.
//

import Foundation
import Combine
import CoreLocation

class M_ToDoList: ObservableObject {
    
//    @Published var Due_Date_sort : [String] = []
    
    @Published var Title: Dictionary<String, String> {
        didSet {
            UserDefaults.standard.set(Title, forKey: "Title")
        }
    }
    @Published var Description: Dictionary<String, String> {
        didSet {
            UserDefaults.standard.set(Description, forKey: "Description")
        }
    }
    @Published var Created_Date: Dictionary<String, Date> {
        didSet {
            UserDefaults.standard.set(Created_Date, forKey: "Created_Date")
        }
    }
    @Published var Due_Date: Dictionary<String, Date> {
        didSet {
            UserDefaults.standard.set(Due_Date, forKey: "Due_Date")
        }
    }
    @Published var Device_Location: Dictionary<String, [String:Double]> {
        didSet {
            UserDefaults.standard.set(Device_Location, forKey: "Device_Location")
        }
    }
    
    init() {
        self.Title = UserDefaults.standard.object(forKey: "Title") as? Dictionary<String, String> ?? [:]
        self.Description = UserDefaults.standard.object(forKey: "Description") as? Dictionary<String, String> ?? [:]
        self.Created_Date = UserDefaults.standard.object(forKey: "Created_Date") as? Dictionary<String, Date> ?? [:]
        self.Due_Date = UserDefaults.standard.object(forKey: "Due_Date") as? Dictionary<String, Date> ?? [:]
        self.Device_Location = UserDefaults.standard.object(forKey: "Device_Location") as? Dictionary<String, [String:Double]> ?? [:]
       
    }
    
}

// 清空所有數據
func clearAllUserDefaultsData(){
    let userDefaults = UserDefaults.standard
    let dics = userDefaults.dictionaryRepresentation()
    for key in dics {
        userDefaults.removeObject(forKey: key.key) // 刪除所有使用者資料
    }
    userDefaults.synchronize()
}
