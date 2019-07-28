//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Souissi idriss2 on 04/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation

class FakeResponseData {

    //Correct recipe data in jsonFile
    static var recipeCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "Recipe", withExtension: "json") else {return nil}
        return try? Data(contentsOf: url)
    }
    
    //Correct recipeDescription data in jsonFile
    static var recipeDescriptionCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "Description", withExtension: "json") else {return nil}
        return try? Data(contentsOf: url)
    }
    
    //Incorrect data
    static let recipeIncorrectData = "erreur".data(using: .utf8)
    
    // Response correct and incorrect
    static var responseOK: HTTPURLResponse? {
        guard let url = URL(string: "https://test.com") else {return nil}
         let responseOK = HTTPURLResponse(
            url: url,
            statusCode: 200, httpVersion: nil, headerFields: [:])
        return responseOK
    }

    
    static var responseKO: HTTPURLResponse? {
        guard let url = URL(string: "https://test.com") else {return nil}
        let responseOK = HTTPURLResponse(
            url: url,
            statusCode: 500, httpVersion: nil, headerFields: [:])
        return responseOK
    }
    

    
    
    // MARK: - Error
    class TestError: Error {}
    static let error = TestError()

}
