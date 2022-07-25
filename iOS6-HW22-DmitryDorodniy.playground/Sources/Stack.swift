import Foundation

public struct Stack<Element> {
    private var array = [Element]()
    private let condition = NSLock()

    var isEmpty: Bool {
        return array.isEmpty
    }

    public init() {}
    
    public mutating func push(_ newElement: Element) {
        condition.lock()
        array.append(newElement)
        condition.unlock()
    }

    public mutating func pop() -> Element? {
        condition.lock()
        let lastElement = array.removeLast()
        condition.unlock()
        return lastElement

    }

    public mutating func peek() -> Element? {
        condition.lock()
        let lastElement = array.last
        condition.unlock()
        return lastElement
    }
}
