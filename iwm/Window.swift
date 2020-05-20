import Foundation

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
    let kCGWindowBounds: WindowBounds?;
    let UIElement: AXUIElement;
    
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
        self.kCGWindowSharingState = dict[dict.index(forKey: "kCGWindowSharingState")!].value as! Int
        self.UIElement = AXUIElementCreateApplication(self.kCGWindowOwnerPID);
        if let windowBounds = dict[dict.index(forKey: "kCGWindowBounds")!].value as? [String: Any] {
            self.kCGWindowBounds = WindowBounds(windowBounds);
        } else {
            self.kCGWindowBounds = nil;
        }
    }
    
    public static func getWindowInfo() -> [WindowInfo] {
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
}

public class WindowBounds {
    var Height: Int = 0;
    var Width: Int = 0;
    var X: Int = 0;
    var Y: Int = 0;
    
    init(_ dict: [String: Any]) {
        self.Height = dict[dict.index(forKey: "Height")!].value as! Int;
        self.Width = dict[dict.index(forKey: "Width")!].value as! Int;
        self.X = dict[dict.index(forKey: "X")!].value as! Int;
        self.Y = dict[dict.index(forKey: "Y")!].value as! Int;
    }
}
