import Foundation

public class Stack<Element> {

    private var array = [Element]()
    private let condition = NSCondition()

    var isEmpty: Bool {
        condition.lock()
        let isEmpty = array.isEmpty
        condition.unlock()
        return isEmpty
    }

    var count: Int {
        condition.lock()
        let count = array.count
        condition.unlock()
        return count
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
