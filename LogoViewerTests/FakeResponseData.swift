//
//  FakeResponseData.swift
//  LogoViewerTests
//
//  Created by Mélanie Obringer on 30/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Data
    static var logoCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "logo", withExtension: "png")!
        
       return (try? Data(contentsOf: url)) ?? Data()
    }
    
    static let logoIncorrectData = "error".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Error
    class LogoError: Error {}
    static let error = LogoError()
}
