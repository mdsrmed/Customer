//
//  TagView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/9/23.
//

import SwiftUI

struct TagView: View {
    
    let id: Int
    
    var body: some View {
        Image(systemName: "tag.fill")
            .imageScale(.large)
            .foregroundColor(.blue)
            .padding()
            .overlay {
                Text("\(id)")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.vertical)
            }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(id: 5)
    }
}
