import SwiftUI
import SceneKit

@main
struct MyApp: App {
    
    @State private var font: Font?
    @State private var opacity: Double = 1.0
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                
                PlanetSceneView()
                    .ignoresSafeArea()
                HStack {
                    Button(action: {
                        FireworkSpawner.shared.start()
                    }, label: {
                        Text("Fogo")
                     
                    })
                    
                    .position(.init(x: 50, y: 50))
                    
                }
            }
        }
    }
    
    
    func getFont() {
        let cfURL = Bundle.main.url(forResource: "alarm clock", withExtension: "ttf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        let uiFont = UIFont(name: "alarm clock", size: 64.0)
        
        font = Font(uiFont ?? UIFont())
    }
}

struct PlanetSceneView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
            return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
    
}
