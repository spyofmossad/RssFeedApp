//
//  UIView+SpinnerView.swift
//  RssFeedApp
//
//  Created by Dmitry on 20.11.2020.
//

import Foundation
import UIKit

var activityView: UIView?
let height = 80
let width = 80

extension UIViewController {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let container = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            container.layer.cornerRadius = 10
            container.center = self.view.center
            container.backgroundColor = .systemGray5
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.startAnimating()
            activityIndicator.frame = container.bounds
            container.addSubview(activityIndicator)
            self.view.addSubview(container)
            
            activityView = container
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            activityView?.removeFromSuperview()
            activityView = nil
        }
    }
}
