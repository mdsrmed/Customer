//
//  CustomerApp.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/2/23.
//

import SwiftUI

@main
struct CustomerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                CustomerListView()
                    .tabItem {
//                        VStack {
//                            Image(systemName: "person")
//                            Text("Home")
//                        }
                        
                        Symbols.person
                        Text("Home")
                    }
            }
        }
    }
}
