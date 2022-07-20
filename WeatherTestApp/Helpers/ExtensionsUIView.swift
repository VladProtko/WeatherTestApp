//
//  ExtensionsUIView.swift
//  WeatherTestApp
//
//  Created by Admin on 18.07.22.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {

    static func fromNib<T: UIView>() -> T {
        let nibArray = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)
        return nibArray![0] as! T
    }
    
    @discardableResult
        open func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {

            translatesAutoresizingMaskIntoConstraints = false
            var anchoredConstraints = AnchoredConstraints()

            if let top = top {
                anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
            }

            if let leading = leading {
                anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
            }

            if let bottom = bottom {
                anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
            }

            if let trailing = trailing {
                anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
            }

            if size.width != 0 {
                anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
            }

            if size.height != 0 {
                anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
            }

            [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }

            return anchoredConstraints
        }

        @discardableResult
        open func fillSuperview(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
            translatesAutoresizingMaskIntoConstraints = false
            let anchoredConstraints = AnchoredConstraints()
            guard let superviewTopAnchor = superview?.topAnchor,
                let superviewBottomAnchor = superview?.bottomAnchor,
                let superviewLeadingAnchor = superview?.leadingAnchor,
                let superviewTrailingAnchor = superview?.trailingAnchor else {
                    return anchoredConstraints
            }

            return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
        }
    
}
