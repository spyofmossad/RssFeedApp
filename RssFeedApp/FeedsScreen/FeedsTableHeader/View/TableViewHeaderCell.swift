//
//  TableViewHeader.swift
//  RssFeedApp
//
//  Created by Dmitry on 04.12.2020.
//

import UIKit

class TableViewHeaderCell: UITableViewHeaderFooterView {
    
    private var isExpanded = true
    private let swipeShift: CGFloat = 75
    
    enum SwipeDirection {
        case left
        case right
    }
    
    @IBOutlet weak var folderTitle: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    var presenter: FeedsTableHeaderPresenterProtocol! {
        didSet {
            self.folderTitle.text = presenter.headerTitle
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
            tapGesture.numberOfTapsRequired = 1
            button.addGestureRecognizer(tapGesture)
            
            let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
            leftSwipeGesture.direction = .left
            self.addGestureRecognizer(leftSwipeGesture)
            
            let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
            rightSwipeGesture.direction = .right
            self.addGestureRecognizer(rightSwipeGesture)
            
            self.prepareAdditionalViews()
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let inside = super.point(inside: point, with: event)
        
        if !inside {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        
        return inside
    }
    
    func swipeWithAnimation(to: SwipeDirection) {
        let screenCenter = UIScreen.main.bounds.width / 2
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            switch to {
            case .left:
                if self.center.x == screenCenter {
                    self.center.x -= self.swipeShift
                }
            case .right:
                if self.center.x < screenCenter {
                    self.center.x += self.swipeShift
                }
            }
        } completion: { (_) in
            if self.center.x < screenCenter {
                self.presenter.headerInEditMode(yMin: Float(self.frame.minY), yMax: Float(self.frame.maxY))
            }
        }
        self.layoutIfNeeded()
    }
    
    @objc private func onSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            swipeWithAnimation(to: .right)
        }
        if gesture.direction == .left {
            swipeWithAnimation(to: .left)
        }
    }
    
    @objc private func onTap() {
        UIView.animate(withDuration: 0.3) {
            self.arrow.transform = CGAffineTransform(rotationAngle: self.isExpanded ? .pi : (.pi*2))
            self.isExpanded = !self.isExpanded
        }
        self.presenter.buttonOnTap()
    }
    
    @objc func onEditTap() {
        presenter.onEditTap()
    }
    
    private func prepareAdditionalViews() {
        let edit = UIButton(frame: CGRect(x: self.bounds.maxX - 1, y: 0, width: swipeShift, height: self.bounds.height - 1.5))
        edit.isUserInteractionEnabled = true
        edit.backgroundColor = .systemGray3
        edit.setTitle(R.string.localizable.editLabel(), for: .normal)
        edit.titleLabel?.font = .systemFont(ofSize: 15)
        self.addSubview(edit)
        edit.addTarget(self, action: #selector(onEditTap), for: .touchUpInside)
    }
}
