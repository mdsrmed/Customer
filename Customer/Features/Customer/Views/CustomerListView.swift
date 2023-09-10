//
//  CustomerView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/9/23.
//

import SwiftUI

struct CustomerListView: View {
    
    @State private var users: [User] = []
 
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background
                    .ignoresSafeArea(edges: .top)
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(users, id: \.id){ user in
                            
                            CustomerView(user: user)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Customer")
            .toolbar {
                ToolbarItem {
                    create

                }
            }
            .onAppear {
                do{
                    let res = try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
                    
                    self.users = res.data
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct CustomerListView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerListView()
    }
}


private extension CustomerListView {
    var create: some View {
        Button {
            
        } label: {
            Symbols.plus
                .imageScale(.large)
                .bold()
            
        }

    }
}
