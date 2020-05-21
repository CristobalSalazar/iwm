import Foundation
import AppKit

struct Resolution {
    var width: CGFloat;
    var height: CGFloat;
    
    init(width: CGFloat, height: CGFloat) {
        self.width = width;
        self.height = height;
    }
    
    static func getScreenResolutions() -> [Resolution] {
        let screens = NSScreen.screens;
        return screens.map {
            return Resolution(width: $0.visibleFrame.width, height: $0.visibleFrame.height);
        }
    }
}
