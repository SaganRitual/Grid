// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

protocol GridCellProtocol: class {
    var gridPosition: GridPoint { get }
    init(_ gridPosition: GridPoint)
}

final class GridCell: GridCellProtocol {
    let gridPosition: GridPoint
    init(_ gridPosition: GridPoint) { self.gridPosition = gridPosition }
}
