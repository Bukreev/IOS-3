

import UIKit


class PrintTimerBehavior: ViewControllerLifecycleBehavior {
    var timer:Timer?
    
    func afterAppearing(_ viewController: UIViewController) {
        print("timer started")
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print(Date())
        }
    }
    
    func beforeDisappearing(_ viewController: UIViewController) {
        timer?.invalidate()
        print("timer stopped")
    }
}
