//
//  ImageManager.swift
//  HoodieHooShowcase
//
//  Created by Umair Ahmad on 20/01/23.
//

import Foundation

class ImageManager {
    
    static let shared = ImageManager()
    
    var lastSelectedImage = ""
    var secondLastSelectedImage = ""
    
    private init() {}
    
    func setLastSelectedImage(image: String) {
        self.lastSelectedImage = image
    }
    
    func setSecondLastSelectedImage(image: String) {
        self.secondLastSelectedImage = image
    }
    
    func getLastSelectedImage() -> String {
        return self.lastSelectedImage
    }
    
    func getSecondLastSelectedImage() -> String {
        return self.secondLastSelectedImage
    }
    
    func setImages(image: String) {
        if ImageManager.shared.getLastSelectedImage() == "" {
            ImageManager.shared.setLastSelectedImage(image: image)
        } else {
            ImageManager.shared.setSecondLastSelectedImage(image: ImageManager.shared.getLastSelectedImage())
            ImageManager.shared.setLastSelectedImage(image: image)
        }
    }
    
    func clearSelectedImages() {
        ImageManager.shared.setLastSelectedImage(image: "")
        ImageManager.shared.setSecondLastSelectedImage(image: "")
    }
}
