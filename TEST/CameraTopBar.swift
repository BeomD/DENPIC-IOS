//
//  CameraTopBar.swift
//  TEST
//
//  Created by BJ Man on 2023/01/16.
//

import SwiftUI

struct CameraTopBar: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel
    
    var body: some View {
        if cameraViewModel.timerCaptureOn
        {SettingTimerTopBar()}
        
        else{
            DefaultCameraTopBar()
        }
    }
}

struct DefaultCameraTopBar: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel
    
    var body: some View {
        HStack(alignment: .center){
            // 카메라 나가기
            Button(action: {_ = appViewModel.viewSelector.popLast()}) {
                    Image(systemName: cameraViewModel.isSilentModeOn ?
                          "x.circle.fill" : "x.circle")
                    .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
                    .padding(0)
                    Text("ON").font(.system(size:10))
                        .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
                        .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 10)
            Spacer()
            // 좌표축 온오프
            Button(action: {cameraViewModel.switchSilent()}) {
                Image(systemName: cameraViewModel.isSilentModeOn ?
                      "plus.fill" : "plus")
                .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
            }
            
            // 좌표축 조절
            Button(action: {cameraViewModel.switchFlash()}) {
                Image(systemName: cameraViewModel.isFlashOn ?
                      "plus.fill" : "plus")
                .foregroundColor(cameraViewModel.isFlashOn ? .yellow : .white)
            }
            // 타이머 촬영 온오프
            Button(action: {cameraViewModel.timerCaptureOn.toggle()}) {
                Image(systemName: cameraViewModel.isSilentModeOn ?
                      "timer.fill" : "timer")
                .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
            }
            
            // 플래시 온오프
            Button(action: {cameraViewModel.switchFlash()}) {
                Image(systemName: cameraViewModel.isFlashOn ?
                      "bolt.fill" : "bolt")
                .foregroundColor(cameraViewModel.isFlashOn ? .yellow : .white)
            }
        }.font(.system(size:40))
    }
}


struct SettingTimerTopBar: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel
    
    var body: some View {
        HStack(alignment: .center){
            // 타이머
            Button(action: {cameraViewModel.switchSilent()}) {
                Image(systemName: cameraViewModel.isSilentModeOn ?
                      "timer.fill" : "timer")
                .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
            }
            
            // 타이머
            Button(action: {cameraViewModel.switchFlash()}) {
                Image(systemName: cameraViewModel.isFlashOn ?
                      "timer.fill" : "timer")
                .foregroundColor(cameraViewModel.isFlashOn ? .yellow : .white)
            }
            // 타이머
            Button(action: {cameraViewModel.switchSilent()}) {
                Image(systemName: cameraViewModel.isSilentModeOn ?
                      "timer.fill" : "timer")
                .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
            }
            
            // 타이머
            Button(action: {cameraViewModel.switchFlash()}) {
                Image(systemName: cameraViewModel.isFlashOn ?
                      "timer.fill" : "timer")
                .foregroundColor(cameraViewModel.isFlashOn ? .yellow : .white)
            }
        }.font(.system(size:40))
    }
}


struct SettingFlashTopBar: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel
    
    var body: some View {
        HStack(alignment: .center){
            // 플래시 온오프
            Button(action: {cameraViewModel.switchFlash()}) {
                Image(systemName: cameraViewModel.isFlashOn ?
                      "bolt.fill" : "bolt")
                .foregroundColor(cameraViewModel.isFlashOn ? .yellow : .white)
            }
            
            // 플래시 온오프
            Button(action: {cameraViewModel.switchFlash()}) {
                Image(systemName: cameraViewModel.isFlashOn ?
                      "bolt.fill" : "bolt")
                .foregroundColor(cameraViewModel.isFlashOn ? .yellow : .white)
            }
        }.font(.system(size:40))
    }
}
