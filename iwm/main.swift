import Foundation
import AppKit

struct Resolution {
    var width: CGFloat;
    var height: CGFloat;
    
    init(width: CGFloat, height: CGFloat) {
        self.width = width;
        self.height = height;
    }
}

let screen = NSScreen.main;
let screenWidth = screen!.visibleFrame.width;
let screenHeight = screen!.visibleFrame.height;
let resolution = Resolution(width: screenWidth, height: screenHeight);
let workspace = NSWorkspace.init();

func removeDuplicatePIDS(windows: [WindowInfo]) -> [WindowInfo] {
    var removedDuplicates: [WindowInfo] = []
    var pids: [Int32] = []
    for window in windows {
        if !pids.contains(window.kCGWindowOwnerPID) {
            pids.append(window.kCGWindowOwnerPID)
            removedDuplicates.append(window)
        }
    }
    return removedDuplicates;
}

let windowInfo = WindowInfo.getWindowInfo();
let blacklist = ["Window Server", "Dock", "SystemUIServer", "Spotlight"]
var windows = windowInfo.filter({ return !blacklist.contains($0.kCGWindowOwnerName)})
//windows = removeDuplicatePIDS(windows: windows)

for window in windows {
    print("Owner: \(window.kCGWindowOwnerName)\nWindow: {\nHeight: \(window.kCGWindowBounds?.Height),\nWidth: \(window.kCGWindowBounds?.Width)\n}\n")
}
