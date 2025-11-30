//
//  SceneDelegate.swift
//  megabox
//
//  Created by 황민지 on 11/13/25.
//

//
//  SceneDelegate.swift
//  megabox
//

import UIKit
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }

        print("SceneDelegate URL 들어옴:", url.absoluteString)

        // 카카오톡 로그인 OR 카카오 계정 로그인 모두 처리
        if (AuthApi.isKakaoTalkLoginUrl(url) || url.absoluteString.contains("kakao")) {
            print("handleOpenUrl 실행")
            _ = AuthController.handleOpenUrl(url: url)
        } else {
            print("카카오 URL 아님:", url)
        }
    }
}
