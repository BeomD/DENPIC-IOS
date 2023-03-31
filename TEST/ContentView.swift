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
            
            if !appViewModel.appStoredData.bool(forKey: "launchedBefore")
            {
                VStack
                {
                    Image("access").resizable().scaledToFit()
                    Button(action: {appViewModel.appStoredData.set(true, forKey: "launchedBefore")})
                    {
                        Text("다음으로")
                    }.backgroundStyle(Color.pink)
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(Color.white)
                .ignoresSafeArea(edges: .all)
            }
            //앱화면
            NavigationStack(path: $appViewModel.viewSelector){
                    VStack(){
                        List {
                            NavigationLink("signIn", value: "signIn")
                            NavigationLink("camera", value : "camera")
                        }
                        .navigationDestination(for: String.self) { string in
                            SelectView().environmentObject(appViewModel).environmentObject(webViewModel).environmentObject(cameraViewModel)
                        }
                    }.navigationTitle("")
                }.navigationBarBackButtonHidden(true).navigationTitle("")
            }.ignoresSafeArea()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        isLoading.toggle()
                    })}
        
    }
                 
}

extension ContentView {
    
    var launchScreenView: some View {
        ZStack(alignment: .center) {
            //LinearGradient(gradient: Gradient(colors: [startPointColor,endPointColor]),
            //              startPoint: .top, endPoint: .bottom)
            //.edgesIgnoringSafeArea(.all)
            RadialGradient(colors: [endPointColor2,endPointColor], center: UnitPoint.center, startRadius: 0.0, endRadius:500).ignoresSafeArea()
            VStack(alignment: .center){
                Spacer().frame(height: 200)
                Text("쉽고 정확한 교정촬영의 시작")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20))
                Spacer().frame(height: 50)
                Image("LaunchScreenImage").frame(width: 140,height: 160)
                Spacer().frame(height: 50)
                Text("DENPIC")
                    .foregroundColor(Color.white)
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                Spacer()
                Text("WINOI")
                    .foregroundColor(Color.white)
                    .font(.system(size: 20))
                Spacer().frame(height: 20)
            }.frame(maxWidth: .infinity,maxHeight: .infinity)

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
 
