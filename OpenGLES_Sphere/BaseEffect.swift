//
//  BaseEffect.swift
//  OpenGLES_Sphere
//
//  Created by 范祎楠 on 16/7/31.
//  Copyright © 2016年 范祎楠. All rights reserved.
//

import GLKit

class BaseEffect {

  var vertexShaderName: String
  var fragmentShaderName: String
  
  private var programHandle: GLuint!
  private var projectionMatrixUniform: Int32!
  private var modelViewMatrixUniform:Int32!
  private var lightColorUniform: Int32!
  private var lightAmbientIntensityUniform: Int32!
  private var lightDirectionUniform: Int32!
  private var lightDiffuseIntensityUniform: Int32!
  private var lightSpecularIntensityUniform: Int32!
  private var lightSpecularShininessUniform: Int32!
  
  private(set) var position: GLuint!
  private(set) var color: GLuint!
  private(set) var normal: GLuint!
  
  var projectionMatrix: GLKMatrix4!
  var modelViewMatrix: GLKMatrix4!
  
  init(vertexShaderName: String, fragmentShaderName: String) {
  
    self.vertexShaderName = vertexShaderName
    self.fragmentShaderName = fragmentShaderName
    
    compileShaders()
  }
  
  func prepare() {
  
    glUseProgram(programHandle)
    glUniformMatrix4fv(modelViewMatrixUniform, 1, GLboolean(GL_FALSE), modelViewMatrix.matrix)
    glUniformMatrix4fv(projectionMatrixUniform, 1, GLboolean(GL_FALSE), projectionMatrix.matrix)
    
    glUniform3f(lightColorUniform, 1, 1, 1)
    glUniform1f(lightAmbientIntensityUniform, 0.1)
    
    glUniform3f(lightDirectionUniform, -0.5, 0, -1)
    glUniform1f(lightDiffuseIntensityUniform, 0.8)
    
    glUniform1f(lightSpecularIntensityUniform, 5)
    glUniform1f(lightSpecularShininessUniform, 3)
  }
  
  func compileShader(shaderName: String, shaderType: GLenum) -> GLuint {
    
    let shaderPath = NSBundle.mainBundle().pathForResource(shaderName, ofType: "glsl")!
    let shaderStr = try! NSString(contentsOfFile: shaderPath, encoding: NSUTF8StringEncoding)
    var shaderUTF8String = shaderStr.UTF8String
    var shaderStrLength = GLint(shaderStr.length)
    
    let shaderHandle = glCreateShader(shaderType)
    glShaderSource(shaderHandle, 1, &shaderUTF8String, &shaderStrLength)
    glCompileShader(shaderHandle)
    
    var compileSuccess: GLint = GLint()
    
    glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), &compileSuccess)
    
    if compileSuccess == GL_FALSE {
      
      var logLength: GLint = GLint()
      glGetShaderiv(shaderHandle, GLenum(GL_INFO_LOG_LENGTH), &logLength)
      
      var log = [CChar](count: Int(logLength), repeatedValue: 0)
      
      glGetShaderInfoLog(shaderHandle, logLength, &logLength, &log)
      
      print("compile shader error: \(String(UTF8String: log))")
    }
    
    return shaderHandle
  }
  
  func compileShaders() {
    
    let vertexShader = compileShader(vertexShaderName, shaderType: GLenum(GL_VERTEX_SHADER))
    let fragmentShader = compileShader(fragmentShaderName, shaderType: GLenum(GL_FRAGMENT_SHADER))
    
    programHandle = glCreateProgram()
    glAttachShader(programHandle, vertexShader)
    glAttachShader(programHandle, fragmentShader)
    glLinkProgram(programHandle)
    
    position = GLuint(glGetAttribLocation(programHandle, "Position"))
    color = GLuint(glGetAttribLocation(programHandle, "Color"))
    normal = GLuint(glGetAttribLocation(programHandle, "Normal"))
    
    glEnableVertexAttribArray(position)
    glEnableVertexAttribArray(color)
    
    projectionMatrixUniform = glGetUniformLocation(programHandle, "ProjectionMatrix")
    modelViewMatrixUniform = glGetUniformLocation(programHandle, "ModelViewMatrix")
    lightColorUniform = glGetUniformLocation(programHandle, "light.Color")
    lightAmbientIntensityUniform = glGetUniformLocation(programHandle, "light.AmbientIntensity")
    lightDirectionUniform = glGetUniformLocation(programHandle, "light.Direction")
    lightDiffuseIntensityUniform = glGetUniformLocation(programHandle, "light.DiffuseIntensity")
    lightSpecularIntensityUniform = glGetUniformLocation(programHandle, "light.SpecularIntensity")
    lightSpecularShininessUniform = glGetUniformLocation(programHandle, "light.Shininess")
    
    var linkSuccess: GLint = GLint()
    glGetProgramiv(programHandle, GLenum(GL_LINK_STATUS), &linkSuccess)
    
    if linkSuccess == GL_FALSE {
      
      var logLength: GLsizei = GLsizei()
      glGetProgramiv(programHandle, GLenum(GL_INFO_LOG_LENGTH), &logLength)
      var logInfo = [CChar](count: Int(logLength), repeatedValue: 0)
      glGetProgramInfoLog(programHandle, logLength, &logLength, &logInfo)
      
      print("link error: \(String(UTF8String: logInfo))")
    }
    
  }
}
