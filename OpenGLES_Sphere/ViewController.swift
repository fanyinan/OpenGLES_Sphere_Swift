//
//  ViewController.swift
//  OpenGLES_Sphere
//
//  Created by 范祎楠 on 16/7/31.
//  Copyright © 2016年 范祎楠. All rights reserved.
//

import UIKit
import GLKit

class ViewController: GLKViewController {

  var baseEffect: BaseEffect!
  var sphere: Sphere!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupContext()
    setupScene()
    delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func glkView(view: GLKView, drawInRect rect: CGRect) {
    
    glClearColor(0, 0, 0, 1)
    glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
    glEnable(GLenum(GL_DEPTH_TEST))
    glEnable(GLenum(GL_CULL_FACE))
    
    let matrix4 = GLKMatrix4RotateX(GLKMatrix4MakeTranslation(0, 0, -3), 0)
    sphere.render(withParentModelMatrix: matrix4)
    
  }
  
  func setupContext() {
    
    let context = EAGLContext(API: .OpenGLES2)
    EAGLContext.setCurrentContext(context)
    
    let glkView = view as! GLKView
    glkView.context = context
    
    glkView.drawableDepthFormat = .Format16
  }

  func setupScene() {
    
    baseEffect = BaseEffect(vertexShaderName: "SimpleVertexShader", fragmentShaderName: "SimpleFragmentShader")
    baseEffect.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(90), Float(view.frame.width / view.frame.height), 1, 150)
    
    sphere = Sphere(baseEffect: baseEffect)
    
  }
}

extension ViewController: GLKViewControllerDelegate {
  
  func glkViewControllerUpdate(controller: GLKViewController) {
    
    sphere.update(timeSinceLastUpdate)
  }
}
