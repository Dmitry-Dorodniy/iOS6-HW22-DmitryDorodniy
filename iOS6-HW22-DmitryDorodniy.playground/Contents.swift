import Foundation

let stack = Stack<Chip>()
let generatedThread = GeneratedThread(stack: stack)
let workedThread = WorkedThread(stack: stack)

generatedThread.start()
workedThread.start()



