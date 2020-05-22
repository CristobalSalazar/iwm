import Foundation
import CoreServices

struct AXElement {
    let pid: Int32
    private let axElement: AXUIElement
    
    init(pid: Int32) {
        self.pid = pid
        self.axElement = AXUIElementCreateApplication(pid)
    }
}

extension AXElement {
    func getAttribute(attribute: String) -> AnyObject? {
        var ptr: AnyObject? = nil
        AXUIElementCopyAttributeValue(axElement, attribute as CFString, &ptr)
        return ptr
    }
    
    func isAttributeSettable(attribute: String) -> DarwinBoolean {
        var val: DarwinBoolean = false;
        AXUIElementIsAttributeSettable(axElement, attribute as CFString, &val)
        return val
    }
    
    
    func setSize(x: Int, y: Int) {
        var size = CGSize(width: x,height: y)
        let ref = AXValueCreate(AXValueType(rawValue: kAXValueCGSizeType)!, &size)
        let status = AXUIElementSetAttributeValue(axElement, kAXSizeAttribute as CFString, ref!)
        printAXError(err: status)
    }
    
    func getAttributeNames() -> [String] {
        var names: CFArray?
        AXUIElementCopyAttributeNames(axElement, &names)
        return names as! [String];
    }
    
    func getActionNames() -> [String]? {
        var actions: CFArray?
        AXUIElementCopyActionNames(axElement, &actions)
        return actions as? [String]
    }

    func isFrontmost() -> Bool {
        let attr = getAttribute(attribute: kAXFrontmostAttribute);
        return attr != nil && attr as! Int == 1
    }
    
    func hasMainWindow() -> Bool {
        let attr = getAttribute(attribute: kAXMainWindowAttribute)
        return attr != nil
    }
    
    private func printAXError(err: AXError) {
        switch err {
            case .actionUnsupported:
                print("actionUnsupported")
            case .apiDisabled:
                print("apiDisabled")
            case .attributeUnsupported:
                print("attribute unsupported")
            case.cannotComplete:
                print("cannot complete")
            case .failure:
                print("failure")
            case .illegalArgument:
                print("illegal argument")
            case .invalidUIElement:
                print("invalid UI Element")
            case .invalidUIElementObserver:
                print("invalid UI Element Observer")
            case .notEnoughPrecision:
                print("not enough precision")
            case .notificationAlreadyRegistered:
                print("notification already registered")
            case .notificationNotRegistered:
                print("notification not registered")
            case .notificationUnsupported:
                print("notification unsupported")
            case .notImplemented:
                print("not implemented")
            case .noValue:
                print("no value")
            case .parameterizedAttributeUnsupported:
                print("parameterized attribute unsupported")
            default:
                print("success")
        }
    }
}
