//
//  ProgressView.swift
//  ProteinPlus
//
//  Created by Oliver Hu on 9/10/24.
//

import SwiftUI

struct ProgressView: View {
    @Binding var progress: Float
    var color: Color = Color.yellow
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 12.0)
                .opacity(0.20)
                .foregroundStyle(Color.gray)
                .shadow(radius: 5)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .foregroundStyle(progress < 1.0 ? color : Color.green)
                .rotationEffect(Angle(degrees: 270))
        }
    }
}

//#Preview {
//    ProgressView(progress: 0.0, color: Color.green)
//}
