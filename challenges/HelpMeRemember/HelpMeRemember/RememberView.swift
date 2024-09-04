//
//  RememberView.swift
//  HelpMeRemember
//
//  Created by Rodrigo Llaguno on 02/09/24.
//

import SwiftUI

struct RememberView: View {
    let remember: Remember
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                remember.convert()
                    .resizable()
                    .scaledToFit()
            }
            .navigationTitle(remember.name)
        }
    }
}
