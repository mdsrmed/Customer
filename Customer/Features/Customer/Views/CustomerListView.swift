//
//  CustomerView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/9/23.
//

import SwiftUI

struct CustomerListView: View {
    
    @StateObject private var vm = CustomerViewModel()
    //    @State private var users: [User] = []
    @State private var shouldShowCreate = false
    @State private var shouldShowSuccess: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background
                    .ignoresSafeArea(edges: .top)
                
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(vm.users, id: \.id){ user in
                                
                                CustomerView(user: user)
                            }
                        }
                        .padding()
                    }
                }
                
                
            }
            .navigationTitle("Customer")
            .toolbar {
                ToolbarItem {
                    create
                    
                }
            }
            .onAppear {
                
                vm.fetchUsers()
                
                //                do{
                //                    let res = try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
                //
                //                    self.users = res.data
                //                } catch {
                //                    print(error)
                //                }
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateView{
                    haptic(.success)
                    withAnimation(.spring().delay(0.25)) {
                        self.shouldShowSuccess.toggle()
                    }
                }
                .alert(isPresented: $vm.hasError, error: vm.error) {
                    Button("Retry") {
                        vm.fetchUsers()
                    }
                }
                .overlay {
                    if shouldShowSuccess {
                        CheckmarkPopoverView()
                            .transition(.scale.combined(with: .opacity))
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    withAnimation(.spring()){
                                        self.shouldShowSuccess.toggle()
                                    }
                                }
                            }
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
    
    
    private extension CustomerListView {
        var create: some View {
            Button {
                shouldShowCreate.toggle()
            } label: {
                Symbols.plus
                    .imageScale(.large)
                    .bold()
                
            }
            .disabled(vm.isLoading)
            
        }
    }
    
