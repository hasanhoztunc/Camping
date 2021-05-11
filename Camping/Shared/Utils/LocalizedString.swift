//
//  LocalizedString.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

struct LocalizedString {
    var key: String

    init(_ key: String) {
        self.key = key
    }

    func resolve() -> String {
        NSLocalizedString(key, comment: "")
    }
}

extension LocalizedString: ExpressibleByStringLiteral {
    init(stringLiteral value: StringLiteralType) {
        key = value
    }
}

extension LocalizedString {
    typealias Fonts = (default: UIFont, bold: UIFont)

    static func defaultFonts() -> Fonts {
        let font = UIFont.preferredFont(forTextStyle: .body)
        return (font, .boldSystemFont(ofSize: font.pointSize))
    }
}

private extension LocalizedString {
    func render<T>(
        into initialResult: T,
        handler: (inout T, String, _ isBold: Bool) -> Void
    ) -> T {
        let components = resolve().components(separatedBy: "**")
        let sequence = components.enumerated()

        return sequence.reduce(into: initialResult) { result, pair in
            let isBold = !pair.offset.isMultiple(of: 2)
            handler(&result, pair.element, isBold)
        }
    }
}

extension LocalizedString {
    func attributedString(
        withFonts fonts: Fonts = defaultFonts()
    ) -> NSAttributedString {
        render(
            into: NSMutableAttributedString(),
            handler: { fullString, string, isBold in
                let font = isBold ? fonts.bold : fonts.default

                fullString.append(NSAttributedString(
                    string: string,
                    attributes: [.font: font]
                ))
            }
        )
    }
}
