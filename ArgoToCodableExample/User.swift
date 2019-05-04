//
//  User.swift
//  Codable_test
//
//  Created by Eleni Papanikolopoulou on 01/05/2019.
//  Copyright © 2019 Eleni Papanikolopoulou. All rights reserved.
//

import UIKit
import Argo
import Curry
import Runes

struct User {
    let first: String?                 //optional with value
    let last: String?                  //optional with wrong key
    let headline: String?              //optional with null
    let isEmployee: Bool               // boolean
    let employeeLevel: EmployeeLevel     //enum
    let socialProfiles: [SocialProfile]    //array
    let friendId: Int                       //nested property
}

extension User: Swift.Decodable {}
extension User: ArgoSwiftDecodableCompatible {
    static func decode(_ json: JSON) -> Decoded<User> {
        return curry(self.init)
            <^> json <|? "firstname"
            <*> json <|? "lastname"
            <*> json <|? "headline"
            <*> json <| "isEmployee"
            <*> json <| "employee_level"
            <*> json <|| "social_profiles"
            <*> json <| ["friends", "id"]
    }
}

enum EmployeeLevel: String {
    case senior
    case intermediate
    case junior
}

extension EmployeeLevel: Argo.Decodable {}

extension EmployeeLevel: Swift.Decodable {}

struct SocialProfile: Swift.Decodable, SwiftArgoDecodableCompatible {
    let type: String
    let url: String
    let username: String?
    let name: String?
}

//extension SocialProfile: Argo.Decodable {
//    static func decode(_ json: JSON) -> Decoded<SocialProfile> {
//        return curry(self.init)
//            <^> json <| "type"
//            <*> json <| "url"
//            <*> json <|? "username"
//            <*> json <|? "name"
//    }
//}


