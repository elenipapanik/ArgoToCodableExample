//
//  UserSpec.swift
//  Codable_testTests
//
//  Created by Eleni Papanikolopoulou on 01/05/2019.
//  Copyright © 2019 Eleni Papanikolopoulou. All rights reserved.
//

import Quick
import Nimble
import Argo
@testable import ArgoToCodableExample

class UserListSpec: QuickSpec {
    override func spec() {
        describe("User") {
            context("When initialized with a valid user json") {
                let json = jsonInFileWithName("userList")
                let jsonData = json.data(using: .utf8)!

                it("gets decoded correctly from json") {
                    expect{ try JSONDecoder().decode(UserList.self, from: jsonData) }.toNot(beNil())
                    expect{ try JSONDecoder().decode(UserList.self, from: jsonData).id }.to(equal(0))
                    expect{ try JSONDecoder().decode(UserList.self, from: jsonData).users }.to(haveCount(2))
                }
            }
        }
    }
}
