//
//  ContentView.swift
//  TEST
//
//  Created by BJ Man on 2022/12/18.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel
    
    @State var isLoading: Bool = true

    let startPointColor = Color(UIColor(rgb: 0xFFACB0E0))
    let endPointColor = Color(UIColor(rgb: 0xFD9A9F))
    let endPointColor2 = Color.white
    //
    var body: some View {
            ZStack {
                // Launch Screen
                if isLoading {
                    launchScreenView
                }
                
                //앱화면
                NavigationStack(path: $appViewModel.viewSelector){
                    VStack(){
                        List {
                            NavigationLink("signIn", value: "signIn")
                            NavigationLink("signUp", value: "signUp")
                            NavigationLink("findPassword", value: "findPassword")
                            NavigationLink("camera", value : "camera")
                            }
                        .navigationDestination(for: String.self) { string in
                            SelectView(selector: string)
                        }
                    }.navigationTitle("")
                }.navigationBarBackButtonHidden(true).navigationTitle("")
            }.ignoresSafeArea()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                        isLoading.toggle()
                    })}
              
    }
                 
}

extension ContentView {
    
    var launchScreenView: some View {
        ZStack(alignment: .center) {
            //LinearGradient(gradient: Gradient(colors: [startPointColor,endPointColor]),
            //               startPoint: .top, endPoint: .bottom)
            //.edgesIgnoringSafeArea(.all)
            RadialGradient(colors: [endPointColor2,endPointColor], center: UnitPoint.center, startRadius: 0.0, endRadius:500).ignoresSafeArea()
            VStack(alignment: .center){
                Text("헤드 텍스트")
                    .foregroundColor(Color.black)
                Image("LaunchScreenImage").scaledToFit()
                Text("미드 테스트")
                    .foregroundColor(Color.black)
                Text("버텀 텍스트")
                    .foregroundColor(Color.black)
            }
        }.zIndex(1)
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
 
    convenience init(rgb: Int) {
           self.init(
               red: (rgb >> 16) & 0xFF,
               green: (rgb >> 8) & 0xFF,
               blue: rgb & 0xFF
           )
       }
    
    // let's suppose alpha is the first component (ARGB)
    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }
}
 
