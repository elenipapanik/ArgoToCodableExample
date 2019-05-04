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
                var userList: UserList!

                beforeEach {
                    userList = try! UserList.decode(from: json)
                }

                it("gets decoded correctly from json") {
                    expect(userList).toNot(beNil())
                    expect(userList.id).to(equal(0))
                    expect(userList.users).to(haveCount(2))
                }
            }
        }
    }
}
