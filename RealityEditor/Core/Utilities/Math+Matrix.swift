//
//  Math+Matrix.swift
//  RealityEditor
//
//  Created by RealityEditor Assistant on 6/28/25.
//

import Foundation
import simd

// MARK: - Matrix Projection Helpers
extension float4x4 {
    init(quaternion q: simd_quatf) {
        self = matrix_float4x4(q)
    }
    init(perspectiveProjectionFov fovY: Float, aspectRatio: Float, nearZ: Float, farZ: Float) {
        let y = 1 / tan(fovY * 0.5)
        let x = y / aspectRatio
        let zRange = farZ - nearZ
        let z = -(farZ + nearZ) / zRange
        let wz = -2 * farZ * nearZ / zRange

        self.init(SIMD4<Float>( x,  0,  0,  0),
                  SIMD4<Float>( 0,  y,  0,  0),
                  SIMD4<Float>( 0,  0,  z, -1),
                  SIMD4<Float>( 0,  0, wz,  0))
    }

    init(orthographicProjectionLeft left: Float,
         right: Float,
         bottom: Float,
         top: Float,
         nearZ: Float,
         farZ: Float) {
        let ral = right + left
        let rsl = right - left
        let tab = top + bottom
        let tsb = top - bottom
        let fan = farZ + nearZ
        let fsn = farZ - nearZ

        self.init(SIMD4<Float>( 2 / rsl,     0,       0, 0),
                  SIMD4<Float>(     0, 2 / tsb,      0, 0),
                  SIMD4<Float>(     0,     0, -2 / fsn, 0),
                  SIMD4<Float>( -ral / rsl, -tab / tsb, -fan / fsn, 1))
    }

    init(translation t: SIMD3<Float>) {
        self = matrix_identity_float4x4
        columns.3 = SIMD4<Float>(t.x, t.y, t.z, 1)
    }

    init(scale s: SIMD3<Float>) {
        self = matrix_identity_float4x4
        columns.0.x = s.x
        columns.1.y = s.y
        columns.2.z = s.z
    }

    init(_ q: simd_quatf) {
        self = float4x4(quaternion: q)
    }
}
