//
//  CheckmarkPopoverView.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 10/3/23.
//

import SwiftUI

struct CheckmarkPopoverView: View {
    var body: some View {
        Symbols.checkmark
            .font(.system(.largeTitle,design: .rounded).bold())
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    CheckmarkPopoverView()
        .previewLayout(.sizeThatFits)
        .padding()
        .background(.green)
}
