//
//  GithubAuthService.swift
//  OctoHub
//
//  Created by Медведь Святослав on 01.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit
import Alamofire
import Locksmith
import Octokit

struct GithubAuthService {
    static let baseApiUrl = "https://api.github.com"
    static let authorizationsUrl = "\(baseApiUrl)/authorizations"
    static let params: Parameters = ["scopes": ["repo", "read:org"], "note": "OctoHub"]
    
    static func authentificate(with token: String) -> TokenConfiguration {
        return TokenConfiguration(token)
    }
    
    static func createNewAuthentification(from login: String, and password: String, completion: @escaping (TokenConfiguration?) -> Void) {
        let encodedCredentials = Data("\(login):\(password)".utf8).base64EncodedString().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let headers: HTTPHeaders = ["Content-Type": "application/json", "Accept": "application/json", "Authorization": "Basic \(encodedCredentials)"]
        var config: TokenConfiguration?
        
        Alamofire.request(authorizationsUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let data = response.result.value as? Dictionary<String, Any>, let token = data["token"] as? String {
                do {
                    try Locksmith.saveData(data: ["token": token], forUserAccount: "octoHubUser")
                } catch {
                    print("Something wrong with storing token into Locksmith")
                }
                config = authentificate(with: token)
            }
            completion(config)
        }
    }
}
