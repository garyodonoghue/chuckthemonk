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
    
    var comics : [Comic]? = nil
    
    public func getArchived(completion: @escaping ([Comic]) -> Void) {
        AF.request("https://chuck-the-monk.firebaseio.com/archives.json").responseDecodable { (response: DataResponse<[Comic]>) in
            self.comics = response.result.value
            completion(self.comics!)
        }
    }
}
