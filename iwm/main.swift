import Foundation
import AppKit

let windowInfo = WindowInfo.getWindowInfo();
let ownerBlacklist = ["Window Server", "Dock", "SystemUIServer", "Spotlight"]
let windows = windowInfo.filter
{
    if let ownerName = $0.ownerName {
        return !ownerBlacklist.contains(ownerName)
    } else {
        return false;
    }
}
