import SceneKit

class Firework {
        
    var dir: SCNVector3!
    var pos: SCNVector3!
    var tailNode: SCNNode!
    let scene: SCNScene
    let lifeTime: TimeInterval
    var timer: TimeInterval = 0.0
    var audioPlayer: SCNAudioPlayer!
    var audioSource: SCNAudioSource!
    
    var exploded = false
    
    var explodeParticleSystem: SCNParticleSystem!
    var tailParticleSystem: SCNParticleSystem!
    
    private var possibleColors: [UIColor] = [
        .red,
        .purple,
        .green,
        .cyan,
        .yellow,
        .magenta,
        .orange,
        .systemPink
    ]
    
    let color: UIColor

    init(scene: SCNScene) {
        lifeTime = TimeInterval.random(in: 2.0...2.1)
        color = possibleColors.randomElement()!
        self.scene = scene
        
        let dir = SCNVector3.randomDir()
        self.dir = dir
        self.pos = self.dir * 13
        
        let explode = scene.rootNode.childNode(withName: "explode2", recursively: true)!
        
        explodeParticleSystem = explode.particleSystems?.first?.copy() as! SCNParticleSystem as SCNParticleSystem
    }
    
    func update(_ deltaTime: TimeInterval) {
        timer += deltaTime
        if (timer >= lifeTime && !exploded) {
            tailNode.particleSystems?.first?.birthRate = 0
            tailNode.physicsBody?.velocity = .zero()
            
            explode(pos: tailNode.presentation.position)
            
            exploded = true
        }
        
    }
    
    private func explode(pos: SCNVector3) {
        let explodeNode = SCNNode()
        playSound(named: "Firework Explode.mp3", node: explodeNode)
    
//
//        clone.removeAllParticleSystems()
//        
        
        let animation = CAKeyframeAnimation(keyPath: "particleColor")
        
        animation.values = [color, UIColor.white]
        animation.keyTimes = [0.0, 1.0]
        animation.duration = explodeParticleSystem.particleLifeSpan
        explodeParticleSystem.addAnimation(animation, forKey: "particleColor")
        explodeNode.position = pos
        
        explodeParticleSystem.acceleration = dir * -1
        explodeNode.addParticleSystem(explodeParticleSystem)
        
        explodeParticleSystem.loops = false
        scene.rootNode.addChildNode(explodeNode)
        explodeParticleSystem.reset()
    }
    
    private func playSound(named: String, node: SCNNode) {
        let audioSource = SCNAudioSource(named: named)!
        audioSource.isPositional = true
        audioSource.loops = false
        audioSource.shouldStream = false
        audioSource.load()
        audioSource.volume = 0.3
        
        node.runAction(.playAudio(audioSource, waitForCompletion: true))
    }
    
    func spawn() {
        
        
        let tail = scene.rootNode.childNode(withName: "tail1", recursively: true)!
        
        let clone = tail.clone()

        let particleSystem = clone.particleSystems?.first?.copy() as! SCNParticleSystem as SCNParticleSystem
        playSound(named: "Firework Init.mp3", node: clone)
        particleSystem.acceleration = self.dir * -1
        
        clone.removeAllParticleSystems()
        clone.physicsBody =  tail.physicsBody?.copy() as? SCNPhysicsBody
        
        
        clone.physicsBody?.velocity = dir * 2
        clone.position = self.pos
        tailNode = clone
        scene.rootNode.addChildNode(clone)
        
        let animation = CAKeyframeAnimation(keyPath: "particleColor")
        
        animation.values = [ UIColor.white, color,]
        animation.keyTimes = [0.0, 1.0]
        animation.duration = lifeTime
        
        particleSystem.removeAllAnimations()
        
        particleSystem.addAnimation(animation, forKey: "particleColor")
        clone.addParticleSystem(particleSystem)
    }
    
   
    
    
    
}
