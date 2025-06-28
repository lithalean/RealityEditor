//
//  MathExtensions.swift
//  RealityEditor
//
//  Created by RealityEditor Assistant on 6/28/25.
//

import Foundation

// MARK: - Float Degree Helpers
extension Float {
    var degreesToRadians: Float {
        return self * .pi / 180
    }

    var radiansToDegrees: Float {
        return self * 180 / .pi
    }
}
