//
//  UIImage+Resize.swift
//  Core
//
//  Created by Vlad Shkodich on 25.04.2021.
//
import UIKit

public extension UIImage {
    
    func resize(to newSize: CGSize) -> UIImage {
        let scale = min(newSize.width / size.width, newSize.height / size.height)
        let targetWidth = size.width * scale
        let targetHeight = size.height * scale
        let rect = CGRect(
            origin: CGPoint(x: (newSize.width - targetWidth) / 2, y: (newSize.height - targetHeight) / 2),
            size: CGSize(width: targetWidth, height: targetHeight)
        )
        
        return UIGraphicsImageRenderer(size: newSize).image { _ in draw(in: rect) }
    }
}
