import Foundation

//let timer = Timer(timeInterval: 2, repeats: true) { _ in
//    condition.lock()
//    let chip = Chip.make()
//    stack.push(chip)
//    print("\n\(count * 2) sec")
//    if let element = stack.peek() {
//        print("add to stack: \(element.chipType)") }
//    available = true
//    condition.signal()
//    condition.unlock()
//
//    count += 1
//    if count == 10 {
//        print("---Timer cancel---")
//        timer.invalidate()
//    }
//}

// MARK: - Threads

public class GeneratedThread: Thread {

    private var timer = Timer()

    private var stack: Stack<Chip>
    private var available = false
    private let condition = NSCondition()
    static var count = 0

    public init(stack: Stack<Chip>) {
        self.stack = stack
    }

//   private let timer = Timer.scheduledTimer(timeInterval: 2,
//                                            target: GeneratedThread.self,
//                                     selector: #selector(fireTimer),
//                                     userInfo: nil,
//                                     repeats: true)


    public override func main() {
//        RunLoop.current.add(timer, forMode: .common)
//        RunLoop.current.run()
        makeChip()
    }

//    let timer = Timer(timeInterval: 2, repeats: true) { _ in
//        makeChip()
//    }
    @objc private func fireTimer() {
        condition.lock()
        let chip = Chip.make()
        self.stack.push(chip)
        print("\n\(GeneratedThread.count * 2) sec")
        if let element = self.stack.peek() {
            print("add to stack: \(element.chipType)") }
        available = true
        condition.signal()
        condition.unlock()

        GeneratedThread.count += 1
        if GeneratedThread.count == 10 {
            print("---Timer cancel---")
            timer.invalidate()
        }
    }

//    func makeChip() {
//        for _ in 1...10 {
//           condition.lock()
//            stack.push(Chip.make())
//            available = true
//            print("""
//            \n
//            Микросхема создана! Микросхем в хранилище:
//            """)
//            condition.signal()
//            condition.unlock()
//            GeneratedThread.sleep(forTimeInterval: 2)
//        }
//    }

    func makeChip() {

        timer = Timer(timeInterval: 2, repeats: true) { _ in
            self.condition.lock()
                let chip = Chip.make()
                self.stack.push(chip)
                print("\n\(GeneratedThread.count * 2) sec")
                if let element = self.stack.peek() {
                    print("add to stack: \(element.chipType)") }
            self.available = true
            self.condition.signal()
            self.condition.unlock()

                GeneratedThread.count += 1
                if GeneratedThread.count == 10 {
                    print("---Timer cancel---")
                    self.timer.invalidate()
                }

        }

        RunLoop.current.add(timer, forMode: .common)
        RunLoop.current.run()

    }

}
