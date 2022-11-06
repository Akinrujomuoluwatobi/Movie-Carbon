//
//  ThreadScheduler.swift
//  Carbon-Movie
//
//  Created by Oluwatobiloba Akinrujomu on 05/11/2022.
//

import Foundation

final class ThreadScheduler {
	
	let thread: Thread
	
	private let target: ThreadTarget
	
	init(threadName: String) {
		self.target = ThreadTarget()
		self.thread = Thread(target: target,
												 selector: #selector(ThreadTarget.threadEntryPoint),
												 object: nil)
		self.thread.name = threadName
		self.thread.start()
	}
	
	func performAction(action: @escaping() -> Void) {
		let action = ThreadAction(action: action)
		action.perform(#selector(ThreadAction.performAction),
									 on: thread,
									 with: nil,
									 waitUntilDone: false,
									 modes: [RunLoop.Mode.default.rawValue])
	}
	
	func performSync<T>(action: @escaping () -> T) -> T {
		let semaphore = DispatchSemaphore(value: 0)
		var value: T?
		self.performAction {
			value = action()
			semaphore.signal()
		}
		semaphore.wait()
		return value!
	}
	
	deinit {
		thread.cancel()
	}
}

final class ThreadTarget: NSObject {
	@objc fileprivate func threadEntryPoint() {
		let runLoop = RunLoop.current
		runLoop.add(NSMachPort(), forMode: RunLoop.Mode.default)
		runLoop.run()
	}
}

final class ThreadAction: NSObject {
	private let action: () -> Void
	
	init(action: @escaping () -> Void) {
		self.action = action
	}
	
	@objc func performAction() {
		action()
	}
}
