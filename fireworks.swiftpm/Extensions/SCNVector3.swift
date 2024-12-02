import SceneKit

extension SCNVector3 {
    
    func magnitude() -> Float {
        return sqrt(pow(x, 2) + pow(y, 2))
    }
    
    func normalized() -> SCNVector3 {
        let newX = x / magnitude()
        let newY = y / magnitude()
        let newZ = z / magnitude()
        
        return SCNVector3(newX, newY, newZ)
    }
    
    static func *(vector1: SCNVector3, vector2: SCNVector3) -> SCNVector3 {
        
        let newX = vector1.x * vector2.x
        let newY = vector1.y * vector2.y
        let newZ = vector1.z * vector2.z
        
        return SCNVector3(newX, newY, newZ)
    }
    
    static func *(vector1: SCNVector3, num: Float) -> SCNVector3 {
        
        let newX = vector1.x * num
        let newY = vector1.y * num
        let newZ = vector1.z * num
        
        return SCNVector3(newX, newY, newZ)
    }
    
    static func zero() -> SCNVector3 {
        
        return .init(x: 0, y: 0, z: 0)
        
    }
    
    static func randomDir() -> SCNVector3 {
        
        let dir = SCNVector3(Float.random(in: -2...2), Float.random(in: -2...2), Float.random(in: -2...2)).normalized()
        
        return dir
    }
    
}
