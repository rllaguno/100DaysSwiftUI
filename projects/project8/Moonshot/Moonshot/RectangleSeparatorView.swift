//
//  RectangleSeparatorView.swift
//  Moonshot
//
//  Created by Rodrigo Llaguno on 28/07/24.
//

import SwiftUI

struct RectangleSeparatorView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    RectangleSeparatorView()
}
