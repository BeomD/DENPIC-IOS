import SwiftUI
import AVFoundation
import Combine

class CameraViewModel: ObservableObject {
    private let model: Camera
    private let session: AVCaptureSession
    private var subscriptions = Set<AnyCancellable>()
    private var isCameraBusy = false
    
    let cameraPreview: AnyView
    let hapticImpact = UIImpactFeedbackGenerator()
    
    var currentZoomFactor: CGFloat = 1.0
    var lastScale: CGFloat = 1.0
    
    @Published var showPreview = false
    @Published var shutterEffect = false
    @Published var recentImage: UIImage?
    @Published var isFlashOn = false
    @Published var isSilentModeOn = false
    @Published var timerCaptureOn = false
    @Published var drawLine = false
    @Published var viewTimerTopBar = false
    @Published var viewFlashTopBar = false
    @Published var isEditDrawLineOn = false
    @Published var isEditingTimerCapture = false
    @Published var isEditingFlash = false
    @Published var timerAmount = 0
    @Published var horizentalX = CGPoint(x: CGRect().width, y: 0)
    @Published var verticalY =  CGPoint(x: 0, y: CGRect().height)
    @Published var dragAmount: CGPoint?
    @Published var essentialCaptureImage: [UIImage] = []
    @Published var etcCaptureImage: [UIImage] = []
    @Published var capturePositionImage: [Image] = [                Image("essential_1"),Image("essential_2"),Image("essential_3"),Image("essential_4"),Image("essential_5"),Image("etc"),Image("etc"),Image("etc"),Image("etc"),Image("etc"),Image("etc"),Image("etc"),Image("etc"),Image("etc"),Image("etc")
]
    @Published var capturePositionString: [String] = ["전치","왼쪽교합면","오른쪽교합면","상악","하악","기타구내사진","기타구내사진","기타구내사진","기타구내사진","기타구내사진","기타구내사진","기타구내사진","기타구내사진","기타구내사진","기타구내사진"]
    @Published var capturePositionIndex = 0
    @Published var maxCapture = 6
    @Published var photoData:[PhotoData] = []

    // 초기 세팅
    func configure() {
        model.requestAndCheckPermissions()
        model.setUpCamera()
    }
    
    // 플래시 온오프
    func switchFlash() {
        isFlashOn.toggle()
        model.flashMode = isFlashOn == true ? .on : .off
    }
    
    // 무음모드 온오프
    func switchSilent() {
        isSilentModeOn.toggle()
        model.isSilentModeOn = isSilentModeOn
    }
    
    // 사진 촬영
    func timerCapturePhoto() {
        let timerTime = timerAmount
        
        switch(timerTime)
        {
        case 0 :
            DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                self.timerCaptureOn.toggle()
                self.capturePhoto()
            })
        case 2 :
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.timerCaptureOn.toggle()
                self.capturePhoto()
            })
        case 3 :
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.timerCaptureOn.toggle()
                self.capturePhoto()
            })
        case 5 :
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                self.timerCaptureOn.toggle()
                self.capturePhoto()
            })
        case 10 :
            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                self.timerCaptureOn.toggle()
                self.capturePhoto()
            })
            
        default:
            self.timerCaptureOn.toggle()
        }
    }
    
    // 사진 촬영
    func capturePhoto() {
        if isCameraBusy == false {
            hapticImpact.impactOccurred()
            withAnimation(.easeInOut(duration: 0.1)) {
                shutterEffect = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    self.shutterEffect = false
                }
            }
            
            model.capturePhoto()
            print("[CameraViewModel]: Photo captured!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showPreview.toggle()
            }
        } else {
            print("[CameraViewModel]: Camera's busy.")
        }
    }
    
    func zoom(factor: CGFloat) {
        let delta = factor / lastScale
        lastScale = factor
        
        let newScale = min(max(currentZoomFactor * delta, 1), 5)
        model.zoom(newScale)
        currentZoomFactor = newScale
    }
    
    func zoomInitialize() {
        lastScale = 1.0
    }
    
    // 전후면 카메라 스위칭
    func changeCamera() {
        model.changeCamera()
        print("[CameraViewModel]: Camera changed!")
    }
    
    init() {
        model = Camera()
        session = model.session
        cameraPreview = AnyView(CameraPreviewView(session: session))
        
        model.$recentImage.sink { [weak self] (photo) in
            guard let pic = photo else { return }
            self?.recentImage = pic
        }
        .store(in: &self.subscriptions)
        
        model.$isCameraBusy.sink { [weak self] (result) in
            self?.isCameraBusy = result
        }
        .store(in: &self.subscriptions)
    }
}
