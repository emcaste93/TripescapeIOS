//
//  AuthenticationService.swift
//  Tripescape
//
//  Created by Emilio Castellano on 27/07/2021.
//

import Foundation
import FirebaseAuth

class AuthenticationService {
    
    static let sharedInstance = AuthenticationService()
    typealias CompleteHandler = (Error?) -> Void
    
    private init() {

    }
    
    func loginUser(email: String, password: String, onComplete: @escaping CompleteHandler) {
        print("loginUser starts")
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error as NSError?, let errorCode = AuthErrorCode(rawValue: error.code) {
                print("Ha habido un error logeando al usuario: \(errorCode)")
                onComplete(error)
                return
            }
            if let res = result {
                print("User authenticated")
                onComplete(nil)
            }
        }
    }
    
    func registerUser(email: String, password: String, onComplete: @escaping CompleteHandler) {
        print("registerUser starts")
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error as NSError?, let errorCode = AuthErrorCode(rawValue: error.code) {
                print("Ha habido un error registrando al usuario: \(errorCode)")
                onComplete(error)
            } else {
                print("User registered")
                onComplete(nil)
            }
        }
    }
    
    func logout() {
        do {
            print("log out starts")
            try Auth.auth().signOut()
        }
        catch {
                print("User already logged out")
            }
    }
}
