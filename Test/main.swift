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

public class WindowBounds {
    var Height: Int;
    var Width: Int;
    var X: Int;
    var Y: Int;
    
    init(_ height: Int,_ width: Int,_ x: Int,_ y: Int) {
        self.Height = height;
        self.Width = width;
        self.X = x;
        self.Y = y;
    }
}

class WindowInfo {
    let kCGWindowLayer: Int;
    let kCGWindowMemoryUsage: Int;
    let kCGWindowOwnerPID: Int32;
    let kCGWindowName: String;
    let kCGWindowNumber: Int;
    let kCGWindowStoreType: Int;
    let kCGWindowIsOnscreen: Int;
    let kCGWindowOwnerName: String;
    let kCGWindowAlpha: Int;
    let kCGWindowSharingState: Int;
    let kCGWindowBounds: WindowBounds;
    
    init(dict: [String : Any]) {
        self.kCGWindowLayer = dict[dict.index(forKey: "kCGWindowLayer")!].value as! Int;
        self.kCGWindowMemoryUsage = dict[dict.index(forKey: "kCGWindowMemoryUsage")!].value as! Int;
        self.kCGWindowOwnerPID = dict[dict.index(forKey: "kCGWindowOwnerPID")!].value as! Int32;
        self.kCGWindowName = dict[dict.index(forKey: "kCGWindowName")!].value as! String;
        self.kCGWindowNumber = dict[dict.index(forKey: "kCGWindowNumber")!].value as! Int;
        self.kCGWindowStoreType = dict[dict.index(forKey: "kCGWindowStoreType")!].value as! Int;
        self.kCGWindowIsOnscreen = dict[dict.index(forKey: "kCGWindowIsOnscreen")!].value as! Int;
        self.kCGWindowOwnerName = dict[dict.index(forKey: "kCGWindowOwnerName")!].value as! String;
        self.kCGWindowAlpha = dict[dict.index(forKey: "kCGWindowAlpha")!].value as! Int;
        self.kCGWindowSharingState = dict[dict.index(forKey: "kCGWindowSharingState")!].value as! Int;
        self.kCGWindowBounds = WindowBounds(3, 3, 3, 3);
    }
}

let screen = NSScreen.main;
let screenWidth = screen!.visibleFrame.width;
let screenHeight = screen!.visibleFrame.height;
let resolution = Resolution(width: screenWidth, height: screenHeight);
let workspace = NSWorkspace.init();
let apps = workspace.runningApplications;

func bringToForeground(app: NSRunningApplication) {
    let opts = NSApplication.ActivationOptions.activateIgnoringOtherApps;
    app.activate(options: opts);
}

func getWindowInfo() -> [WindowInfo] {
    var typedList = Array<WindowInfo>();
    if let info = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as? [[ String : Any]] {
        for dict in info {
            dict.forEach { (key, val) in
                let windowInfo = WindowInfo(dict: dict);
                typedList.append(windowInfo)
            }
        }
    }
    return typedList;
}

func filterActiveWindows(windows: [WindowInfo]) -> [WindowInfo] {
    var removedDuplicates: [WindowInfo] = []
    var pids: [Int32] = []
    for window in windows {
        if !pids.contains(window.kCGWindowOwnerPID) {
            let pid = window.kCGWindowOwnerPID
            let windowApp = NSRunningApplication.init(processIdentifier: pid)
            if let windowApp = windowApp {
                if windowApp.isActive {
                    pids.append(window.kCGWindowOwnerPID)
                    removedDuplicates.append(window)
                }
            }

        }
    }
    return removedDuplicates;
}
// Remove system processes
let blacklist = ["Window Server", "Dock", "SystemUIServer", "Spotlight"]
let windowInfo = getWindowInfo();
var windows = windowInfo.filter({ return !blacklist.contains($0.kCGWindowOwnerName)})
windows = filterActiveWindows(windows: windows)

for window in windows {
    print(window.kCGWindowOwnerName)
}

