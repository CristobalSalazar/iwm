import Foundation

struct WindowInfo {
    // Required Window List Keys
    let number: Int;
    let storeType: Int;
    let layer: Int;
    let bounds: WindowBounds;
    let sharingState: Int;
    let alpha: Int;
    let ownerPID: Int32;
    let memoryUsage: Int;
    // Optional Window List Keys
    let name: String?;
    let isOnScreen: Int?;
    let ownerName: String?;
}

extension WindowInfo {
    init(dict: [String : Any]) {
        self.layer = dict[dict.index(forKey: "kCGWindowLayer")!].value as! Int
        self.memoryUsage = dict[dict.index(forKey: "kCGWindowMemoryUsage")!].value as! Int
        self.ownerPID = dict[dict.index(forKey: "kCGWindowOwnerPID")!].value as! Int32
        self.number = dict[dict.index(forKey: "kCGWindowNumber")!].value as! Int
        self.storeType = dict[dict.index(forKey: "kCGWindowStoreType")!].value as! Int
        self.alpha = dict[dict.index(forKey: "kCGWindowAlpha")!].value as! Int
        self.sharingState = dict[dict.index(forKey: "kCGWindowSharingState")!].value as! Int
        self.bounds = WindowBounds(dict[dict.index(forKey: "kCGWindowBounds")!].value as! [String: Any])
        // Optionals
        self.name = dict[dict.index(forKey: "kCGWindowName")!].value as? String
        self.isOnScreen = dict[dict.index(forKey: "kCGWindowIsOnscreen")!].value as? Int
        self.ownerName = dict[dict.index(forKey: "kCGWindowOwnerName")!].value as? String
    }
    
    // Expensive
    static func getWindowInfoList() -> [WindowInfo] {
        var list: [WindowInfo] = []
        if let info = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as? [[ String : Any]] {
            for dict in info {
                dict.forEach { (key, val) in
                    list.append(WindowInfo(dict: dict));
                }
            }
        }
        return list;
    }
}
