//
//  SplashView.swift
//  megabox
//
//  Created by 황민지 on 9/18/25.
//

import SwiftUI

/// 스플래시 화면 구현
struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color.white
            Image(.meboxLogo1)
        }
    }
}

#Preview {
    SplashView()
}
