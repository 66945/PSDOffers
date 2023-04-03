//
//  PSDOffersTests.swift
//  PSDOffersTests
//
//  Created by McGrath, Daniel - Student on 2/28/23.
//

import XCTest
@testable import PSDOffers

final class PSDOffersTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWriteJson() throws {
        let offers = [Offer(name: "Test", addresses: Optional(["1033 S Taft Hill Rd, Fort Collins, CO"]))]
        if let json = offers.json {
            if let s = String(data: json, encoding: .utf8) {
                print()
                print(s)
                print()
            }
        }
        
    }
    
    func testReadJson() throws {
        if let url = Bundle.main.url(forResource: "testOffers", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let nextOffers = try decoder.decode([Offer].self, from: jsonData)
                print(nextOffers)
            } catch {
                print("error:\(error)")
            }
        }
    }


    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
