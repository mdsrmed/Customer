//
//  CustomerView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/9/23.
//

import SwiftUI

struct CustomerView: View {
    
    let user: User
//    let id: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
//                HStack(alignment: .bottom) {
//                    Symbols.person
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 70,height: 70)
//                        .clipShape(Circle())
                
                AsyncImage(url: .init(string: user.avatar)){ image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70,height: 70)
                        .clipShape(Circle())
                                                
                    
                } placeholder: {
                     ProgressView()
                }
         
                    TagView(id: user.id)
                }
                
                
         
                Text("\(user.firstName)+(user.lastName)")
                        .font(.title)
                        .bold()

                
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

//struct CustomerView_Previews: PreviewProvider {
//
//    static var previewUser: User {
//        let users = try! StaticJSONMapper.decode(file: "UserStaticData", type: UserDetailResponse.self)
//        return users.data.first!
//    }
//
//    static var previews: some View {
//        CustomerView(user: previewUser)
//    }
//}
