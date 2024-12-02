import UIKit
import SceneKit

class ViewController: UIViewController, SCNSceneRendererDelegate {
    
    var scene: SCNScene!
    var sceneView = SCNView()
    let initialTime = TimeInterval()
    var deltaTime: TimeInterval = 0.0
    var lastTime: TimeInterval = 0.0
    let listener = SCNNode()
    
    var fireworkSpawner: FireworkSpawner!
    var universeGenerator: UniverseGenerator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastTime = initialTime
        setup()
    }
    
    private func addAudioListener() {
        let camera = scene.rootNode.childNode(withName: "camera", recursively: true)!
        camera.addChildNode(listener)
        sceneView.audioListener = listener
    }
    
    private func setup() {
        sceneView = SCNView(frame: view.frame)
        
        scene = SCNScene(named: "planetmodel.scn")
        
        sceneView.showsStatistics = Config.debug
        
        universeGenerator = UniverseGenerator(scene: scene)
        universeGenerator.generateStars()
        fireworkSpawner = FireworkSpawner.shared
        fireworkSpawner.scene = scene
        scene.background.contents = UIImage(named: "background")
        
        sceneView.defaultCameraController.automaticTarget = false
        
        sceneView.defaultCameraController.target = .init(0, 0, 0)
        
        sceneView.allowsCameraControl = true
        sceneView.scene = scene
        sceneView.backgroundColor = .black
            
        sceneView.delegate = self
        
//        addAudioListener()
        
        view.addSubview(sceneView)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        sceneView.defaultCameraController.target = .init(0, 0, 0)
        
        deltaTime = time - lastTime
        
        lastTime = time

        fireworkSpawner.update(deltaTime)
    }
    
    
}
