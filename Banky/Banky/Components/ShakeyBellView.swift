//
//  ShakeyBellView.swift
//  Banky
//
//  Created by Candi Chiu on 09.04.23.
//

import Foundation
import UIKit

class ShakeyBellView : UIView {
    
    let imageView = UIImageView()
    let buttomView = UIButton()
    let buttomHeight: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
        
    }
    
}

extension ShakeyBellView {
    
    func setup() {
        // Make the bell tappable
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_: )))
        imageView.addGestureRecognizer(singleTap)
        imageView.isUserInteractionEnabled = true
    }
    
    func style() {
        
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bell.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.image = image
        
        buttomView.translatesAutoresizingMaskIntoConstraints = false
        buttomView.layer.cornerRadius = buttomHeight/2
        buttomView.backgroundColor = .systemRed
        buttomView.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        buttomView.setTitle("9", for: .normal)
        buttomView.setTitleColor(.white, for: .normal)
    }
    
    func layout() {
        addSubview(imageView)
        addSubview(buttomView)
        
        // imageView
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
            
        ])
        
        // ButtonView
        NSLayoutConstraint.activate([
            buttomView.topAnchor.constraint(equalTo: imageView.topAnchor),
            buttomView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -9),
            buttomView.heightAnchor.constraint(equalToConstant: 16),
            buttomView.widthAnchor.constraint(equalToConstant: 16)
            
        ])
    }
    
}

// MARK: Actions
extension ShakeyBellView {
    
    @objc func imageViewTapped(_ regoniser: UITapGestureRecognizer ) {
        shakeWith(duration: 1, angle: .pi/8, yOffset: 0)
    }
    
    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        let numberOfFrames: Double = 6
        let frameDuration: Double = 1/numberOfFrames
        
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*2, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*3, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*4, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*5, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform.identity
            }
            
        }, completion: nil)
        
    }
}

// https://www.hackingwithswift.com/example-code/calayer/how-to-change-a-views-anchor-point-without-moving-it
extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}
