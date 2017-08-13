//
//  Response.swift
//  OctoHub
//
//  Created by Медведь Святослав on 13.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

enum Response<T: Decodable> {
    case success(T)
    case failure(String)
}
