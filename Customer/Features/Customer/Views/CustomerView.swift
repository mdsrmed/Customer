//
//  CustomerView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/9/23.
//

import SwiftUI

struct CustomerView: View {
    
    let user: User?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Symbols.person
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70,height: 70)
                    .clipShape(Circle())
                
                HStack {
                    Text(user?.firstName ?? "firstName")
                        .font(.title)
                        .bold()
                    
                    Text(user?.lastName ?? "lastName")
                        .font(.title)
                        .bold()
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .imageScale(.large)
                }

                    
                    
            }
            
            Divider()
        }
    }
}

//struct CustomerView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomerView()
//    }
//}
