//
//  CouponAttachment.swift
//  CouponFeature
//
//  Created by Vansh Sharma on 06/08/26.
//

import Foundation
import SwiftData

@Model
final class CouponAttachment {

    @Attribute(.unique)
    var id: UUID

    /// Relative file path inside the app's storage
    var filePath: String

    /// Image / PDF / Screenshot / Receipt
    var type: AttachmentType

    /// Original filename if available
    var fileName: String?

    var createdAt: Date

    init(
        id: UUID = UUID(),
        filePath: String,
        type: AttachmentType,
        fileName: String? = nil,
        createdAt: Date = .now
    ) {
        self.id = id
        self.filePath = filePath
        self.type = type
        self.fileName = fileName
        self.createdAt = createdAt
    }
}
