import SwiftUI
import AVFoundation

struct horizentalLine: Shape {
    var horizentalX : CGPoint
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: horizentalX.x, y: horizentalX.y))
        path.addLine(to: CGPoint(x: rect.width, y: horizentalX.y))
        return path
    }
}

struct verticalLine: Shape {
    var verticalY : CGPoint
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: verticalY.x, y: verticalY.y))
        path.addLine(to: CGPoint(x: verticalY.x, y: rect.height))
        return path
    }
}

struct CameraView: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel

    let date = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { gp in // just to center initial position
            ZStack(alignment: Alignment.center) {
                cameraViewModel.cameraPreview.ignoresSafeArea()
                    .onAppear {
                        cameraViewModel.configure()
                    }
                    .gesture(MagnificationGesture()
                        .onChanged { val in
                            cameraViewModel.zoom(factor: val)
                        }
                        .onEnded { _ in
                            cameraViewModel.zoomInitialize()
                        }
                    )
                
                if cameraViewModel.timerCaptureOn
                {
                    //타이머 촬영 시간보이기
                    //Text(convertSecondsToTime(timeInSeconds:cameraViewModel.timerAmount))
                    Text("\(cameraViewModel.timerAmount)")
                        .font(.system(size: 200))
                        .onReceive(timer) { _ in
                            cameraViewModel.timerAmount -= 1
                            if cameraViewModel.timerAmount <= 0
                            {
                                cameraViewModel.capturePhoto()
                                cameraViewModel.timerCaptureOn.toggle()
                            }
                        }
                }

                if cameraViewModel.drawLine
                {
                    horizentalLine(horizentalX: cameraViewModel.horizentalX)
                        //.stroke(style: StrokeStyle(lineWidth: 5, dash: [5]))
                        .stroke(style: StrokeStyle(lineWidth: 5))
                        .frame(height: 5)
                        .foregroundColor(Color.yellow)
                    verticalLine(verticalY: cameraViewModel.verticalY)
                        //.stroke(style: StrokeStyle(lineWidth: 5, dash: [5]))
                        .stroke(style: StrokeStyle(lineWidth: 5))
                        .frame(width: 5)
                        .foregroundColor(Color.yellow)
                }
                
                if cameraViewModel.isEditDrawLineOn
                {
                    VStack{
                        Spacer()
                        Button(action: {cameraViewModel.horizentalX.y-=1}){
                            Image(systemName:"arrowtriangle.up")
                                .resizable()
                                .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
                                .padding(0)
                                .frame(width: 60.0, height: 60.0)
                        }
                        HStack
                        {
                            Button(action: {cameraViewModel.verticalY.x-=1}){
                                Image(systemName: "arrowtriangle.left")
                                    .resizable()
                                    .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
                                    .padding(0)
                                    .frame(width: 60.0, height: 60.0)
                            }
                            Spacer().frame(width: 60.0, height: 60.0)
                            Button(action: {cameraViewModel.verticalY.x+=1}){
                                Image(systemName: "arrowtriangle.right")
                                    .resizable()
                                    .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
                                    .padding(0)
                                    .frame(width: 60.0, height: 60.0)
                                
                            }
                        }
                        Button(action: {cameraViewModel.horizentalX.y+=1}){
                            Image(systemName: "arrowtriangle.down")
                                .resizable()
                                .foregroundColor(cameraViewModel.isSilentModeOn ? .yellow : .white)
                                .padding(0)
                                .frame(width: 60.0, height: 60.0)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    CameraTopBar()
                    HStack(alignment: .center){
                        Spacer()
                        //Text(cameraViewModel.capturePositionString[cameraViewModel.capturePositionIndex]).font(.system(size: 75))
                        cameraViewModel.capturePositionImage[cameraViewModel.capturePositionIndex].resizable()
                            .frame(width: 80,height: 80)
                    }
                    Spacer()
                    /*
                        // 찍은 사진 미리보기
                        Button(action: {cameraViewModel.showPreview = true}) {
                            if let previewImage = cameraViewModel.recentImage {
                                Image(uiImage: previewImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .aspectRatio(1, contentMode: .fit)
                            } else {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 3)
                                    .foregroundColor(.white)
                                    .frame(width: 75, height: 75)
                            }
                        }.padding(0)
                        */
                            //Spacer()
                            //.animation(.default, value: dragAmount)
                            //.position(self.dragAmount ?? CGPoint(x: gp.size.width / 2, y: gp.size.height / 2))
                            //.highPriorityGesture(  // << to do no action on drag !!
                            //    DragGesture()
                            //        .onChanged { self.dragAmount = $0.location})
                        
                       // Spacer()
                        
                        // 전후면 카메라 교체
                        //Button(action: {viewModel.changeCamera()}) {
                        //    Image(systemName: "arrow.triangle.2.circlepath.camera")
                        //        .resizable()
                        //        .scaledToFit()
                        //        .frame(width: 50, height: 50)
                }
                .foregroundColor(.none)

                // 사진찍기 버튼
                //Button(action: {if cameraViewModel.timerCaptureOn{cameraViewModel.timerCapturePhoto()}
                //    else{cameraViewModel.capturePhoto()}}) {
                if !cameraViewModel.isEditDrawLineOn
                {
                    Button(action: {if cameraViewModel.isEditingTimerCapture {cameraViewModel.timerCaptureOn.toggle()} else{cameraViewModel.capturePhoto()}})
                    {
                        Circle()
                            .frame(width: 75, height: 75)
                            .padding()
                            .foregroundColor(.white)                 // Use .none animation for glue effect
                    }.onLongPressGesture(perform: {print("길게 누르기!!")}).position(CGPoint(x: gp.size.width / 2, y: gp.size.height))
                    // 이동하는 사진찍기 버튼
                    Button(action: {if cameraViewModel.isEditingTimerCapture {cameraViewModel.timerCaptureOn.toggle()
                    } else{cameraViewModel.capturePhoto()}})
                    {
                        Circle()
                            .frame(width: 75, height: 75)
                            .padding()
                            .foregroundColor(.white)
                    }
                    .animation(.default, value: cameraViewModel.dragAmount)
                    .position(cameraViewModel.dragAmount ?? CGPoint(x: gp.size.width / 2, y: gp.size.height))
                    .highPriorityGesture(  // << to do no action on drag !!
                        DragGesture()
                            .onChanged { cameraViewModel.dragAmount = $0.location})
                }
            }//VStack
        }//ZStack
        .fullScreenCover(isPresented: $cameraViewModel.showPreview)
        {
            HStack(){
                Button(action: {cameraViewModel.showPreview.toggle()}
                ) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .scaledToFit()
                        .padding(0)
                }.padding(.horizontal, 10)
                Spacer()
            }.font(.system(size:40)).background(Color.black)
            VStack{
                Image(uiImage: cameraViewModel.recentImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width*0.8,
                           height: UIScreen.main.bounds.height*0.8)
                    .padding(0)
                HStack{
                    Button(action: {cameraViewModel.showPreview.toggle()})
                    {
                    Text("재촬영하기")
                            .frame(width: 100, height: 75)
                            .padding()
                            .foregroundColor(.red)
                    }
             
                    if cameraViewModel.capturePositionIndex < (cameraViewModel.maxCapture - 1)
                    {
                        Button(action: {
                            if cameraViewModel.capturePositionIndex < 5{
                                cameraViewModel.essentialCaptureImage.append(cameraViewModel.recentImage ?? UIImage())
                                cameraViewModel.photoData.append(PhotoData(part: cameraViewModel.capturePositionString[cameraViewModel.capturePositionIndex], image: cameraViewModel.recentImage?.pngData()?.base64EncodedString() ?? "", timestamp:String(Date().timeIntervalSince1970)))
                            }
                            else{
                                    cameraViewModel.etcCaptureImage.append(cameraViewModel.recentImage ?? UIImage())
                                cameraViewModel.photoData.append(PhotoData(part: cameraViewModel.capturePositionString[cameraViewModel.capturePositionIndex], image: cameraViewModel.recentImage?.pngData()?.base64EncodedString() ?? "", timestamp:String(Date().timeIntervalSince1970)))
                            }
    
                            cameraViewModel.capturePositionIndex+=1
                            cameraViewModel.showPreview.toggle()
                        })
                        {
                        Text("다음부위로")
                                .frame(width: 100, height: 75)
                                .padding()
                                .foregroundColor(.red)
                        }
                    }
                    else
                    {
                        Button(action: {
                            cameraViewModel.etcCaptureImage.append(cameraViewModel.recentImage ?? UIImage())
                            cameraViewModel.photoData.append(PhotoData(part: cameraViewModel.capturePositionString[cameraViewModel.capturePositionIndex], image: cameraViewModel.recentImage?.pngData()?.base64EncodedString() ?? "", timestamp:String(Date().timeIntervalSince1970)))
                            cameraViewModel.showPreview.toggle()
                            appViewModel.viewSelector.append("gridPhotoView")
                            print("현재 캡쳐포지션 \(cameraViewModel.capturePositionIndex)")
                            for _ in (cameraViewModel.capturePositionIndex-4)..<10
                            {
                                cameraViewModel.etcCaptureImage.append(UIImage())
                            }
                            print("기타촬영갯수 \(cameraViewModel.etcCaptureImage.endIndex)")
                            print("포토데이타 : \(cameraViewModel.photoData.description)")
                        })
                        {
                        Text("촬영완료")
                                .frame(width: 100, height: 75)
                                .padding()
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.white)
            .statusBarHidden(true)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // full space
        .onAppear{}
        .opacity(cameraViewModel.shutterEffect ? 0 : 1)
}
    
    func convertSecondsToTime(timeInSeconds: Int) -> String {
        let hours = timeInSeconds / 3600
        let minutes = (timeInSeconds - hours*3600) / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i:%02i", hours,minutes,seconds)
    }
        
}


struct CameraPreviewView: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        
        view.videoPreviewLayer.session = session
        view.backgroundColor = .black
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        view.videoPreviewLayer.cornerRadius = 0
        view.videoPreviewLayer.connection?.videoOrientation = .portrait
        
        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
        
    }
}
