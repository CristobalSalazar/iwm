import AppKit

let workspace = NSWorkspace.shared
let apps = workspace.runningApplications;

print("Process trusted: \(AXIsProcessTrusted())")

for app in apps {
    let el = AXElement(pid: app.processIdentifier)
    if (el.hasMainWindow()) {
        print(el.getActionNames())
    }

}

