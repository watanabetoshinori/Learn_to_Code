
// MARK: - Ascii Game

class Game {

    // The point.

    struct Point {
        let y: Int
        let x: Int
        
        static func zero() -> Point {
            return Point(y: 0, x: 0)
        }
    }
    
    // Game Objects.
    
    enum Object {
        case player
        case gem
        case floor
        
        var ascii: String {
            switch self {
            case .player:
                return "@"
            case .gem:
                return "*"
            case .floor:
                return "."
            }
        }
    }

    // Game Map.
    
    private var map: [[Object]] = [
        [.floor, .floor, .gem, .floor, .floor],
        [.floor, .floor, .floor, .floor, .floor],
        [.floor, .floor, .floor, .floor, .floor],
        [.floor, .floor, .player, .floor, .floor],
        [.floor, .floor, .floor, .floor, .floor],
    ]
    
    // The object under the player foot.
    
    private var foot: Object?
    
    private var playerLocation: Point {
        for (y, line) in map.enumerated() {
            for (x, obj) in line.enumerated() {
                if obj == .player {
                    return Point(y: y, x: x)
                }
            }
        }
        
        return Point(y: 0, x: 0)
    }
    
    // flag

    private var finished = false
    
    // Singleton instance
    
    static let shared = Game()
    
    private init() {
        update()
    }
    
    // outputs the current state
    
    private func update() {
        print("-------")
        map.forEach { (line) in
            let ascii = line.reduce("", combine: { $0 + $1.ascii })
            print("|" + ascii + "|")
        }
        print("-------")
        print("")
    }

    // move player
    
    func move(y: Int, x: Int) {
        if finished { return }
        
        let p = playerLocation
        
        let pp = Point(y: p.y - y, x: p.x - x)
        
        if pp.y < 0 || map.count <= pp.y {
            return
        }
        if pp.x < 0 || map.count <= pp.x {
            return
        }

        foot = map[pp.y][pp.x]
        map[p.y][p.x] = .floor
        map[pp.y][pp.x] = .player
        
        update()
    }
    
    // collects gem
    
    func collect() {
        if finished { return }
        
        if foot == .gem {
            print("Conguratulations!")
            finished = true
        }
    }

}
