// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

enum GridCore { enum Origin { case center, lowerLeft, upperLeft } }

class Grid<T: GridCellProtocol> {
    let origin: GridCore.Origin
    let size: GridSize
    let theCells: [T]

    init(size: GridSize, origin: GridCore.Origin = .lowerLeft) {
        if origin == .center {
            precondition(
                size.width % 2 == 1 && size.height % 2 == 1,
                "Center-origin grid requires a cell at (0, 0): w and h must both be odd"
            )
        }

        self.origin = origin
        self.size = size

        self.theCells = (0..<size.area()).map {
            let gridPosition = Grid.getPosition(
                absoluteIndex: $0, gridSize: size, origin: origin
            )

            return Grid.makeCell(gridPosition)
        }
    }

    func cellAt(_ absoluteIndex: Int) -> T {
        let p = getPosition(absoluteIndex: absoluteIndex)
        return cellAt(p)
    }

    func cellAt(_ gridPosition: GridPoint) -> T {
        switch origin {
        case .center:    return cellAt_oCenter(gridPosition)
        case .lowerLeft: return cellAt_oLowerLeft(gridPosition)
        case .upperLeft: return cellAt_oUpperLeft(gridPosition)
        }
    }

    func getPosition(absoluteIndex: Int) -> GridPoint {
        Grid.getPosition(
            absoluteIndex: absoluteIndex, gridSize: size, origin: origin
        )
    }

    /// Indicates whether the specified position is on the grid
    ///
    /// - Parameter position: The position to check
    ///
    /// - Returns: A Bool indicating whether the point is on the grid
    func isOnGrid(_ position: GridPoint) -> Bool {
        switch origin {
        case .center:
            let hw = size.width / 2, hh = size.height / 2
            return (-hw...hw).contains(position.x) &&
                   (-hh...hh).contains(position.y)

        case .upperLeft: fallthrough
        case .lowerLeft:
            return
                (0..<size.width).contains(position.x) &&
                (0..<size.height).contains(position.y)
        }
    }

    /// For iterating over all the cells in the grid
    func makeIterator() -> IndexingIterator<[T]> { theCells.makeIterator() }
}

private extension Grid {
    static func makeCell(_ gridPosition: GridPoint) -> T { T(gridPosition) }
}

private extension Grid {
    func cellAt_oCenter(_ gridPosition: GridPoint) -> T {
        let halfHeight = size.height / 2
        let yy = halfHeight - gridPosition.y

        let halfWidth = size.width / 2
        let ix = (yy * size.width) + (halfWidth + gridPosition.x)

        return theCells[ix]
    }

    func cellAt_oLowerLeft(_ gridPosition: GridPoint) -> T {
        let ix = (size.height - 1 - gridPosition.y) * size.width + gridPosition.x
        return theCells[ix]
    }

    func cellAt_oUpperLeft(_ position: GridPoint) -> T {
        theCells[position.y * size.width + position.x]
    }
}

private extension Grid {
    static func getPosition(
        absoluteIndex: Int, gridSize: GridSize, origin: GridCore.Origin
    ) -> GridPoint {
        switch origin {
        case .center:
            let halfWidth = gridSize.width / 2

            let x = absoluteIndex % gridSize.width - halfWidth
            let y = halfWidth - absoluteIndex / gridSize.width

            return GridPoint(x: x, y: y)

        case .upperLeft:
            let x = absoluteIndex % gridSize.width
            let y = absoluteIndex / gridSize.width

            return GridPoint(x: x, y: y)

        case .lowerLeft:
            let x = absoluteIndex % gridSize.width
            let y = gridSize.height - 1 - absoluteIndex / gridSize.width

            return GridPoint(x: x, y: y)
        }
    }
}
