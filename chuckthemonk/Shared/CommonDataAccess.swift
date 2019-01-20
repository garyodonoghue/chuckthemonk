//
//  CommonDataAccess.swift
//  chuckthemonk
//
//  Created by Gary O'Donoghue on 20/01/2019.
//  Copyright © 2019 Gary O'Donoghue. All rights reserved.
//

import Alamofire

class CommonDataAccess {
    
    public func getImage(byUrl url: String, completion : @escaping (Data) -> Void){
        AF.request(url).response { response in
            completion(response.data!)
        }
    }
}
