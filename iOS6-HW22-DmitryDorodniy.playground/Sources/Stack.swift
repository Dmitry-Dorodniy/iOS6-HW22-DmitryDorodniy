import Foundation

public class Stack<Element> {

    private var array = [Element]()
    private let condition = NSLock()

    var isEmpty: Bool {
        return array.isEmpty
    }

    var count: Int {
        return array.count
    }

    public init() {}
    
    public func push(_ newElement: Element) {
        condition.lock()
        array.append(newElement)
        condition.unlock()
    }

    public func pop() -> Element? {
        condition.lock()
        let lastElement = array.removeLast()
        condition.unlock()
        return lastElement

    }

    public func peek() -> Element? {
        condition.lock()
        let lastElement = array.last
        condition.unlock()
        return lastElement
    }
}
