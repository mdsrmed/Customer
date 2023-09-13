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
                
                HStack(spacing: 5) {
                    ZStack(alignment: .bottomTrailing) {
                        AsyncImage(url: .init(string: user.avatar)){ image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70,height: 70)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .strokeBorder(Color.gray, lineWidth: 0.5)
                                }
                            
                            
                            
                        } placeholder: {
                            ProgressView()
                        }
                        
                        
                        
                        TagView(id: user.id)
                            .offset(x:27,y:27)
                    }
                    
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                }

                
                Spacer()
                
//                Button {
//
//
//                } label: {
//                    Image(systemName: "ellipsis")
//                        .imageScale(.large)
//                }
                
                NavigationLink {
                    DetailView()
                } label: {
                    Image(systemName: "ellipsis")
                        .imageScale(.large)
                }

            }
                
                
         
                
  
            }
            
            Divider()
        }
    
}

//struct CustomerView_Previews: PreviewProvider {
//
//    static var previewUser: User {
//        let users = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailResponse.self)
//        return users.data[0]
//    }
//
//    static var previews: some View {
//        CustomerView(user: previewUser)
//    }
//}
