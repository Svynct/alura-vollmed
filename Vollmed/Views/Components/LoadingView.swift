//
//  LoadingSpinnerView.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 26/12/23.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isLoading: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isLoading)
                    .blur(radius: self.isLoading ? 3 : 0)
                    
                VStack(spacing: 32) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .accent))
                        .scaleEffect(2)
                    
                    Text("Carregando...")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
                .frame(
                    width: geometry.size.width / 1.5,
                    height: geometry.size.height / 4
                )
                .background(.white)
                .foregroundStyle(.accent)
                .cornerRadius(14)
                .opacity(self.isLoading ? 1 : 0)
                .shadow(radius: 4)
            }
        }
    }
}

#Preview {
    LoadingView(isLoading: .constant(true)) {
        SignInView()
    }
}
