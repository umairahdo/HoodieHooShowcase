//
//  HoodieHooShowcaseUITests.swift
//  HoodieHooShowcaseUITests
//
//  Created by Umair Ahmad on 20/01/23.
//

import XCTest

final class HoodieHooShowcaseUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        app.launch()
    }
    
    func testNoImageSelected() throws {
        
        app.tabBars["Tab Bar"].buttons["lastSelectedImageTab"].tap()
        app.staticTexts["No image available"].tap()
    }

    func testLastImageSelected() throws {
        
        app.tables["imageTableView"]/*@START_MENU_TOKEN@*/.staticTexts["https://m.media-amazon.com/images/I/51HNDClw2bL._AC_.jpg"]/*[[".cells.staticTexts[\"https:\/\/m.media-amazon.com\/images\/I\/51HNDClw2bL._AC_.jpg\"]",".staticTexts[\"https:\/\/m.media-amazon.com\/images\/I\/51HNDClw2bL._AC_.jpg\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts.scrollViews.otherElements.buttons["Ok"].tap()
        app.tabBars["Tab Bar"]/*@START_MENU_TOKEN@*/.buttons["lastSelectedImageTab"]/*[[".buttons[\"Last Selected Image\"]",".buttons[\"lastSelectedImageTab\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.staticTexts["https://m.media-amazon.com/images/I/51HNDClw2bL._AC_.jpg"].tap()
    }
    
    func testSecondLastImageSelected() throws {
        
        let imagetableviewTable = app.tables["imageTableView"]
        imagetableviewTable/*@START_MENU_TOKEN@*/.staticTexts["https://m.media-amazon.com/images/I/51HNDClw2bL._AC_.jpg"]/*[[".cells.staticTexts[\"https:\/\/m.media-amazon.com\/images\/I\/51HNDClw2bL._AC_.jpg\"]",".staticTexts[\"https:\/\/m.media-amazon.com\/images\/I\/51HNDClw2bL._AC_.jpg\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let okButton = app.alerts.scrollViews.otherElements.buttons["Ok"]
        okButton.tap()
        imagetableviewTable/*@START_MENU_TOKEN@*/.staticTexts["http://archive.boston.com/business/blogs/global-business-hub/ocean-wave.jpg"]/*[[".cells.staticTexts[\"http:\/\/archive.boston.com\/business\/blogs\/global-business-hub\/ocean-wave.jpg\"]",".staticTexts[\"http:\/\/archive.boston.com\/business\/blogs\/global-business-hub\/ocean-wave.jpg\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        okButton.tap()
        app.tabBars["Tab Bar"]/*@START_MENU_TOKEN@*/.buttons["secondLastSelectedImageTab"]/*[[".buttons[\"Second Last Selected Image\"]",".buttons[\"secondLastSelectedImageTab\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["https://m.media-amazon.com/images/I/51HNDClw2bL._AC_.jpg"]/*[[".cells.staticTexts[\"https:\/\/m.media-amazon.com\/images\/I\/51HNDClw2bL._AC_.jpg\"]",".staticTexts[\"https:\/\/m.media-amazon.com\/images\/I\/51HNDClw2bL._AC_.jpg\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
