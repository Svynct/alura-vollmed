//
//  SnackBarErrorView.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 27/12/23.
//

import SwiftUI

struct SnackBarErrorView: View {
    
    @Binding var isShowing: Bool
    var message: String
    
    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                Text(message)
                    .padding()
                    .background(Color.red)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    .transition(.move(edge: .bottom))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .padding(.horizontal)
        .padding(.bottom, isShowing ? UIApplication.shared.getKeyWindow?.safeAreaInsets.bottom ?? 0 : -100)
    }
}

#Preview {
    SnackBarErrorView(isShowing: .constant(true), message: "Ops! Ocorreu um erro, mas já estamos trabalhando para solucioná-lo")
}
