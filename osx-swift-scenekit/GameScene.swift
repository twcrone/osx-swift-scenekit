import Foundation
import SceneKit
import QuartzCore
import SpriteKit


class GameScene : SCNScene {
    
    var sphere: SCNNode!
    
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
            node.position = SCNVector3(x: xPos, y: 5.0, z: 0.0)
            node.physicsBody = SCNPhysicsBody.dynamicBody()
            rootNode.addChildNode(node)
            
            xPos += 0.66
        }
        
        addSphereNode()
        addFloorNode()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func moveSphere(direction: NSString) {
        let factor: CGFloat = 5.0
        let negativeFactor: CGFloat = -5.0
        let velocity = sphere.physicsBody?.velocity
        switch direction {
            case "left": velocity.x += negativeFactor
            case "right": velocity.x += factor
            case "forward": z = -50
            case "backward": z = 50
            case "up": y = 50
            default: y = 0
        }
        
    }
    
    func addSphereNode() {
        let sphereGeometry = SCNSphere(radius: 0.25)
        sphereGeometry.firstMaterial?.diffuse.contents = NSColor.purpleColor()
        
        let sphereNode = SCNNode(geometry: sphereGeometry)
        sphereNode.position = SCNVector3Make(0.0, 10.0, 0.0)
        sphereNode.physicsBody = SCNPhysicsBody.dynamicBody()
        sphereNode.physicsBody?.mass = 50
        //sphereNode.physicsBody?.angularVelocityFactor = SCNVector3Zero
//        sphereNode.physicsBody?.velocity = SCNVector3(x: 0.0, y: 0.0, z: 25.0)
        sphereNode.physicsBody?.rollingFriction = 0.5
        sphereNode.name = "bigSphere"
        self.rootNode.addChildNode(sphereNode)
        sphere = sphereNode
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