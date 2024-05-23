//
//  LoginView.swift
//  PersonalCapstone
//
//  Created by Ami Smith on 3/25/24.
//

import SwiftUI
import LocalAuthentication
import CoreData

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var biometricAuthenticationError: String?
    @State private var authenticationError: String?
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn {
            MainView()
        } else {
            ZStack {
                Color("updatedCream").ignoresSafeArea()
                VStack {
                    TextField("Username", text: $username)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)   .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Password", text: $password)
                        .autocorrectionDisabled()
                        .autocapitalization(.none) 
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Login with Face ID") {
                        authenticateWithBiometrics()
                    }
                    .padding()
                    
                    Button("Login with Password") {
                        authenticateWithPassword()
                    }
                    .padding()
                    
                    Text(biometricAuthenticationError ?? "")
                        .foregroundColor(.red)
                        .padding()
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
    func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login with Face ID") { success, error in
                DispatchQueue.main.async {
                    if success {
                        print("Authentication with Face ID successful")
                        
                    } else {
                        
                        biometricAuthenticationError = error?.localizedDescription ?? "Biometric authentication failed"
                    }
                }
            }
        } else {
            biometricAuthenticationError = error?.localizedDescription ?? "Biometric authentication not available"
        }
    }
    
    func authenticateWithPassword() {
        if isValidCredentials(username: username, password: password) {
            
            authenticationError = nil
            isLoggedIn = true
            print("Login Successful")
            
        } else {
            authenticationError = "Invalid username or password"
            print("Login failed")
        }
    }
    
    func isValidCredentials(username: String, password: String) -> Bool {
        return username == "exampleUser" && password == "examplePassword"
    }
}


#Preview {
    LoginView()
}
