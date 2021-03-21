// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

/// Defines a grid of cells and functions for navigating it
struct Grid {
    enum Origin { case center, lowerLeft, upperLeft }

    let origin: Origin
    let size: GridSize
    var theCells: [GridCell]

    /// Create a two-dimensional grid of cells
    ///
    /// - Parameters:
    ///   - size: the desired size of the grid
    ///   - cellLayoutType: full grid layout with origin at the center,
    ///                     or quadrant I grid with origin at upper or lower left
    ///   - cellFactory: makes cells that adhere to GridCellProtocol
    ///
    /// Note that for the full grid, the dimensions of the grid must be odd,
    /// to ensure that (0, 0) is the center cell, with the same number of cells
    /// above as below, and on the right as on the left.
    init(size: GridSize, origin: Origin = .center) {
        if origin == .center {
            precondition(
                size.width % 2 == 1 && size.height % 2 == 1,
                "Grid with centered origin must have odd height & width, not \(size)"
            )
        }

        self.size = size
        self.origin = origin

        self.theCells = (0..<size.area()).map {
            let gridPosition = Grid.getPosition(
                absoluteIndex: $0, gridSize: size, origin: origin
            )

            return GridCell(gridPosition)
        }
    }

    func getPosition(absoluteIndex: Int) -> GridPoint {
        Grid.getPosition(
            absoluteIndex: absoluteIndex, gridSize: size, origin: origin
        )
    }
}

private extension Grid {
    static func getPosition(
        absoluteIndex: Int, gridSize: GridSize, origin: Origin
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
