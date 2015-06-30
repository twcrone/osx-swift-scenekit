import Foundation
import SceneKit
import QuartzCore
import SpriteKit


class GameScene : SCNScene {
    
    override init() {
        super.init()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 4)
        rootNode.addChildNode(cameraNode)
        
        let helloWorld = "Lexmark"
        var xPos = CGFloat(-3.0)
        let font = NSFont(name: "Menlo", size: 1.0)
        
        for character in helloWorld {
            
            let s = String(character)
            let geo = SCNText(string: s, extrusionDepth: 0.25)
            geo.font = font
            
            let mat     = SCNMaterial()
            let hue : Double = Double(rand()) / Double(RAND_MAX)
            mat.diffuse.contents = NSColor(calibratedHue: CGFloat(hue), saturation: 1.0, brightness: 1.0, alpha: 1.0)
            geo.materials = [mat]
            
            let node = SCNNode(geometry: geo)
            node.position = SCNVector3(x: xPos, y: 0.0, z: 0.0)
            rootNode.addChildNode(node)
            
            xPos += 0.66
        }
        
        
        addSphereNode()
        addFloorNode()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addSphereNode() {
        let collisionBox = SCNBox(width: 10.0, height: 10.0, length: 10.0,
            chamferRadius: 0)
        
        let sphereGeometry = SCNSphere(radius: 0.25)
        sphereGeometry.firstMaterial?.diffuse.contents = NSColor.purpleColor()
        
        let sphereNode = SCNNode(geometry: sphereGeometry)
        sphereNode.position = SCNVector3Make(0.0, 10.0, 0.0)
        sphereNode.physicsBody?.physicsShape = SCNPhysicsShape(geometry: collisionBox, options: nil)
        sphereNode.physicsBody = SCNPhysicsBody.dynamicBody()
        sphereNode.physicsBody?.mass = 50
        //sphereNode.physicsBody?.angularVelocityFactor = SCNVector3Zero
//        sphereNode.physicsBody?.velocity = SCNVector3(x: 0.0, y: 0.0, z: 25.0)
        sphereNode.physicsBody?.rollingFriction = 0.5
        sphereNode.name = "bigSphere"
        self.rootNode.addChildNode(sphereNode)
    }
    
    func addFloorNode() {
        var floorNode = SCNNode()
        var floorGeometry = SCNFloor()
        floorNode.geometry = floorGeometry
        floorNode.position.y = -1.0
        floorNode.physicsBody = SCNPhysicsBody.staticBody()
        floorNode.physicsBody?.restitution = 0.75
        floorNode.physicsBody?.rollingFriction = 0.5
        
        self.rootNode.addChildNode(floorNode)
        
    }
}