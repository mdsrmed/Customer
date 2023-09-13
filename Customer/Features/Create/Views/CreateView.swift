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
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("First Name", text: .constant(""))
                TextField("Last Name", text: .constant(""))
                TextField("Job", text: .constant(""))
                
                
                Section {
                    Button("Submit") {
                        // TODO: Handle action
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
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
