// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

print("Origin at center: \n")
let centeredGrid = Grid<GridCell>(size: GridSize(width: 7, height: 7), origin: .center)
for aix in 0..<centeredGrid.size.area() {
    let gridPosition = centeredGrid.getPosition(absoluteIndex: aix)
    if aix > 0 && aix % centeredGrid.size.width == 0 { print() }
    print(gridPosition, terminator: " ")
}

print("\n\nOrigin at upper left:\n")
let yUpperLeftGrid = Grid<GridCell>(size: GridSize(width: 7, height: 7), origin: .upperLeft)
for aix in 0..<centeredGrid.size.area() {
    let gridPosition = yUpperLeftGrid.getPosition(absoluteIndex: aix)
    if aix > 0 && aix % centeredGrid.size.width == 0 { print() }
    print(gridPosition, terminator: " ")
}

print("\n\nOrigin at lower left:\n")
let yLowerLeftGrid = Grid<GridCell>(size: GridSize(width: 7, height: 7), origin: .lowerLeft)
for aix in 0..<centeredGrid.size.area() {
    let gridPosition = yLowerLeftGrid.getPosition(absoluteIndex: aix)
    if aix > 0 && aix % centeredGrid.size.width == 0 { print() }
    print(gridPosition, terminator: " ")
}

print("\n")

final class TestGridCell: GridCellProtocol {
    weak var contents: GridCellContentsProtocol?
    let gridPosition: GridPoint

    init(_ gridPosition: GridPoint) { self.gridPosition = gridPosition }
    func getGridPosition() -> String {
        "->\(gridPosition)<-"
    }
}

typealias TestGrid = Grid<TestGridCell>
let testGrid = TestGrid(size: GridSize(width: 7, height: 7))

for aix in 0..<testGrid.size.area() {
    let gridPosition = testGrid.getPosition(absoluteIndex: aix)
    let cell = testGrid.cellAt(gridPosition)
    if aix > 0 && aix % testGrid.size.width == 0 { print() }
    print(cell.getGridPosition(), terminator: " ")
}
