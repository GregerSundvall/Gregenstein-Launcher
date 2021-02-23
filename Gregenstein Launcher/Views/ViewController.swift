


import UIKit
import SwiftUI
//import Engine

private let joystickRadius: Double = 40
private let maximumTimeStep: Double = 1 / 20
private let worldTimeStep: Double = 1 / 120
//private func loadTextures() -> Textures {
//    return Textures(loader: { name in
//    Bitmap(image: UIImage(named: name)!)!
//    })
//}

class ViewController: UIViewController {
    private let imageView = UIImageView()
    private let panGesture = UIPanGestureRecognizer()
    private var world = World(map: Tilemap(tiles: [1], things: [1], width: 1) )
    private var lastFrameTime = CACurrentMediaTime()
    private var textures = Textures()
    private var map = Map(name: "asdf")
    @EnvironmentObject var resources: Resources

    private var inputVector: Vector {
        switch panGesture.state {
        case .began, .changed:
            let translation = panGesture.translation(in: view)
            var vector = Vector(x: Double(translation.x), y: Double(translation.y))
            vector /= max(joystickRadius, vector.length)
            panGesture.setTranslation(CGPoint(
                x: vector.x * joystickRadius,
                y: vector.y * joystickRadius
                ), in: view)
            return vector
        default:
            return Vector(x: 0, y: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map = resources.mapToPlay
        world = World(map: Tilemap(tiles: map.mapArray, things: map.actorsArray, width: map.width) )
        textures.textures = map.getSessionBitmapTextures()
        setUpImageView()
        view.addGestureRecognizer(panGesture)
        
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .main, forMode: .common)
        
    }
    
    func loadMap() -> Tilemap {
        return Tilemap(tiles: map.mapArray, things: map.actorsArray, width: map.width)
    }
    
    func setUpImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.layer.magnificationFilter = .nearest
    }
    
    @objc func update(_ displayLink: CADisplayLink) {
        let timeStep = min(maximumTimeStep, displayLink.timestamp - lastFrameTime)
        let inputVector = self.inputVector
        let rotation = inputVector.x * world.player.turningSpeed * worldTimeStep
        let input = Input(speed: -inputVector.y, rotation: Rotation(sine: sin(rotation), cosine: cos(rotation)))
        let worldSteps = (timeStep / worldTimeStep).rounded(.up)
        for _ in 0 ..< Int(worldSteps) {
            world.update(timeStep: timeStep / worldSteps, input: input)
        }
        lastFrameTime = displayLink.timestamp
        let width = Int(imageView.bounds.width), height = Int(imageView.bounds.height)
        var renderer = Renderer(width: width, height: height, textures: textures)
        renderer.draw(world)
        
        imageView.image = UIImage(bitmap: renderer.bitmap)
    }
}

//private func loadMap() -> Tilemap {
//
//    let jsonURL = Bundle.main.url(forResource: "Map", withExtension: "json")!
//    let jsonData = try! Data(contentsOf: jsonURL)
//    return try! JSONDecoder().decode(Tilemap.self, from: jsonData)
//}
