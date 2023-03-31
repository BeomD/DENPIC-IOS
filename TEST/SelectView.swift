//
//  SelectView.swift
//  TEST
//
//  Created by BJ Man on 2023/01/06.
//

import SwiftUI

struct SelectView: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel
    @State var hideNavigationBar : Bool = true
    var body: some View {
        switch appViewModel.viewSelector.last {
        case "signIn":
        DefaultWebView().navigationBarBackButtonHidden(hideNavigationBar)
        case "camera":
        CameraView().navigationBarBackButtonHidden(hideNavigationBar)
        case "gridPhotoView":
        GridPhotoView().navigationBarBackButtonHidden(hideNavigationBar)
        default :
        DefaultWebView().navigationBarBackButtonHidden(hideNavigationBar)
        }
    }
}

