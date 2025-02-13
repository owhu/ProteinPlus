//
//  StandardSmallButtonModifier.swift
//  ProteinPlus
//
//  Created by Oliver Hu on 9/18/24.
//

import SwiftUI

struct StandardSmallButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.primary)
            .frame(width: 172, height: 44)
            .background(.thinMaterial)
            .cornerRadius(8)
    }
}
