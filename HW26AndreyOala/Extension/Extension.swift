//
//  Extension.swift
//  HW26AndreyOala
//
//  Created by Andrey Oala on 18.08.2022.
//

import Foundation
import UIKit

extension UITextField {
func setIcon(_ image: UIImage) {
   let iconView = UIImageView(frame:
                  CGRect(x: 7, y: 2, width: 25, height: 25))
   iconView.image = image
   let iconContainerView: UIView = UIView(frame:
                  CGRect(x: 20, y: 0, width: 50, height: 30))
   iconContainerView.addSubview(iconView)
   leftView = iconContainerView
   leftViewMode = .always
}

}
