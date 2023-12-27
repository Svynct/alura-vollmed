//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 24/12/23.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    let viewModel = AppointmentsViewModel(service: AppointmentsNetworkingService())
    
    @State private var appointments: [Appointment] = []
    @State private var isLoading: Bool = true
    
    var body: some View {
        VStack {
            if isLoading {
                SkeletonView()
            } else if appointments.isEmpty {
                Spacer()
                Text("Não há nenhuma consulta agendada no momento!")
                    .font(.title2)
                    .bold()
                    .padding()
                    .foregroundStyle(Color(.cancel))
                    .multilineTextAlignment(.center)
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(appointments) { appointment in
                        SpecialistCardView(specialist: appointment.specialist, appointment: appointment)
                    }
                }
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .navigationTitle("Minhas consultas")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .onAppear {
            Task {
                do {
                    guard let appointments = try await viewModel.getAllAppointmentsFromPatient() else {
                        isLoading = false
                        return
                    }
                    self.appointments = appointments
                } catch {
                    print("Ocorreu um erro ao obter consultas: \(error)")
                }
                isLoading = false
            }
        }
    }
}

#Preview {
    MyAppointmentsView()
}
