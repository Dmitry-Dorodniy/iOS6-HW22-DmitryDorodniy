import Foundation

public class GeneratedThread: Thread {

    private var timer = Timer()
    private var stack: Stack<Chip>
    static var available = false
    static var isGenerating = true
    static let condition = NSCondition()
    private var count = Double()

    public init(stack: Stack<Chip>) {
        self.stack = stack
    }

    public override func main() {
        makeChip()
    }

    func makeChip() {

        timer = Timer(timeInterval: Constants.timeInterval, repeats: true) { [self] _ in
            GeneratedThread.condition.lock()
            let chip = Chip.make()
            stack.push(chip)
            print("\n\(count * Constants.timeInterval) sec")
            if let element = stack.peek() {
                print("add to stack: \(element.chipType)") }
            print("in total stack: \(stack.count)")
            GeneratedThread.available = true
            GeneratedThread.condition.signal()
            GeneratedThread.condition.unlock()

            count += 1
            if count >= Constants.generatingTime / Constants.timeInterval {
                GeneratedThread.isGenerating = false
                print("\n---Generated Thread canceled---\n")
                timer.invalidate()
            }
        }

        RunLoop.current.add(timer, forMode: .common)
        RunLoop.current.run()
    }

}
