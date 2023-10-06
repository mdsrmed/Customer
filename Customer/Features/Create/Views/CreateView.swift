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
    @FocusState private var focusField: Field?
    let successfulAction: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    TextField("First Name", text: $vm.customer.firstName)
                        .focused($focusField, equals:  .firstName)
                    TextField("Last Name", text: $vm.customer.lastName)
                        .focused($focusField, equals:  .lastName)
                    TextField("Job", text: $vm.customer.job)
                        .focused($focusField, equals:  .job)
                } footer: {
                    if case .validation(let err) = vm.error,
                       let errorDesc = err.errorDescription {
                        Text(errorDesc)
                            .foregroundStyle(.red)
                    }
                }

                
                
                
                
                Section {
                    Button("Submit") {
                        focusField = nil
                        Task {
                            await vm.create()
                        }
//                        vm.create()
                    }
                }
                .disabled(vm.state == .submitting)
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
                            successfulAction()
                        } else {
                            presentationMode.wrappedValue.dismiss()
                            successfulAction()
                        }
                    }
                }
                .alert(isPresented: $vm.hasError, error: vm.error) {
                    Button("Retry") {}
                }
                .overlay {
                    if vm.state == .submitting {
                        ProgressView()
                    }
                }
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView{}
    }
}

extension CreateView {
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
}
