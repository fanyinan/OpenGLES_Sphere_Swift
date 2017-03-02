//
//  Model.swift
//  OpenGLES_Sphere
//
//  Created by 范祎楠 on 16/7/31.
//  Copyright © 2016年 范祎楠. All rights reserved.
//

import GLKit

class Model {

  var vertice: [Vertex]
  var indice: [GLuint]
  var baseEffect: BaseEffect
  
  var vertexBuffer: GLuint = GLuint()
  var indexBuffer: GLuint = GLuint()
  var vertexArray: GLuint = GLuint()
  
  var translate: GLKVector3 = GLKVector3(v: (0 ,0, 0))
  var rotationX: Float = 0
  var rotationY: Float = 0
  var rotationZ: Float = 0
  var scale: Float = 1
  
  init(vertice: [Vertex], indice: [GLuint], baseEffect: BaseEffect) {
    
    self.vertice = vertice
    self.indice = indice
    self.baseEffect = baseEffect
    
    setVertexBuffer()
  }
  
  func render(withParentModelMatrix matrix: GLKMatrix4) {
    
    let matrix = GLKMatrix4Multiply(matrix, modelMatrix())
    baseEffect.modelViewMatrix = matrix
    
    baseEffect.prepare()
    
    glBindVertexArray(vertexArray)
    glDrawArrays(GLenum(GL_TRIANGLES), 0, GLsizei(vertice.count))
    glBindVertexArray(0)
  }
  
  func setVertexBuffer() {
    
    glGenBuffers(1, &vertexBuffer)
    glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
    glBufferData(GLenum(GL_ARRAY_BUFFER), vertice.size, &vertice, GLenum(GL_STATIC_DRAW))
    
//    glGenBuffers(1, &indexBuffer)
//    glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
//    glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), indice.size, &indice, GLenum(GL_STATIC_DRAW))
//    
    glGenVertexArrays(1, &vertexArray)
    glBindVertexArray(vertexArray)
    
    glEnableVertexAttribArray(baseEffect.position)
    glEnableVertexAttribArray(baseEffect.color)
    glEnableVertexAttribArray(baseEffect.normal)
    
    glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
//    glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
    
    glVertexAttribPointer(baseEffect.position, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Vertex>.size), nil)
    glVertexAttribPointer(baseEffect.color, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Vertex>.size), BUFFER_OFFSEET(3 * MemoryLayout<GLfloat>.size))
    glVertexAttribPointer(baseEffect.normal, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Vertex>.size), BUFFER_OFFSEET(7 * MemoryLayout<GLfloat>.size))
    
    glBindVertexArray(0)
    glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
    glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
    
    
  }
  
  func BUFFER_OFFSEET(_ n: Int) -> UnsafeRawPointer {
    
    return UnsafeRawPointer(bitPattern: n)!
    
  }
  
  func modelMatrix() -> GLKMatrix4 {
    
    var matrix = GLKMatrix4Identity
    matrix = GLKMatrix4Translate(matrix, translate.x, translate.y, translate.z)
    matrix = GLKMatrix4RotateX(matrix, rotationX)
    matrix = GLKMatrix4RotateY(matrix, rotationY)
    matrix = GLKMatrix4RotateZ(matrix, rotationZ)
    matrix = GLKMatrix4Scale(matrix, scale, scale, scale)
    
    return matrix
  }
}
