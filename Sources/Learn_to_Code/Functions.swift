// MARK: - Public functions

public func moveForward() {
    Game.shared.move(y: 1, x: 0)
}

public func collectGem() {
    Game.shared.collect()
}
