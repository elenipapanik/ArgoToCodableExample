//
//  ArgoParsingExtensions.swift
//  ArgoToCodableExample
//
//  Created by Eleni Papanikolopoulou on 04/05/2019.
//  Copyright © 2019 Eleni Papanikolopoulou. All rights reserved.
//

import Argo
import Foundation
import Runes

extension JSON {
    init(fileName: Swift.String) {
        let string = try! JSONSerialization.jsonObject(with: NSData(contentsOfFile: (Bundle.currentTestBundle!.path(forResource: fileName, ofType: "json"))!)! as Data, options: [])
        self = JSON(string)
    }
}
extension Bundle {
    static var currentTestBundle: Bundle? {
        print(allBundles)
        return allBundles.lazy
            .first {
                $0.bundlePath.hasSuffix(".xctest")
        }
    }
}

public func jsonInFileWithName(_ name: String) -> String {
    let data = try! Data(contentsOf: URL(fileURLWithPath: Bundle.currentTestBundle!.path(forResource: name, ofType: "json")!))
    let jsonString = String(data: data, encoding: .utf8)!
    return jsonString
}


