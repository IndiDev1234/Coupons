//
//  DocumentCameraCoordinator.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//
//
//  DocumentCameraCoordinator.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import UIKit
import VisionKit

final class DocumentCameraCoordinator: NSObject {

    private let onImageCaptured: (UIImage) -> Void
    private let onCancel: () -> Void
    private let onError: (Error) -> Void

    init(
        onImageCaptured: @escaping (UIImage) -> Void,
        onCancel: @escaping () -> Void,
        onError: @escaping (Error) -> Void
    ) {

        self.onImageCaptured = onImageCaptured
        self.onCancel = onCancel
        self.onError = onError
    }
}

// MARK: - VNDocumentCameraViewControllerDelegate

extension DocumentCameraCoordinator: VNDocumentCameraViewControllerDelegate {

    func documentCameraViewControllerDidCancel(
        _ controller: VNDocumentCameraViewController
    ) {

        print("❌ Camera Cancelled")

        // Don't dismiss here.
        onCancel()
    }

    func documentCameraViewController(
        _ controller: VNDocumentCameraViewController,
        didFailWithError error: Error
    ) {

        print("❌ Camera Error:", error.localizedDescription)

        // Don't dismiss here.
        onError(error)
    }

    func documentCameraViewController(
        _ controller: VNDocumentCameraViewController,
        didFinishWith scan: VNDocumentCameraScan
    ) {

        print("📷 VisionKit Finished")
        print("Pages:", scan.pageCount)

        guard scan.pageCount > 0 else {

            print("⚠️ No pages scanned")
            return
        }

        let image = scan.imageOfPage(at: 0)

        print("📸 Image Created")

        // Don't dismiss here.
        onImageCaptured(image)
    }
}
