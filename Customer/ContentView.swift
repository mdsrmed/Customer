//
//  ContentView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello customer")
        }
        .padding()
        .onAppear {
            print("Users Response")
            dump(
               try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
