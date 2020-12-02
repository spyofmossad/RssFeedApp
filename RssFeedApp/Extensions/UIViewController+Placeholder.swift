//
//  UIViewController+Placeholder.swift
//  RssFeedApp
//
//  Created by Dmitry on 02.12.2020.
//

import UIKit

var placeholderView: UIView?

extension UIViewController {
    func showPlaceholder(in container: UIView, with text: String) {
        DispatchQueue.main.async {
            let placeholderView = UIView(frame: container.bounds)
            placeholderView.backgroundColor = .white
            let label = UILabel(frame: placeholderView.bounds)
            label.center = placeholderView.center
            label.text = text
            label.textColor = .lightGray
            label.numberOfLines = 0
            label.textAlignment = .center
            placeholderView.addSubview(label)
            container.addSubview(placeholderView)
            
            pView = placeholderView
        }
    }
    
    func removePlaceholder() {
        DispatchQueue.main.async {
            placeholderView?.removeFromSuperview()
            placeholderView = nil
        }
    }
}



