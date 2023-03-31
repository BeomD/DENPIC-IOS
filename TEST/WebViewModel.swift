//
//  WebViewModel.swift
//  SwiftUI_Webview_tutorial
//
//  Created by Jeff Jeong on 2021/09/11.
//  Copyright © 2021 Tuentuenna. All rights reserved.
//

import Foundation
import Combine


class WebViewModel: ObservableObject {
    // iOS -> JS 함수 호출
    @Published var nativeToJsEvent = PassthroughSubject<String, Never>()
    //@Published var urlToLoad : String = "https://denpic-prototype.web.app/signInMobile"
    @Published var urlToLoad : String = "https://denpic-prototype.web.app/captureMobile"

    // 로딩 여부 이벤트
    @Published var shouldShowIndicator = PassthroughSubject<Bool, Never>()

}
