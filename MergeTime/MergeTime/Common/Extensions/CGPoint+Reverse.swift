import UIKit

extension CGPoint {
    
    var reverse: Self {
        return CGPoint(x: -x, y: -y)
    }
}
