//
//  DetailView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/10/23.
//

import SwiftUI

struct DetailView: View {
    
    //    let user: User
    @State private var userInfo: UserDetailResponse?
    
    var body: some View {
        
        ZStack {
            
            background
            
            VStack(alignment: .leading, spacing: 20) {
                
                
//                TagView(id: userInfo?.data.id)
                
                
                avatar
                
                
                Group {
                    detailViewComponent("First Name" ,userInfo?.data?.firstName ?? "-")
                    
                    Divider()
                    
                    detailViewComponent("Last Name",userInfo?.data?.lastName ?? "-")
                    
                    Divider()
                    
                    detailViewComponent("Email", userInfo?.data?.email ?? "-")
                    
                }
                .foregroundColor(Theme.text)
                
                Group {
                    link
                    
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .background(Theme.detailbackground, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                
            }
            .padding()
        }
        .navigationTitle("Details")
        .onAppear{
            do {
                 userInfo = try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
            } catch {
                print(error)
            }
        }
    }
    
}
    
    







//struct DetailView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        DetailView(user: <#User#>)
    //    }
    //}
extension DetailView {
    var background: some View {
        Theme.background
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    func detailViewComponent(_ text: String, _ text1: String) -> some View {
        Text("\(text)")
            .font(.body)
            .fontWeight(.semibold)
        
        Text("\(text1)")
            .font(.subheadline)
    }
    
    
    @ViewBuilder
    var link: some View {
        
        if let supportAbsoluteString = userInfo?.support?.url,
           let supportUrl = URL(string: supportAbsoluteString),
           let supportTxt = userInfo?.support?.text {
            HStack {
                Link(destination: supportUrl) {
                    
                    VStack(alignment: .leading,spacing: 8) {
                        Text(supportTxt)
                            .foregroundColor(Theme.text)
                            .font(.body)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                        
                        Text(supportAbsoluteString)
                    }
                }
                
                Spacer()
                
                Image(systemName: "link")
                    .imageScale(.large)
                
            }
        }
        
        
    }
    
    @ViewBuilder
    var avatar: some View {
        if let avatarAbsoluteString = userInfo?.data?.avatar,
           let avatarUrl = URL(string: avatarAbsoluteString){
            AsyncImage(url: avatarUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250,height: 250)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }

        }
    }
}
