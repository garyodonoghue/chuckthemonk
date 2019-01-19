//
//  DataAccessLayer.swift
//  chuckthemonk
//
//  Created by Gary O'Donoghue on 19/01/2019.
//  Copyright © 2019 Gary O'Donoghue. All rights reserved.
//

import Foundation
import Alamofire

public class DataAccessLayer {
    
    Alamofire.request("https://httpbin.org/get").responseJSON { response in
    print("Request: \(String(describing: response.request))")   // original url request
    print("Response: \(String(describing: response.response))") // http url response
    print("Result: \(response.result)")                         // response serialization result
    
    if let json = response.result.value {
    print("JSON: \(json)") // serialized json response
    }
    
    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
    print("Data: \(utf8Text)") // original server data as UTF8 string
    }
    }
    
}