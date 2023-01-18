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
    @Published var findPasswordClicked = false
    @Published var signUpClicked = false
    
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser  != nil
    }
    
    func setSignedInView(){
            if self.signedIn {
                //로그인 성공하면
                self.viewSelector.append("signedIn")
            }
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
                self?.setSignedInView()
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

struct SignInView: View {
    var body: some View {
        NavigationView{
            ZStack {
                VStack{
                    MyWebView(urlToLoad: "https://denpic-prototype.web.app/signInMobile").ignoresSafeArea()
                }
            }
        }
    }
}

struct SignInedView: View {
    var body: some View {
        NavigationView{
            ZStack {
                VStack{
                    MyWebView(urlToLoad: "https://www.naver.com").ignoresSafeArea()
                }
            }
        }
    }
}



struct SignUpView: View {
    var body: some View {
        NavigationView{
            ZStack {
                VStack{
                    MyWebView(urlToLoad: "https://denpic-prototype.web.app/signUpMobile").ignoresSafeArea()
                }
            }
        }
        }
}


struct findPasswordView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel :AppViewModel
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack{
                    MyWebView(urlToLoad: "https://denpic-prototype.web.app/passwordResetMobile").ignoresSafeArea()
                    //Image("logo").resizable().scaledToFit().frame(width:150,height:150)
                    /// VStack{
                    //  TextField("Email Address", text:$email).disableAutocorrection(true).autocapitalization(.none).background(Color(.secondarySystemBackground)).padding()
                    // SecureField("Password", text: $password).disableAutocorrection(true).autocapitalization(.none).background(Color(.secondarySystemBackground)).padding()
                    //Button(action:{
                    //  guard !email.isEmpty, !password.isEmpty else{
                    //     return
                    //}
                    //viewModel.signUp(email: email, password: password)},label: {
                    //Text("Create Account")
                    //.foregroundColor(Color.white).frame(width:200,height:50).background(Color.blue)})
                    //}
                    //Spacer()
                    //}.padding().navigationTitle("Create Account")
                }
            }
        }
        }
}
