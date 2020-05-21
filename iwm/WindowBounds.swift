import Foundation

public struct WindowBounds {
    var Height: Int
    var Width: Int
    var X: Int
    var Y: Int
}

extension WindowBounds {
 init(_ dict: [String: Any]) {
        self.Height = dict[dict.index(forKey: "Height")!].value as! Int;
        self.Width = dict[dict.index(forKey: "Width")!].value as! Int;
        self.X = dict[dict.index(forKey: "X")!].value as! Int;
        self.Y = dict[dict.index(forKey: "Y")!].value as! Int;
    }
    
    func toString() -> String {
        return """
        {
            Height: \(Height)
            Width: \(Width)
            X: \(X)
            Y: \(Y)
        }
        """
    }
}
