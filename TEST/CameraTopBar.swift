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
        if cameraViewModel.viewTimerTopBar
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
                    Image(systemName: "xmark")
                        .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
                        .padding(0)
                }
                .padding(.horizontal, 10)
                
                Spacer()
                
                // 좌표축 온오프
                Button(action: {cameraViewModel.drawLine.toggle()}) {
                    ZStack(alignment: .bottomTrailing)
                    {
                        Image(systemName: "plus")
                            .foregroundColor(cameraViewModel.drawLine ? .yellow : .white)
                        Text("ON")
                            .font(.system(size: 12))
                        //.frame(width: 16.0,height: 16.0)
                            .foregroundColor(cameraViewModel.drawLine ? .yellow : .white)
                        
                    }
                }
                
                // 좌표축 조절
                Button(action: {cameraViewModel.isEditDrawLineOn.toggle()}) {
                    ZStack(alignment: .bottomTrailing)
                    {
                        Image(systemName: "plus")
                            .foregroundColor(cameraViewModel.isEditDrawLineOn ? .yellow : .white)
                        Image(systemName: "pencil")
                            .resizable()
                            .foregroundColor(cameraViewModel.isEditDrawLineOn ? .yellow : .white)
                            .frame(width: 16,height: 16)
                    }
                }
                // 타이머 촬영 온오프
                Button(action: {cameraViewModel.viewTimerTopBar.toggle()}) {
                    ZStack(alignment: .bottomTrailing)
                    {
                        Image(systemName: "timer")
                            .foregroundColor(cameraViewModel.isEditingTimerCapture ? .yellow : .white)
                        if cameraViewModel.timerAmount != 0
                        {
                            Text("\(cameraViewModel.timerAmount)")
                                .font(.system(size: 12))
                                .foregroundColor(cameraViewModel.isEditingTimerCapture ? .yellow : .white)
                        }
                    }
                }
                
                // 플래시 온오프
                Button(action: {cameraViewModel.switchFlash()}) {
                    ZStack(alignment: .bottomTrailing)
                    {
                        Image(systemName: cameraViewModel.isFlashOn ?
                              "bolt.fill" : "bolt")
                        .foregroundColor(cameraViewModel.isFlashOn ? .yellow : .white)
                        Text("ON")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                }
            }.font(.system(size:40)).background(Color.black)
        }
}


struct SettingTimerTopBar: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel
    
    var body: some View {
            HStack(alignment: .center){
                Spacer()
                // 타이머
                Button(action: {
                    cameraViewModel.isEditingTimerCapture = false
                    cameraViewModel.timerAmount = 0
                    cameraViewModel.viewTimerTopBar.toggle()
                }) {
                    Image(systemName: "timer")
                        .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
                }
                //타이머 2초
                Button(action: {
                    cameraViewModel.isEditingTimerCapture = true
                    cameraViewModel.timerAmount = 2
                    cameraViewModel.viewTimerTopBar.toggle()
                }) {
                    ZStack(alignment: .bottomTrailing)
                    {
                        Image(systemName: "timer")
                            .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
                        Text("2")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        
                    }
                }
                
                // 타이머 3초
                Button(action: {
                    cameraViewModel.isEditingTimerCapture = true
                    cameraViewModel.timerAmount = 3
                    cameraViewModel.viewTimerTopBar.toggle()
                }) {
                    ZStack(alignment: .bottomTrailing)
                    {
                        Image(systemName: cameraViewModel.isFlashOn ?
                              "timer.fill" : "timer")
                        .foregroundColor(cameraViewModel.isFlashOn ? .yellow : .white)
                        Text("3")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        
                    }
                }
                // 타이머 5초
                Button(action: {
                    cameraViewModel.isEditingTimerCapture = true
                    cameraViewModel.timerAmount = 5
                    cameraViewModel.viewTimerTopBar.toggle()
                }) {
                    ZStack(alignment: .bottomTrailing)
                    {
                        Image(systemName: cameraViewModel.isSilentModeOn ?
                              "timer.fill" : "timer")
                        .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
                        Text("5")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        
                    }
                }
                
                // 타이머 10초
                Button(action: {
                    cameraViewModel.isEditingTimerCapture = true
                    cameraViewModel.timerAmount = 10
                    cameraViewModel.viewTimerTopBar.toggle()
                }) {
                    ZStack(alignment: .bottomTrailing)
                    {
                        Image(systemName: cameraViewModel.isFlashOn ?
                              "timer.fill" : "timer")
                        .foregroundColor(cameraViewModel.isFlashOn ? .yellow : .white)
                        Text("10")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        
                    }
                }
                Spacer()
            }.font(.system(size:40)).background(Color.black)
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
