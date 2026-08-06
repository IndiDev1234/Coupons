//
//  DocumentCameraRepresentable.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import SwiftUI
import VisionKit
import UIKit

struct DocumentCameraRepresentable: UIViewControllerRepresentable {

    // MARK: - Callbacks

    let onImageCaptured: (UIImage) -> Void

    let onCancel: () -> Void

    let onError: (Error) -> Void

    // MARK: - UIViewControllerRepresentable

    func makeCoordinator() -> DocumentCameraCoordinator {

        DocumentCameraCoordinator(
            onImageCaptured: onImageCaptured,
            onCancel: onCancel,
            onError: onError
        )
    }

    func makeUIViewController(
        context: Context
    ) -> VNDocumentCameraViewController {

        let controller = VNDocumentCameraViewController()

        controller.delegate = context.coordinator

        return controller
    }

    func updateUIViewController(
        _ uiViewController: VNDocumentCameraViewController,
        context: Context
    ) {

    }
}
