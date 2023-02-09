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
        sleep(3)
        let firstPoster = app.images["Poster"]
        app.buttons["Yes"].tap()
        sleep(3)
        let secondPoster = app.images["Poster"]
        
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        let secondPosterData = secondPoster.screenshot().pngRepresentation
        
        let indexLabel = app.staticTexts["Index"]
        
        XCTAssertNotEqual(firstPosterData, secondPosterData)
        XCTAssertEqual(indexLabel.label, "2/10")
    }
    
    func testNoButton() {
        sleep(3)
        let firstPoster = app.images["Poster"]
        app.buttons["No"].tap()
        sleep(3)
        let secindPoster = app.images["Poster"]
        
        let fistPosterData = firstPoster.screenshot().pngRepresentation
        let secondPosterData = secindPoster.screenshot().pngRepresentation
        
        let indexLabel = app.staticTexts["Index"]
        
        XCTAssertEqual(fistPosterData, secondPosterData)
        XCTAssertEqual(indexLabel.label, "2/10")
    }
    
    func testGameFinish() {
        sleep(2)
        while app.staticTexts["Index"].label != "10/10" {
            app.buttons["No"].tap()
        }
        sleep(2)
        
        let alert = app.alerts.firstMatch
        
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(alert.label == "Этот раунд окончен!")
        XCTAssertTrue(alert.buttons.firstMatch.label == "Сыграть ещё раз")
    }
    
    func testAlertDismiss() {
        sleep(2)
        while app.staticTexts["Index"].label != "10/10" {
            app.buttons["No"].tap()
        }
        sleep(2)
        
        
        let alert = app.alerts.firstMatch
        alert.buttons.firstMatch.tap()
        
        XCTAssertFalse(alert.exists)
        XCTAssertTrue(app.staticTexts["Index"].label == "1/10")
    }
}
