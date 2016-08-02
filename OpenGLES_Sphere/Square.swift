//
//  Square.swift
//  OpenGLES_Sphere
//
//  Created by 范祎楠 on 16/7/31.
//  Copyright © 2016年 范祎楠. All rights reserved.
//

import UIKit

class Square: Model {

  let vertexList: [Vertex] = [
  
    Vertex(Position: (-1, 1, 0), Color: (1, 0, 0, 1)),
    Vertex(Position: (1, 1, 0), Color: (0, 1, 0, 1)),
    Vertex(Position: (-1, -1, 0), Color: (0, 0, 1, 1)),
    Vertex(Position: (1, -1, 0), Color: (0.5, 0.5, 0, 1)),
  ]
  
  let indexList: [GLuint] = [0, 2, 3, 0, 3, 1]
  
  init(baseEffect: BaseEffect) {
    super.init(vertice: vertexList, indice: indexList, baseEffect: baseEffect)
  }
  
}
