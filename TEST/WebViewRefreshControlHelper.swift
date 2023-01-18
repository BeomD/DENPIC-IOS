//
//  WebViewRefreshControlHelper.swift
//  SwiftUI_Webview_tutorial
//
//  Created by Jeff Jeong on 2021/09/12.
//  Copyright © 2021 Tuentuenna. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class MyWebViewRefreshConrolHelper {
    //스와이프 리프레시를 위한 클래스
    //MARK: Properties
    var refreshControl : UIRefreshControl?
    var webViewModel : WebViewModel?
    
    
    @objc func didRefresh(){
        print("MyWebViewRefreshConrolHelper - didRefresh() called")
        guard let refreshControl = refreshControl,
              let _ = webViewModel else {
            print("refreshControl, viewModel 가 없습니다.")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
            print("리프레시가 되었습니다.")
            refreshControl.endRefreshing()
        })
    }
    
}
