//
//  HoodieHooShowcaseTests.swift
//  HoodieHooShowcaseTests
//
//  Created by Umair Ahmad on 20/01/23.
//

import XCTest
@testable import HoodieHooShowcase

final class HoodieHooShowcaseTests: XCTestCase {
    
    let imageManager = ImageManager.shared
    
    let mockImages = ["image1", "image2", "image3", "image4", "image5"]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        self.imageManager.clearSelectedImages()
    }
    
    func testLastSelectedImageIsEmpty() throws {
                
        XCTAssert(self.imageManager.getLastSelectedImage().isEmpty)
    }
    
    func testSecondLastSelectedImageIsEmpty() throws {
                
        XCTAssert(self.imageManager.getSecondLastSelectedImage().isEmpty)
    }

    func testLastSelectedImage() throws {
        
        self.imageManager.setImages(image: "image1")
        
        XCTAssert(self.imageManager.getLastSelectedImage() == "image1")
    }
    
    func testSecondLastSelectedImage() throws {
        
        self.imageManager.setImages(image: "image1")
        self.imageManager.setImages(image: "image2")
        
        XCTAssert(self.imageManager.getSecondLastSelectedImage() == "image1")
    }
    
    func testThreeImagesSelectedLastSelected() throws {
        
        self.imageManager.setImages(image: "image1")
        self.imageManager.setImages(image: "image2")
        self.imageManager.setImages(image: "image3")
        
        XCTAssert(self.imageManager.getLastSelectedImage() == "image3")
    }
    
    func testThreeImagesSelectedSecondLastSelected() throws {
        
        self.imageManager.setImages(image: "image1")
        self.imageManager.setImages(image: "image2")
        self.imageManager.setImages(image: "image3")
        
        XCTAssert(self.imageManager.getSecondLastSelectedImage() == "image2")
    }
}
