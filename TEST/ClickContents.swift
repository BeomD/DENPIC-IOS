//
//  ContentView.swift
//  SwiftUI_tutorial_#1
//
//  Created by Jeff Jeong on 2020/06/30.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import SwiftUI

struct ClickContents: View {
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var webViewModel: WebViewModel
    // @State 값의 변화를 감지 -> 뷰에 적용
    @State private var isActivated: Bool = false
    @State var url : String = "https://denpic-prototype.web.app/signInMobile"
    
    // 몸체
    var body: some View {
        NavigationStack(path: $appViewModel.viewSelector){
            VStack(){
                List {
                    NavigationLink("signIn", value: "signIn")
                    NavigationLink("signUp", value: "signUp")
                    NavigationLink("findPassword", value: "findPassword")
                    }
                .navigationDestination(for: String.self) { string in
                    SelectView(selector: string)
                }
                /* HStack{
                 MyVstackView(isActivated: $isActivated)
                 MyVstackView(isActivated: $isActivated)
                 MyVstackView(isActivated: $isActivated)
                 
                 } // Hstack
                 .padding(isActivated ? 50.0 : 10.0)
                 //
                 .background(isActivated ? Color.yellow : Color.black)
                 // 탭 재스쳐 추가
                 .onTapGesture {
                 print("HStack 이 클릭되었다.")
                 
                 // 애니메이션과 함께
                 withAnimation {
                 // toggle() true 이면 false 로 false 이면 true
                 self.isActivated.toggle()
                 }
                 }// Hstack
                 */
                // 네비게이션 버튼(링크)
                //NavigationLink(destination: MyTextView(isActivated: $isActivated) ){
                NavigationLink(destination: MyWebView(urlToLoad: url).ignoresSafeArea().navigationBarBackButtonHidden(true)){
                        Text("Open WebPage")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(Color.white)
                            .cornerRadius(30)
                    }
            }.navigationTitle("")
        }.navigationBarBackButtonHidden(true).navigationTitle("")// NavigationStack
    }
}

