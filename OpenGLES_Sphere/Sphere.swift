//
//  Sphere.swift
//  OpenGLES_Sphere
//
//  Created by 范祎楠 on 16/7/31.
//  Copyright © 2016年 范祎楠. All rights reserved.
//

import UIKit

class Sphere: Model {

  static var storeVertexList: [Vertex] = []
  static var vertexList: [Vertex] = []
  static var indexList: [GLuint] = []
  
  static let radian: Double = M_PI_2 / 10
  static let radius: Double = 1
  
  init(baseEffect: BaseEffect) {
    
    Sphere.createSphereData()
    Sphere.updateAllNormal()
    
    super.init(vertice: Sphere.vertexList, indice: Sphere.indexList, baseEffect: baseEffect)
    
  }
  
  class func createSphereData() {
    
    let row = Int(M_PI / radian)
    let col = Int(M_PI * 2 / radian)
    
    for i in 0..<row + 1 {
      
      let y = -cos(Double(i) * radian) * radius
      let radiuInCurrentCircle = sin(Double(i) * radian) * radius
      
      for j in 0..<col {
        
        let x = sin(Double(j) * radian) * radiuInCurrentCircle
        let z = cos(Double(j) * radian) * radiuInCurrentCircle
        
        storeVertexList += [Vertex(Position: (GLfloat(x), GLfloat(y), GLfloat(z)), Color: (1, 0, 0, 1), Normal: (0, 0, 0))]
        
      }
    }
    
    for i in 0..<row * col {
      
      vertexList += [storeVertexList[i]]
      vertexList += [storeVertexList[((i + 1) % col == 0 ? (i + 1 - col) : (i + 1))]]
      vertexList += [storeVertexList[i + col]]

      vertexList += [storeVertexList[i + col]]
      vertexList += [storeVertexList[((i + 1) % col == 0 ? (i + 1 - col) : (i + 1))]]
      vertexList += [storeVertexList[((i + 1) % col == 0 ? (i + col + 1 - col) : (i + col + 1))]]

    }
  }
  
  class func updateAllNormal() {
    
    let row = Int(M_PI / radian)
    let col = Int(M_PI * 2 / radian)
    
    for i in 0..<(row * col) * 2 {
      
      updateNormal(withIndex1: 3 * i + 0, index2: 3 * i + 1, index3: 3 * i + 2)
      
    }
  }
  
  class func updateNormal(withIndex1 index1: Int, index2: Int, index3: Int) {
    
    let point1 = vertexList[index1].Position
    let point2 = vertexList[index2].Position
    let point3 = vertexList[index3].Position
    
    let v: (x: GLfloat, y: GLfloat, z: GLfloat) = (point2.0 - point1.0, point2.1 - point1.1, point2.2 - point1.2)
    let w: (x: GLfloat, y: GLfloat, z: GLfloat) = (point3.0 - point1.0, point3.1 - point1.1, point3.2 - point1.2)
    
    let x = v.y * w.z - v.z * w.y
    let y = v.z * w.x - v.x * w.z
    let z = v.x * w.y - v.y * w.x
    
    let normal: (x: GLfloat, y: GLfloat, z: GLfloat) = (x, y, z)
    
    vertexList[index1].Normal = normal
    vertexList[index2].Normal = normal
    vertexList[index3].Normal = normal
    
//    let color: (GLfloat, GLfloat, GLfloat, GLfloat) = (GLfloat(arc4random_uniform(10)) / 10, GLfloat(arc4random_uniform(10)) / 10, GLfloat(arc4random_uniform(10)) / 10, 1)
//    
//    vertexList[index1].Color = color
//    vertexList[index2].Color = color
//    vertexList[index3].Color = color
    
  }
  
  func update(dt: NSTimeInterval) {
    
    rotationX = rotationX + Float(dt * M_PI / 8)
//    rotationY = rotationY + Float(dt * M_PI / 8)
    rotationZ = rotationZ + Float(dt * M_PI / 8)
    
  }
}
