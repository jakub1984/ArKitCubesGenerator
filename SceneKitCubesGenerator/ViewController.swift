//
//  ViewController.swift
//  SceneKitCubesGenerator
//
//  Created by Jakub Perich on 06/01/2019.
//  Copyright © 2019 Jakub Perich. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var maxHeight : CGFloat = 0.6
    var minHeight : CGFloat = 0.3
    var maxDistance : CGFloat = 0
    var minDistance : CGFloat = -3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
    }
    
    func getRandomVector() -> SCNVector3 {
        return SCNVector3(getRandomDistance(),
                          getRandomDistance(),
                          getRandomDistance())
    }
    
    func getRandomSize() -> CGFloat {
        return CGFloat.random(in: minHeight ... maxHeight)
    }
    
    func getRandomDistance() -> CGFloat {
        return CGFloat.random(in: minDistance ... maxDistance)
    }
    
    func getRandomColor() -> UIColor {
        return UIColor.init(red: CGFloat.random(in: 0 ... 1),
                            green: CGFloat.random(in: 0...1),
                            blue: CGFloat.random(in: 0...1),
                            alpha: CGFloat.random(in: 0.5...1))
    }
    
    func generateRandomCube() {
        let cubeSize = getRandomSize()
        let cube = SCNBox(width: cubeSize, height: cubeSize, length: cubeSize, chamferRadius: 0.03)

//        Longer definition of materials
//        let material = SCNMaterial()
//        material.diffuse.contents = getRandomColor()
//        cube.materials = [material]
//
//        Shorter for only one material:
        cube.materials.first?.diffuse.contents = getRandomColor()
        
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = getRandomVector()
        let rotateAction = SCNAction.rotateBy(x: CGFloat.random(in: 0 ... 2) * .pi,
                                              y: CGFloat.random(in: 0 ... 2) * .pi,
                                              z: 0,
                                              duration: 3)
        let repeateRotateAction = SCNAction.repeatForever(rotateAction)
        cubeNode.runAction(repeateRotateAction)
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    
    
    @IBAction func addCubeButtonClicked(_ sender: Any) {
        generateRandomCube()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    
    }
}
