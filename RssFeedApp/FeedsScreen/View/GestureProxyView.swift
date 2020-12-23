//
//  GestureProxyView.swift
//  RssFeedApp
//
//  Created by Dmitry on 23.12.2020.
//

import UIKit

class GestureProxyView: UIView {
    var onTouch: ((_ yPoint: Float) -> Void)?
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        onTouch?(Float(point.y))
        return false
    }
}
