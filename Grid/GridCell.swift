// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

protocol GridCellContentsProtocol: class {

}

protocol GridCellProtocol: class {
    var contents: GridCellContentsProtocol? { get set }
    var gridPosition: GridPoint { get }

    init(_ gridPosition: GridPoint)
}

protocol GridCellFactoryProtocol {
    func makeCell(_ gridPosition: GridPoint) -> GridCellProtocol
}

final class GridCell: GridCellProtocol {
    weak var contents: GridCellContentsProtocol?
    let gridPosition: GridPoint

    init(_ gridPosition: GridPoint) {
        self.gridPosition = gridPosition
    }
}

struct GridCellFactory<T: GridCellProtocol> {
    func makeCell(_ gridPosition: GridPoint) -> T {
        T(gridPosition)
    }
}
