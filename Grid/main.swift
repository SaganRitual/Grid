// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

print("Origin at center: \n")
let centeredGrid = Grid(size: GridSize(width: 7, height: 7), origin: .center)
for aix in 0..<centeredGrid.size.area() {
    let gridPosition = centeredGrid.getPosition(absoluteIndex: aix)
    if aix > 0 && aix % centeredGrid.size.width == 0 { print() }
    print(gridPosition, terminator: " ")
}

print("\n\nOrigin at upper left:\n")
let yUpperLeftGrid = Grid(size: GridSize(width: 7, height: 7), origin: .upperLeft)
for aix in 0..<centeredGrid.size.area() {
    let gridPosition = yUpperLeftGrid.getPosition(absoluteIndex: aix)
    if aix > 0 && aix % centeredGrid.size.width == 0 { print() }
    print(gridPosition, terminator: " ")
}

print("\n\nOrigin at lower left:\n")
let yLowerLeftGrid = Grid(size: GridSize(width: 7, height: 7), origin: .lowerLeft)
for aix in 0..<centeredGrid.size.area() {
    let gridPosition = yLowerLeftGrid.getPosition(absoluteIndex: aix)
    if aix > 0 && aix % centeredGrid.size.width == 0 { print() }
    print(gridPosition, terminator: " ")
}

print("\n")
