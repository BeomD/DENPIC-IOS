//
//  GridPhotoView.swift
//  TEST
//
//  Created by BJ Man on 2023/01/26.
//

import SwiftUI

struct GridPhotoView: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel

    var body: some View {
        ScrollView() {
            VStack{
                GridEssentialPhotoView()
                GridEtcPhotoView()
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea(edges: .all)
    }
}

struct GridEssentialPhotoView: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel
    
    var body: some View {
        VStack{
           // Text("필수사진")
           //     .font(.system(size: 75))
            if !cameraViewModel.essentialCaptureImage.isEmpty
            {
                HStack{
                    Button(action: {}) {
                        if let item = cameraViewModel.essentialCaptureImage[0] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    Button(action: {}) {
                        if let item = cameraViewModel.essentialCaptureImage[1] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    Button(action: {}) {
                        if let item = cameraViewModel.essentialCaptureImage[2] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                HStack
                {
                    Button(action: {}) {
                        if let item = cameraViewModel.essentialCaptureImage[3] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    Button(action: {}) {
                        if let item = cameraViewModel.essentialCaptureImage[4] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
            }
        }
    }
}

struct GridEtcPhotoView: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel
    let btnColor = Color(UIColor(rgb: 0xFF7D84))

    var body: some View {
        VStack{
            // Text("기타사진")
            //    .font(.system(size: 75))
            if !cameraViewModel.etcCaptureImage.isEmpty
            {
                HStack{
                    Button(action: {}) {
                        if let item = cameraViewModel.etcCaptureImage[0] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 0))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    Button(action: {}) {
                        if let item = cameraViewModel.etcCaptureImage[1] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 0))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    Button(action: {}) {
                        if let item = cameraViewModel.etcCaptureImage[2] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 0))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                HStack{
                    Button(action: {}) {
                        if let item = cameraViewModel.etcCaptureImage[3] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 0))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    Button(action: {}) {
                        if let item = cameraViewModel.etcCaptureImage[4] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 0))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    Button(action: {}) {
                        if let item = cameraViewModel.etcCaptureImage[5] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 0))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                HStack{
                    Button(action: {}) {
                        if let item = cameraViewModel.etcCaptureImage[6] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 0))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    Button(action: {}) {
                        if let item = cameraViewModel.etcCaptureImage[7] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 0))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    Button(action: {}) {
                        if let item = cameraViewModel.etcCaptureImage[8] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 0))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                HStack{
                    Button(action: {}) {
                        if let item = cameraViewModel.etcCaptureImage[9] {
                            Image(uiImage: item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 0))
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                Button(action: {
                    cameraViewModel.capturePositionIndex = 0
                    appViewModel.viewSelector.append("camera")
                    //appViewModel.viewSelector.removeSubrange(0..<appViewModel.viewSelector.endIndex)
                    cameraViewModel.essentialCaptureImage.removeAll()
                    cameraViewModel.etcCaptureImage.removeAll()
                }) {
                    Text("PC 최근 촬영 리스트에 업로드하기").padding()
                }
                .padding(0)
                .foregroundColor(.white)
                .background(btnColor)
                .cornerRadius(10)
            }
        }
    }
}
