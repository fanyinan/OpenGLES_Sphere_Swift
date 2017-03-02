//
//  OpenGL+Extension.swift
//  OpenGLES_Sphere
//
//  Created by 范祎楠 on 16/7/31.
//  Copyright © 2016年 范祎楠. All rights reserved.
//

import GLKit

extension Array {
  
  var size: GLsizeiptr {
    return count * MemoryLayout<Element>.size
  }
}

extension GLKMatrix4 {
  
  var matrix: [Float] {
    return (0..<16).map({self[$0]})
  }
}
