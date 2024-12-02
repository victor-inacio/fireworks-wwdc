import SceneKit

class UniverseGenerator {
    
    let scene: SCNScene
    
    init(scene: SCNScene) {
        self.scene = scene
    }
    
    func generateStars() {
        let numOfStars = 300
        
        let possibleColors: [UIColor] = [
            .red,
            .green,
            .white,
            .yellow,
            .systemPink,
            .purple
        ]
        
        for _ in 0..<numOfStars {
            let color = possibleColors.randomElement()!
            let material = SCNMaterial()
            material.emission.contents = color
            material.emission.intensity = 1
            
            material.selfIllumination.contents = color
            material.selfIllumination.intensity = 1
            
            let sphereRadius = CGFloat.random(in: 0...4)
            let sphere = SCNSphere(radius: sphereRadius)
            let dir = SCNVector3.randomDir()
            let distance = Float.random(in: 500...1000)
            let position = dir * distance
            
            sphere.materials = [material]
            
            let node = SCNNode(geometry: sphere)
            node.position = position
            
            scene.rootNode.addChildNode(node)
            
            scene.background.contents = UIImage(named: "skymap")
        }
        
        
    }
    
    
}
