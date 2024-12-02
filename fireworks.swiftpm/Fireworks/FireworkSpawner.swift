import SceneKit

class FireworkSpawner {
    
    public static let shared = FireworkSpawner()
    
    var isStarted = false
    let minSecondsTime: TimeInterval = 0.0
    var maxSecondsTime: TimeInterval = 0.4
    var secondsToWait: TimeInterval = 0.0
    var timer: TimeInterval = 0.0
    
    var fireworks: [Firework] = []
    
    var scene: SCNScene!
    

    
    func start() {
        isStarted = true
    }
    
    func update(_ deltaTime: TimeInterval) {
        guard let scene = self.scene else {
            return
        }
        
        if (!isStarted) { return }
        
        timer += deltaTime
        
        if (timer >= secondsToWait) {
            spawnFirework()
            
            updateSecondsToWait()
            
            timer = 0.0
            
//            isStarted = false
        }
        
        for firework in fireworks {
            firework.update(deltaTime)
        }
    }
    
    private func spawnFirework() {
        let firework = Firework(scene: scene)
        
        firework.spawn()
        
        fireworks.append(firework)
    }
    
    private func updateSecondsToWait() {
        secondsToWait = TimeInterval.random(in: minSecondsTime...maxSecondsTime)
    }
    
    
}
