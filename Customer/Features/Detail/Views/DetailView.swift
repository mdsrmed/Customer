//
//  DetailView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/10/23.
//

import SwiftUI

struct DetailView: View {
    
    let user: User
    
    var body: some View {
        
        ZStack {
            background
          
                
                VStack {
                    ZStack(alignment: .bottomTrailing) {
                        AsyncImage(url: .init(string: user.avatar)){ image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150,height:150)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .strokeBorder(Color.gray, lineWidth: 0.5)
                                }
                            
                            
                            
                        } placeholder: {
                            ProgressView()
                        }
                        
                        TagView(id: user.id)
                            .offset(x:15,y:15)
                    }
                }
                
            }
            
            VStack(alignment: .leading, spacing: 20) {
                
                
                Group {
                    detailViewComponent("First Name")
                    
                    Divider()
                    
                    detailViewComponent("Last Name")
                    
                    Divider()
                    
                    detailViewComponent("Email")
                    
                }
                .foregroundColor(Theme.text)
                
                Group {
                    HStack {
                        Link(destination: .init(string: "https://reqres.in/#support-heading")!) {
                            
                            VStack(alignment: .leading,spacing: 8) {
                                Text("Support Reqres")
                                    .foregroundColor(Theme.text)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                
                                Text("https://reqres.in/#support-heading")
                            }
                        }
                        
                        Spacer()
                        Image(systemName: "link")
                            .imageScale(.large)
                        
                    }
                    
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .background(Theme.detailbackground, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                
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
        func detailViewComponent(_ text: String) -> some View {
            Text("\(text)")
                .font(.body)
                .fontWeight(.semibold)
            
            Text("<\(text) Here>")
                .font(.subheadline)
        }
}
