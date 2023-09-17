//
//  CreateView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/13/23.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var vm = CreateViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("First Name", text: $vm.customer.firstName)
                TextField("Last Name", text: $vm.customer.lastName)
                TextField("Job", text: $vm.customer.job)
                
                
                Section {
                    Button("Submit") {
                        vm.create()
                    }
                }
                .navigationTitle("Create")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if #available(iOS 15, *){
                                dismiss()
                            } else {
                                presentationMode.wrappedValue.dismiss()
                            }
                            
                        } label: {
//                            Image(systemName: "xmark")
                               Text("Done")
                                .bold()
                        }

                    }
                }
                .onChange(of: vm.state) { newValue in
                    if newValue == .successful {
                        if #available(iOS 15, *){
                            dismiss()
                        } else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
