import XCTest

class MovieQuizUITests: XCTestCase {
   
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil
    }
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testYesButton() {
        sleep(2)
        let poster = XCUIApplication().images["Poster"]
        let screenshotBefore = poster.screenshot()
        app.buttons["Yes"].tap()
        sleep(2)
        let screenshotAfter = poster.screenshot()
        let indexLabel = app.staticTexts["Index"]
        
        sleep(2)
        
        XCTAssertEqual(indexLabel.label, "2/10")
        XCTAssertNotEqual(screenshotBefore.pngRepresentation, screenshotAfter.pngRepresentation)
    }
    
    func testNoButton() {
        sleep(2)
        let poster = XCUIApplication().images["Poster"]
        let screenshotBefore = poster.screenshot()
        app.buttons["No"].tap()
        sleep(2)
        let screenshotAfter = poster.screenshot()
        let indexLabel = app.staticTexts["Index"]
        
        sleep(2)
        
        XCTAssertEqual(indexLabel.label, "2/10")
        XCTAssertNotEqual(screenshotBefore.pngRepresentation, screenshotAfter.pngRepresentation)
    }
    
    func testGameFinish() {
        sleep(2)
        for _ in 0..<10 {
            app.buttons["No"].tap()
            sleep(2)
        }
        
        let alert = app.alerts.firstMatch
        
        XCTAssertTrue(alert.exists)
        XCTAssertEqual(alert.label, "Этот раунд окончен!")
        XCTAssertEqual(alert.buttons.firstMatch.label, "Сыграть ещё раз")
    }
    
    func testAlertDismiss() {
        sleep(2)
        for _ in 0..<10 {
            app.buttons["No"].tap()
            sleep(2)
        }
        
        let alert = app.alerts.firstMatch
        alert.buttons.firstMatch.tap()
        
        sleep(2)
        
        XCTAssertFalse(alert.exists)
        XCTAssertEqual(app.staticTexts["Index"].label, "1/10")
    }
}

