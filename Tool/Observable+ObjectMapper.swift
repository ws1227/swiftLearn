//
//  Observable+ObjectMapper.swift
//  RxSwiftMoya
//
//  Created by Chao Li on 9/20/16.
//  Copyright © 2016 ERStone. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
import Result
extension Observable {
    func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            guard (dict["code"] as?Int) != nil else{
                throw RxSwiftMoyaError.ParseJSONError
           }
   
            if let error = self.parseError(response: dict) {
                throw error
            }
   
            
            return Mapper<T>().map(JSON: dict)!
        }
    }
    
    func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            guard let array = response as? [Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            guard let dicts = array as? [[String: Any]] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            guard (dict["status"] as?Int) != nil else{
                throw RxSwiftMoyaError.OtherError
            }
            if let error = self.parseError(response: dict) {
                throw error
            }

            return Mapper<T>().mapArray(JSONArray: dicts)
        }
    }
    
    func parseServerError() -> Observable {
        return self.map { (response) in
            let name = type(of: response)
            print(name)
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            if let error = self.parseError(response: dict) {
                throw error
            }
            return self as! Element
        }
        
    }
    
    fileprivate func parseError(response: [String: Any]?) -> NSError? {
        var error: NSError?
        if let value = response {
             var code:Int?
          
         
            if let codes = value["code"] as?Int
            {
                code = codes
                
            }
            if  code != 200 {
                var msg = ""
                if let message = value["message"] as? String {
                    msg = message
                }
                error = NSError(domain: "Network", code: code!, userInfo: [NSLocalizedDescriptionKey: msg])
            }
        }
        return error
    }
    
   
}




enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error {

    
}
