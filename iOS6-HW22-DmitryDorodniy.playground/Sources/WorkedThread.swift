import Foundation

public class WorkedThread: Thread {
    private var stack: Stack<Chip>
    private var available = false
    private let condition = NSCondition()
    
    public init(stack: Stack<Chip>) {
        self.stack = stack
    }
    
    public override func main() {
        while GeneratedThread.isGenerating {
            while !GeneratedThread.available {
                GeneratedThread.condition.wait()
            }
            if let chip = stack.peek() {
                print("remove from stack: \(chip.chipType)")
                stack.pop()?.sodering() }
            if stack.isEmpty {
                GeneratedThread.available = false }
        }
        print("\n---Worked Thread canceled---")
    }
}
