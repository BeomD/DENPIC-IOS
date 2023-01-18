import SwiftUI
import AVFoundation

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct Line2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}

struct CameraView: View {
    @EnvironmentObject var webViewModel : WebViewModel
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel
    @State private var dragAmount: CGPoint?
    
    let date = Date()
    @State var timeRemaining : Int = 100
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
                    Text(convertSecondsToTime(timeInSeconds:timeRemaining))
                        .font(.system(size: 50))
                        .onReceive(timer) { _ in
                            timeRemaining -= 1
                        }
                }
                
                Line()
                  .stroke(style: StrokeStyle(lineWidth: 5, dash: [5]))
                  .frame(height: 5)
                  .foregroundColor(Color.yellow)
                Line2()
                  .stroke(style: StrokeStyle(lineWidth: 5, dash: [5]))
                  .frame(width: 5)
                  .foregroundColor(Color.yellow)
                
                VStack(alignment: .leading) {
                    CameraTopBar()
                    
                    Spacer()

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
                Button(action: {cameraViewModel.capturePhoto()}) {
                    Circle()
                        .stroke(lineWidth: 5)
                        .frame(width: 75, height: 75)
                        .padding()                 // Use .none animation for glue effect
                }.onLongPressGesture(perform: {print("길게 누르기!!")}).position(CGPoint(x: gp.size.width / 2, y: gp.size.height))
                // 이동하는 사진찍기 버튼
                Button(action: {cameraViewModel.capturePhoto()}) {
                    Circle()
                        .stroke(lineWidth: 5)
                        .frame(width: 75, height: 75)
                        .padding()                 // Use .none animation for glue effect
                }
                .animation(.default, value: dragAmount)
                .position(self.dragAmount ?? CGPoint(x: gp.size.width / 2, y: gp.size.height))
                .highPriorityGesture(  // << to do no action on drag !!
                    DragGesture()
                        .onChanged { self.dragAmount = $0.location})
                
            }
        }//ZStack
        .frame(maxWidth: .infinity, maxHeight: .infinity) // full space
            .fullScreenCover(isPresented: $cameraViewModel.showPreview) {
                Image(uiImage: cameraViewModel.recentImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height)
                    .onTapGesture {
                        cameraViewModel.showPreview = false
                    }
            }
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

