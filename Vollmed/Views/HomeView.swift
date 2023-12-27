//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct HomeView: View {
    
    var viewModel = HomeViewModel(service: HomeNetworkingService(), authService: AuthenticationService())
    
    @State private var specialists: [Specialist] = []
    @State private var isShowingSnackbar: Bool = false
    @State private var isAnimating: Bool = false
    @State private var isFetchingData: Bool = true
    @State private var isLogout: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        LoadingView(isLoading: $isLogout) {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        Image(.logo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .padding(.vertical, 32)
                        
                        Text("Boas-vindas!")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(Color(.lightBlue))
                        
                        Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.accent)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 16)
                        
                        if isFetchingData {
                            SkeletonView()
                        } else {
                            ForEach(specialists) { specialist in
                                SpecialistCardView(specialist: specialist)
                                    .padding(.bottom, 8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
                .onAppear {
                    Task {
                        do {
                            guard let specialists = try await viewModel.getSpecialists() else { return }
                            self.specialists = specialists
                        } catch {
                            isShowingSnackbar = true
                            let errorType = error as? RequestError
                            errorMessage = errorType?.customMessage ?? "Ops, ocorreu um erro!"
                        }
                        isFetchingData = false
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            Task {
                                isLogout = true
                                await viewModel.logout()
                                isLogout = false
                            }
                        }, label: {
                            HStack(spacing: 2) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Logout")
                            }
                        })
                    }
                }
                
                if isShowingSnackbar {
                    SnackBarErrorView(isShowing: $isShowingSnackbar, message: errorMessage)
                        .opacity(isAnimating ? 0 : 1)
                        .onAppear {
                            isAnimating = true
                            withAnimation(.easeInOut(duration: 0.4)) {
                                isAnimating = false
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
