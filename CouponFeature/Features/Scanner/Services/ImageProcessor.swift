//
//  ImageProcessor.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//


import UIKit
import CoreImage

protocol ImageProcessorProtocol {

    func process(
        _ image: UIImage
    ) -> UIImage
}

final class ImageProcessor: ImageProcessorProtocol {

    private let context = CIContext()

    func process(
        _ image: UIImage
    ) -> UIImage {

        let normalized = normalizeOrientation(image)

        let contrasted = enhanceContrast(normalized)

        let resized = resizeIfNeeded(contrasted)

        return resized
    }
}

// MARK: - Private

private extension ImageProcessor {

    func normalizeOrientation(
        _ image: UIImage
    ) -> UIImage {

        guard image.imageOrientation != .up else {

            return image
        }

        UIGraphicsBeginImageContextWithOptions(
            image.size,
            false,
            image.scale
        )

        image.draw(in: CGRect(
            origin: .zero,
            size: image.size
        ))

        let normalized =
            UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return normalized ?? image
    }

    func enhanceContrast(
        _ image: UIImage
    ) -> UIImage {

        guard
            let ciImage = CIImage(image: image),
            let filter = CIFilter(
                name: "CIColorControls"
            )
        else {

            return image
        }

        filter.setValue(
            ciImage,
            forKey: kCIInputImageKey
        )

        filter.setValue(
            1.1,
            forKey: kCIInputContrastKey
        )

        filter.setValue(
            0,
            forKey: kCIInputSaturationKey
        )

        guard
            let output = filter.outputImage,
            let cgImage = context.createCGImage(
                output,
                from: output.extent
            )
        else {

            return image
        }

        return UIImage(
            cgImage: cgImage
        )
    }

    func resizeIfNeeded(
        _ image: UIImage
    ) -> UIImage {

        let maxDimension: CGFloat = 2200

        let width = image.size.width
        let height = image.size.height

        guard
            width > maxDimension ||
            height > maxDimension
        else {

            return image
        }

        let ratio = min(
            maxDimension / width,
            maxDimension / height
        )

        let newSize = CGSize(
            width: width * ratio,
            height: height * ratio
        )

        let renderer = UIGraphicsImageRenderer(
            size: newSize
        )

        return renderer.image { _ in

            image.draw(
                in: CGRect(
                    origin: .zero,
                    size: newSize
                )
            )
        }
    }
}
