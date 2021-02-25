


import UIKit

private let joystickRadius: Double = 40
private let maximumTimeStep: Double = 1 / 90
private let worldTimeStep: Double = 1 / 120


class ViewController: UIViewController {
    private let imageView = UIImageView()
    private let panGesture = UIPanGestureRecognizer()
    private var world : World!
    private var lastFrameTime = CACurrentMediaTime()
    private var textures = Textures()
    private var map : Map
    init(map: Map) {
        self.map = map
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    

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
        //map = resources.mapToPlay
        world = World(map: loadMap())
        textures.textures = map.getSessionBitmapTextures()
        setUpImageView()
        view.addGestureRecognizer(panGesture)
        
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .main, forMode: .common)
        
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
        let timeStep = maximumTimeStep//min(maximumTimeStep, displayLink.timestamp - lastFrameTime)
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
    
    
    func loadMap() -> Tilemap {
        var allTiles = [Tile]()
        for tile in Tile.allCases {
            allTiles.append(tile)
        }
        var tiles = [Tile]()
        for nr in map.mapArray {
            tiles.append(allTiles[nr])
        }
        
        var allThings = [Thing]()
        for thing in Thing.allCases {
            allThings.append(thing)
        }
        var things = [Thing]()
        for nr in map.actorsArray {
            things.append(allThings[nr])
        }
        
        return Tilemap(tiles: tiles, things: things, width: map.width)
//        let jsonURL = Bundle.main.url(forResource: "Map", withExtension: "json")!

//        let json : JSON = [
//            "width": map.width,
//            "tiles": [
//                map.mapArray,
//            ],
//            "things": [
//                map.actorsArray,
//            ]
//        ]
//        var json = JSON()
//        json["width"].int = map.width as Int
//        json["tiles"].arrayObject = map.mapArray
//        json["things"].arrayObject = map.actorsArray
//
//
//        func getArrayString(array: [Int]) -> String {
//            var string = String()
//            for nr in array {
//                string.append("\(nr), ")
//            }
//            return string
//        }
//        let string = #"""
//            {"width": \#(map.width),
//            "tiles": [
//            \#(getArrayString(array: map.mapArray))
//            ],
//            "things": [
//            \#(getArrayString(array: map.actorsArray))
//            ]
//            }
//            """#
//        var json: JSON
//        if let dataFromString = string.data(using: .utf8, allowLossyConversion: false) {
//            try! json = JSON(data: dataFromString)
//        }
        //let jsonData = try! Data(contentsOf: json)
//        return try! JSONDecoder().decode(Tilemap.self, from: json(using: .utf8, allowLossyConversion: false)!)
    }
    
    
}


