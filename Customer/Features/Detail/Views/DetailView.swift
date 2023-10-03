//
//  DetailView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/10/23.
//

import SwiftUI

struct DetailView: View {
    
    //    let user: User
    @StateObject private var vm = DetailViewModel()
    let userId: Int
//    @State private var userInfo: UserDetailResponse?
    
    var body: some View {
        
        ZStack {
            
            background
            
            if vm.isLoading {
                ProgressView()
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    
                    
    //                TagView(id: userInfo?.data.id)
                    
                    
                    VStack(spacing: 10) {
                        HStack {
                            avatar
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                       
                    }
                    
                    
                    Group {
                        detailViewComponent("First Name" ,vm.userInfo?.data?.firstName ?? "-")
                        
                        Divider()
                        
                        detailViewComponent("Last Name",vm.userInfo?.data?.lastName ?? "-")
                        
                        Divider()
                        
                        detailViewComponent("Email", vm.userInfo?.data?.email ?? "-")
                        
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
            
            
        }
        .navigationTitle("Details")
        .onAppear{
            
            vm.fetchDetails(for: userId)
//            do {
//                 userInfo = try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
//            } catch {
//                print(error)
//            }
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Retry") {}
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
        
        if let supportAbsoluteString = vm.userInfo?.support?.url,
           let supportUrl = URL(string: supportAbsoluteString),
           let supportTxt = vm.userInfo?.support?.text {
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
        if let avatarAbsoluteString = vm.userInfo?.data?.avatar,
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
