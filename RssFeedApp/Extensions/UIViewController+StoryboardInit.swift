//
//  UIViewController+StoryboardInit.swift
//  RssFeedApp
//
//  Created by Dmitry on 07.12.2020.
//

import Foundation
import UIKit

protocol StoryboardInit {
    static func instantiate() -> Self
}

extension StoryboardInit where Self: UIViewController {
    static func instantiate() -> Self {
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        let storyboard = UIStoryboard(name: className, bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: className)
        return view as! Self
    }
}
