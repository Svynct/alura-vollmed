//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 24/12/23.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    let service = WebService()
    var appointmentID: String
    
    @State private var reasonToCancel = ""
    @State private var canceled = false
    @State private var showAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    func cancelAppointment() async {
        do {
            if try await service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel) {
                canceled = true
            }
        } catch {
            print("Ocorreu um erro ao cancelar a consulta: \(error)")
            canceled = false
        }
        showAlert = true
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $reasonToCancel)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.lightBlue).opacity(0.15))
                .cornerRadius(16)
                .frame(maxHeight: 300)
            
            Button {
                Task {
                    await cancelAppointment()
                }
            } label: {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
            }
        }
        .padding()
        .navigationTitle("Cancelar consulta")
        .navigationBarTitleDisplayMode(.large)
        .alert(canceled ? "Sucesso!" : "Ops, algo deu errado!", isPresented: $showAlert, presenting: canceled) { _ in
            Button(action: {
                if canceled {
                    presentationMode.wrappedValue.dismiss()                    
                }
            }, label: {
                Text("Ok")
            })
        } message: { canceled in
            if canceled {
                Text("A consulta foi cancelada com sucesso.")
            } else {
                Text("Houve um erro ao cancelar sua consulta. Por favor tente novamente ou entre em contato via telefone.")
            }
        }

    }
}

#Preview {
    CancelAppointmentView(appointmentID: "123")
}
