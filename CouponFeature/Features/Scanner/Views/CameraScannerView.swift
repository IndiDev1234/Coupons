//
//  CameraScannerView.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import SwiftUI
import UIKit

struct CameraScannerView: View {

    let onImageCaptured: (UIImage) -> Void
    let onCancel: () -> Void

    var body: some View {

        DocumentCameraRepresentable(

            onImageCaptured: { image in

                print("➡️ CameraScannerView received image")

                onImageCaptured(image)
            },

            onCancel: {

                print("❌ CameraScannerView cancelled")

                onCancel()
            },

            onError: { error in

                print("❌ CameraScannerView error:", error.localizedDescription)

                onCancel()
            }
        )
        .ignoresSafeArea()
    }
}

#Preview {
    Text("Requires a real device.")
}
