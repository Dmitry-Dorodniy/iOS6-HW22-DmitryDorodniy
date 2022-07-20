import Foundation

public struct Chip {
    public enum ChipType: UInt32 {
        case small = 1
        case medium
        case big
    }

    public let chipType: ChipType

    public static func make() -> Chip {
        guard let chipType = Chip.ChipType(rawValue: UInt32(arc4random_uniform(3) + 1)) else {
            fatalError("Incorrect random value")
        }

        return Chip(chipType: chipType)
    }

    public func sodering() {
        let soderingTime = chipType.rawValue
        print("sodering: \(chipType.rawValue)")
        sleep(UInt32(soderingTime))
    }
}


// MARK: - LIFO Stack
struct Stack<Element> {
    private var array = [Element]()

    var isEmpty: Bool {
        return array.isEmpty
    }

    mutating func push(_ chip: Element) {
        array.append(chip)
    }

    mutating func pop() -> Element? {
        return array.popLast()
    }

    mutating func peek() -> Element? {
        return array.last
    }
}



