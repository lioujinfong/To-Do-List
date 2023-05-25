//
//  To_Do_ListApp.swift
//  To-Do-List
//
//  Created by Mac2_iparknow on 2023/5/23.
//

import SwiftUI

@main
struct To_Do_ListApp: App {
    @StateObject var m_ToDoList = M_ToDoList()
    @StateObject var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(m_ToDoList)
                .environmentObject(viewModel)
        }
    }
}
