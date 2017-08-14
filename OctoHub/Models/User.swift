//
//  User.swift
//  OctoHub
//
//  Created by Медведь Святослав on 12.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class User: Decodable {
    let id: UInt
    let name: String?
    let login: String
    let email: String?
    let bio: String?
    let company: String?
    let blog: String?
    let location: String?
    let followers: UInt64
    let following: UInt64
    
    private var avatarUrl: String?
    private let fallbackAvatar = UIImage(named: "stormtrooper.png")!
    
    lazy var avatar: UIImage = {
        return self.getAvatar(self.avatarUrl)
    }()
    
    enum CodingKeys: String, CodingKey {
        case id, name, login, email, bio, company, blog, location, followers, following
        case avatarUrl = "avatar_url"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UInt.self, forKey: .id)
        name = try? values.decode(String.self, forKey: .name)
        login = try values.decode(String.self, forKey: .login)
        avatarUrl = try? values.decode(String.self, forKey: .avatarUrl)
        email = try? values.decode(String.self, forKey: .email)
        bio = try? values.decode(String.self, forKey: .bio)
        company = try? values.decode(String.self, forKey: .company)
        blog = try? values.decode(String.self, forKey: .blog)
        location = try? values.decode(String.self, forKey: .location)
        followers = try values.decode(UInt64.self, forKey: .followers)
        following = try values.decode(UInt64.self, forKey: .following)
    }
    
    private func getAvatar(_ avatarUrl: String?) -> UIImage {
        if avatarUrl != nil, let imageUrl = URL(string: avatarUrl!) {
            do {
                let imageData = try Data(contentsOf: imageUrl)
                return UIImage(data: imageData)!
            } catch {
                return fallbackAvatar
            }
        }
        return fallbackAvatar
    }
}
