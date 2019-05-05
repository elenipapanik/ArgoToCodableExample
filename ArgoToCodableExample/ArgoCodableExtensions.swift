//
//  ArgoCodableExtensions.swift
//  ArgoToCodableExample
//
//  Created by Eleni Papanikolopoulou on 04/05/2019.
//  Copyright © 2019 Eleni Papanikolopoulou. All rights reserved.
//

import Argo
import Curry
import Runes
import Ogra

// for models that are ALREADY Swift.Decodable and want to be used inside an Argo decodable object
protocol SwiftArgoDecodableCompatible: Argo.Decodable, Swift.Decodable where Self.DecodedType == Self {}

extension SwiftArgoDecodableCompatible {
    static func decode(_ json: JSON) -> Decoded<DecodedType> {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json.JSONObject(), options: [])
            let decodedValue = try JSONDecoder().decode(Self.self, from: jsonData)
            return .success(decodedValue)
        } catch {
             return Decoded.failure(DecodeError.custom("Argo decoding error"))
        }
    }
}

// For models that are ALREADY Argo decodable and want to be used inside Swift decodable object
protocol ArgoSwiftDecodableCompatible: Argo.Decodable where Self.DecodedType == Self, Self: Swift.Decodable{}

extension ArgoSwiftDecodableCompatible {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let payload = try container.decode([String: Argo.JSON].self)
        let json = JSON.object(payload)
        self = try Self.decode(json).dematerialize()
    }
}

extension Argo.JSON: Swift.Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode(Int.self) {
            self = JSON.number(value as NSNumber)
        } else if let value = try? container.decode(Double.self) {
            self = JSON.number(value as NSNumber)
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode([String: Argo.JSON].self) {
            self = .object(value)
        } else if let value = try? container.decode([Argo.JSON].self) {
            self = .array(value)
        } else if container.decodeNil() {
            self = .null
        } else {
            throw DecodingError.typeMismatch(JSON.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not a JSON"))
        }
    }
}

extension Swift.Decodable {

    static func decode<T: Swift.Decodable>(from jsonString: String) throws -> T {
        guard let jsonData = jsonString.data(using: .utf8) else { throw ParsingError.invalidJson }
        let myModel = try JSONDecoder().decode(T.self, from: jsonData)
        return myModel
    }
}

enum ParsingError: Error {
    case dateParsingError
    case invalidJson
    case encodingError
    case dateEncodingError
}

