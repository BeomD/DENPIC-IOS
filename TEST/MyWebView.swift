

import SwiftUI
import WebKit
import Combine

// uikit 의 uiview 를 사용할수 있도록 한다.
// UIViewControllerRepresentable

struct MyWebView: UIViewRepresentable {
   
    @EnvironmentObject var appViewModel : AppViewModel
    @EnvironmentObject var webViewModel: WebViewModel
    @EnvironmentObject var cameraViewModel : CameraViewModel

    // 리프레시 컨트롤 헬퍼 클래스 만들기
    let refreshHelper = MyWebViewRefreshConrolHelper()
    @State var backPressed = false
    // 코디네이터 만들기
    func makeCoordinator() -> MyWebView.Coordinator {
        return MyWebView.Coordinator(self)
    }
   
    // ui view 만들기
    func makeUIView(context: Context) -> WKWebView{
        WKWebsiteDataStore.default().removeData(ofTypes: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache], modifiedSince: Date(timeIntervalSince1970: 0), completionHandler:{ })
        //웹뷰 캐시삭제
        let myRefreshControl = UIRefreshControl()
        let webView = WKWebView(frame: .zero, configuration: createWKWebConfig())
        // unwrapping
        guard let url = URL(string: webViewModel.urlToLoad) else {
            return WKWebView()
        }
            myRefreshControl.tintColor = UIColor.blue
            myRefreshControl.addTarget(refreshHelper, action: #selector(MyWebViewRefreshConrolHelper.didRefresh), for: .valueChanged)
            refreshHelper.webViewModel = webViewModel
            refreshHelper.refreshControl = myRefreshControl

            webView.uiDelegate = context.coordinator
            // wkwebview 의 델리겟 연결을 위한 코디네이터 설정
            webView.allowsBackForwardNavigationGestures = true // 가로 스와이프 뒤로가기 설정
            // 리프레시 컨트롤을 달아준다.
            webView.scrollView.refreshControl = myRefreshControl
            webView.scrollView.bounces = true // 바운싱 여부 설정
            // 웹뷰를 로드한다.
            webView.load(URLRequest(url: url))
        return webView
    }
    
    // 업데이트 ui view
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<MyWebView>) {
       // print("UI 업데이트")
            uiView.load(URLRequest(url : URL(string: webViewModel.urlToLoad)!))
    }
   
    func createWKWebConfig() -> WKWebViewConfiguration {
        let wkWebConfig = WKWebViewConfiguration()
        let preferences = WKPreferences()
        let userContentController = WKUserContentController()
        
        // 웹뷰 설정
        preferences.javaScriptCanOpenWindowsAutomatically = true
        //preferences.javaScriptEnabled = true
        // 웹뷰 유저 컨트롤러
        userContentController.add(self.makeCoordinator(), name: "signIn")
        userContentController.add(self.makeCoordinator(), name: "navigate")
        userContentController.add(self.makeCoordinator(), name: "captureStart")
        wkWebConfig.userContentController = userContentController
        wkWebConfig.preferences = preferences
        
        return wkWebConfig
    }
    
    class Coordinator: NSObject {
        
        var myWebView : MyWebView // SwiftUi View
        var subscriptions = Set<AnyCancellable>()
            init(_ myWebView: MyWebView) {
                    self.myWebView = myWebView
            }
    }
    
}

//MARK: - UIDelegate 관련
extension MyWebView.Coordinator : WKUIDelegate {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            completionHandler()
    }
    
}

//MARK: - UIDelegate 관련
extension MyWebView.Coordinator : WKScriptMessageHandler {
    
    // 웹뷰 js 에서 ios 네이티브를 호출하는 메소드 들이 이쪽을 탄다
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        DispatchQueue.main.async {
            if message.name == "signIn" {
                self.myWebView.webViewModel.urlToLoad = "https://denpic-prototype.web.app/signInMobile"
                    self.myWebView.appViewModel.signInToken(token: "\(message.body)")
            }
            else if message.name == "navigate" {
                if "\(message.body)" == "signIn"
                {
                    self.myWebView.webViewModel.urlToLoad="https://denpic-prototype.web.app/signInMobile"
                    self.myWebView.backPressed = true
                }
                else if "\(message.body)" == "signUp"
                {
                        self.myWebView.webViewModel.urlToLoad="https://denpic-prototype.web.app/signUpMobile"
                        //self.myWebView.appViewModel.viewSelector.append("default")
                }
                
                else if "\(message.body)" == "findPassword"
                {
                        self.myWebView.webViewModel.urlToLoad="https://denpic-prototype.web.app/passwordResetMobile"
                        //self.myWebView.appViewModel.viewSelector.append("default")
                }
            }
            else if message.name == "captureStart"
            {
                print("기타 구내사진 수 : \(message.body)")
            }
        }
    }
}
