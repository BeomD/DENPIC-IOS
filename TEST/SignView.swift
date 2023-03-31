//
//  ContentView.swift
//  SwiftUIFirebaseAuth
//
//  Created by BJ Man on 2022/12/28.
//

import SwiftUI
import FirebaseAuth

class AppViewModel : ObservableObject{
    @Published var viewSelector : [String] = ["camera"]
    @Published var signedIn = false
    @Published var appStoredData = UserDefaults.standard
        
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser  != nil
    }
    
    func signInEmail(email: String, password: String){
        auth.signIn(withEmail:email,password: password){[weak self]
            result, error in guard result  != nil, error == nil else{return}
                //Success
                self?.signedIn = true
        }
    }
    
    func signInToken(token: String){
        print("토큰으로 로그인을 시도합니다")
        auth.signIn(withCustomToken: token){[weak self]
            result, error in guard result  != nil, error == nil else{return}
                //Success
                self?.signedIn = true
                print("로그인 성공!")
        }
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password){[weak self]
            result, error in guard result  != nil, error == nil else{return}
                //Success
                //Success
                self?.signedIn = true
        }
    }
    func signOut(){
        try? auth.signOut()
        self.signedIn=false
    }
}

struct DefaultWebView: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel
    var body: some View {
        NavigationView{
            ZStack {
                VStack{
                    MyWebView().ignoresSafeArea().environmentObject(webViewModel).environmentObject(appViewModel)
                }
            }
        }
    }
}
