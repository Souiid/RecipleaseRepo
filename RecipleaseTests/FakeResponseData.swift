//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Souissi idriss2 on 04/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation

class FakeResponseData {

    static var recipeCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let recipeIncorrectData = "erreur".data(using: .utf8)!
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://test.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://test.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    
    // MARK: - Error
    class TestError: Error {}
    static let error = TestError()

}
