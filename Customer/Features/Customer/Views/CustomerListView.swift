//
//  CustomerView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/9/23.
//

import SwiftUI

struct CustomerListView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background
                    .ignoresSafeArea(edges: .top)
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(0..<7, id: \.self){ item in
                            VStack {
                                Rectangle()
                                    .fill(.blue)
                                    .frame(height: 130)
                                    .cornerRadius(20)
                            }
                            
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Customer")
            .toolbar {
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Symbols.plus
                            .imageScale(.large)
                            .bold()
                        
                    }

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
