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
    
    enum UserResponse {
        case success(User)
        case failure(String)
    }
    
    func me(completion: @escaping (_ response: UserResponse) -> Void) {
        Alamofire.request(userUrl, parameters: ["access_token": token]).responseData { response in
            if response.result.isSuccess, let data = response.result.value {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(UserResponse.success(user))
                } catch {
                    completion(UserResponse.failure("Something went wrong"))
                }
            } else {
                completion(UserResponse.failure("Something went wrong"))
            }
        }
    }
    
    static func createAuth(from login: String, and password: String, completion: @escaping (String?) -> Void) {
        let encodedCredentials = Data("\(login):\(password)".utf8).base64EncodedString().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let headers: HTTPHeaders = ["Content-Type": "application/json", "Accept": "application/json", "Authorization": "Basic \(encodedCredentials)"]
        var accessToken: String?
        
        Alamofire.request(authorizationsUrl, method: .post, parameters: authParams, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let data = response.result.value as? Dictionary<String, Any>, let tokenData = data["token"] as? String {
                do {
                    try Locksmith.saveData(data: ["token": tokenData], forUserAccount: "octoHubUser")
                } catch {
                    print("Something wrong with storing token into Locksmith")
                }
                accessToken = tokenData
            }
            completion(accessToken)
        }
    }
}

