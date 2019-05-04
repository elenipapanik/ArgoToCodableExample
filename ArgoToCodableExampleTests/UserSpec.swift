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

class UserSpec: QuickSpec {
    override func spec() {
        describe("User") {
            context("When initialized with a valid user json") {
                let json = JSON(fileName: "user")
                var user: User!

                beforeEach {
                    user = User.decode(json).value
                }

                it("gets decoded correctly from json") {
                    expect(user).toNot(beNil())
                    expect(user.first).to(equal("Wayne"))
                }
            }
        }
    }
}
