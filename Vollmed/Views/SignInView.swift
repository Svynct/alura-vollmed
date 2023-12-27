//
//  SignInView.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 26/12/23.
//

import SwiftUI

struct SignInView: View {

    let service = WebService()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var isLoading: Bool = false
  
    func login() async {
        isLoading = true
        do {
            if let response = try await service.loginPatient(email: email, password: password) {
                AuthenticationManager.shared.saveToken(response.token)
                AuthenticationManager.shared.savePatientID(response.id)
            } else {
                showAlert = true
            }
        } catch {
            showAlert = true
            print("Ocorreu um erro no login: \(error)")
        }
        isLoading = false
    }
    
    var body: some View {
        LoadingView(isLoading: $isLoading) {
            VStack(alignment: .leading, spacing: 16) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 36, alignment: .center)
                
                Text("Olá!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
                
                Text("Preencha para acessar a sua conta.")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                Text("Email")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                InputFieldView("Insira seu email", text: $email)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                Text("Senha")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                InputFieldView("Insira sua senha", text: $password, secure: true)
                
                Button(action: {
                    Task {
                        await login()
                    }
                }, label: {
                    ButtonView(text: "Entrar")
                })
                
                NavigationLink {
                    SignUpView()
                } label: {
                    Text("Ainda não possui uma conta? Cadastre-se")
                        .bold()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden()
            .alert("Ops, algo deu errado!", isPresented: $showAlert) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Ok")
                })
            } message: {
                Text("Houve um erro ao entrar na sua conta. Por favor, tente novamente.")
            }
        }
    }
}

#Preview {
    SignInView()
}
