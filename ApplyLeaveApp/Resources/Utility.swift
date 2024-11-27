//
//  Utility.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)

        let red, green, blue: CGFloat

        switch hexString.count {
        case 3: // RGB (12-bit)
            red = CGFloat((rgb >> 8) & 0xF) / 15.0
            green = CGFloat((rgb >> 4) & 0xF) / 15.0
            blue = CGFloat(rgb & 0xF) / 15.0
        case 6: // RGB (24-bit)
            red = CGFloat((rgb >> 16) & 0xFF) / 255.0
            green = CGFloat((rgb >> 8) & 0xFF) / 255.0
            blue = CGFloat(rgb & 0xFF) / 255.0
        default:
            return nil
        }

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// Extension to calculate text bounds
extension UILabel {
    func boundingRectForCharacterRange(_ range: NSRange) -> CGRect {
        guard let text = self.attributedText?.string as NSString? else { return .zero }
        _ = text.size(withAttributes: [.font: self.font ?? UIFont.systemFont(ofSize: 17)])
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize(width: self.frame.size.width, height: .greatestFiniteMagnitude))
        let textStorage = NSTextStorage(attributedString: self.attributedText ?? NSAttributedString())
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        let glyphRange = layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
        let rect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
        
        return rect
    }
}

struct Validators {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*\\d).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}
