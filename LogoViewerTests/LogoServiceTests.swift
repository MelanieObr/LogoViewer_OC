//
//  LogoServiceTests.swift
//  LogoViewerTests
//
//  Created by Mélanie Obringer on 30/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import LogoViewer



class LogoServiceTests: XCTestCase {
    

    func testGetLogoShouldFailedCallbackIfError() {
        let logoService = LogoService(logoSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Waiting for queue change.")
        
        logoService.getLogo(domain: "https://openclassrooms.com") { (success, logo) in
            XCTAssertFalse(success)
            XCTAssertNil(logo)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLogoShouldFailedCallbackIfNoData() {
        let logoService = LogoService(logoSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Waiting for queue change.")
        
        logoService.getLogo(domain: "https://openclassrooms.com") { (success, logo) in
            XCTAssertFalse(success)
            XCTAssertNil(logo)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLogoShouldFailedCallbackIfIncorrectData() {
        let logoService = LogoService(logoSession: URLSessionFake(
            data: FakeResponseData.logoIncorrectData,
            response: nil,
            error: nil))
        
        let expectation = XCTestExpectation(description: "Waiting for queue change.")
        
        logoService.getLogo(domain: "https://openclassrooms.com") { (success, logo) in
            XCTAssertFalse(success)
            XCTAssertNil(logo)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLogoShouldFailedCallbackIfIncorrectResponse() {
        let logoService = LogoService(logoSession: URLSessionFake(
            data: FakeResponseData.logoCorrectData,
            response: FakeResponseData.responseKO,
            error: nil))
        
        let expectation = XCTestExpectation(description: "Waiting for queue change.")
        
        logoService.getLogo(domain: "https://openclassrooms.com") { (success, logo) in
            XCTAssertFalse(success)
            XCTAssertNil(logo)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLogoShouldSuccessCallbackIfCorrectResponseAndData() {
        let logoService = LogoService(logoSession: URLSessionFake(
            data: FakeResponseData.logoCorrectData,
            response: FakeResponseData.responseOK,
            error: nil))

        let expectation = XCTestExpectation(description: "Waiting for queue change.")

        logoService.getLogo(domain: "https://openclassrooms.com") { (success, logo) in
            let logoImage = (try?
                Data(contentsOf: Bundle(for: LogoServiceTests.self).url(forResource: "logo", withExtension: "png")!))
                ?? Data()

            XCTAssertTrue(success)
            XCTAssertNotNil(logo)
            XCTAssertEqual(logoImage, logo!.imageData)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}
