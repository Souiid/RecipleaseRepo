//
//  YummlySessionFake.swift
//  RecipleaseTests
//
//  Created by Souissi idriss2 on 04/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

class YummlySessionFake: YummlySession {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
        super.init()
    }
    
    //request with different parameters from fakeResponse, request returns directly the completionHandler
    override func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        
        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: error)
        guard let url = URL(string: urlStringApi) else {return}
        let urlRequest = URLRequest(url: url)
        completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
    
}
