//
//  CanvasMechanicsInitializer.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 26.11.22.
//

import Foundation

struct CanvasMechanicsInitializer {
    static func createDefault() -> CanvasMechanics {
        let alignmentModule = VectorAlignmentModule()
        let intersectionModule = VectorIntersectionModule()
        let cameraMovingModule = CameraMovingModule()
        let vectorMovingModule = VectorMovingModule()
        
        return CanvasMechanics(
            alignmentModule: alignmentModule,
            intersectionModule: intersectionModule,
            cameraMovingModule: cameraMovingModule,
            vectorMovingModule: vectorMovingModule,
            canvasManager: CanvasManager.shared
        )
    }
}
