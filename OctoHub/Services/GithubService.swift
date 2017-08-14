//
//  GithubService.swift
//  OctoHub
//
//  Created by Медведь Святослав on 12.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import Locksmith

struct GithubService {
    let token: String
    static let baseApiUrl = "https://api.github.com"
    static let authorizationsUrl = "\(baseApiUrl)/authorizations"
    static let authParams: Parameters = ["scopes": ["repo", "read:org"], "note": "OctoHub"]
    let userUrl = "\(baseApiUrl)/user"
    
    init(_ token: String) {
        self.token = token
    }
    
    func me(completion: @escaping (_ response: Response<User>) -> Void) {
        Alamofire.request(userUrl, parameters: ["access_token": token]).responseData { response in
            if response.result.isSuccess, let data = response.result.value {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(Response.success(user))
                } catch {
                    completion(Response.failure("Something went wrong"))
                }
            } else {
                completion(Response.failure("Something went wrong"))
            }
        }
    }
    
    static func createAuth(from login: String, and password: String, completion: @escaping (_ response: ResponseAuth) -> Void) {
        let encodedCredentials = Data("\(login):\(password)".utf8).base64EncodedString().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let headers: HTTPHeaders = ["Content-Type": "application/json", "Accept": "application/json", "Authorization": "Basic \(encodedCredentials)"]
        
        Alamofire.request(authorizationsUrl, method: .post, parameters: authParams, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if response.result.isSuccess, let data = response.value as? Dictionary<String, Any>, let accessToken = data["token"] as? String {
                do {
                    try Locksmith.saveData(data: ["token": accessToken], forUserAccount: "octoHubUser")
                } catch {
                    print("Something wrong with storing token into Locksmith")
                }
                completion(ResponseAuth.success(accessToken))
            } else {
                if let data = response.value as? Dictionary<String, Any>, let message = data["message"] as? String {
                    completion(ResponseAuth.failure(message))
                } else {
                    completion(ResponseAuth.failure("Something went wrong"))
                }
            }
        }
    }
}

