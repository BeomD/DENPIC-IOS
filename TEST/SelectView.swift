//
//  SelectView.swift
//  TEST
//
//  Created by BJ Man on 2023/01/06.
//

import SwiftUI

struct SelectView: View {
    @State var selector : String = "signIn"
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel
    @State var hideNavigationBar : Bool = false
    var body: some View {
        switch selector {
        case "signIn":
        SignInView().navigationBarBackButtonHidden(hideNavigationBar)
        case "signedIn":
        SignInedView().navigationBarBackButtonHidden(hideNavigationBar)
        case "signUp":
        SignUpView().navigationBarBackButtonHidden(hideNavigationBar)
        case "findPassword":
        findPasswordView().navigationBarBackButtonHidden(hideNavigationBar)
        case "camera":
        CameraView().navigationBarBackButtonHidden(hideNavigationBar)
        default :
        SignInView().navigationBarBackButtonHidden(hideNavigationBar)
        }
    }
}
