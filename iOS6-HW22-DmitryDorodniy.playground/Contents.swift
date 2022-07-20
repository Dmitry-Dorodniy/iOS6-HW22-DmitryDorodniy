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



var stack = Stack<Chip>()
var count = 0
var available = false
let condition = NSCondition()

let timer = Timer(timeInterval: 2, repeats: true) { _ in
    //    print("\n\(count * 2) sec")
    condition.lock()
    let chip = Chip.make()
    stack.push(chip)
    print("\n\(count * 2) sec")
    if let element = stack.peek() {
        print("add to stack: \(element.chipType)") }
    available = true
    condition.signal()
    condition.unlock()

    count += 1
    if count == 10 {
        print("---Timer cancel---")
        timer.invalidate()
    }
}



class GeneratedThread: Thread {
    override func main() {
        RunLoop.current.add(timer, forMode: .common)
        RunLoop.current.run()
    }
}

class WorkedThread: Thread {
    override func main() {
        for _ in 1...10 {
            while !available {
                condition.wait()
            }
            if let chip = stack.peek() {
                print("pop from stack: \(chip.chipType)") }
            stack.pop()?.sodering()
            if stack.isEmpty {
                print("empty stack")
                available = false
            }
        }
    }
}

let generatedThread = GeneratedThread()
let workedThread = WorkedThread()
generatedThread.start()
workedThread.start()


//for _ in 1...23 {
//
//    if stack.isEmpty {
//        print("break")
//        break
//    }
//    print("peek: \(stack.peek() ?? 0)   pop: \(stack.pop() ?? 0)")
//}


