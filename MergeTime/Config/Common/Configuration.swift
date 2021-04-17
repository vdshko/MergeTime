//
//  Configuration.swift
//  MergeTime
//
//  Created by Vlad Shkodich on 17.04.2021.
//

import class Foundation.Bundle
import struct Foundation.Data
import class Foundation.PropertyListDecoder

struct Configuration: Codable {
    
    let name: String
}

extension Configuration {
    
    private enum Constants {
        
        static let plist = "plist"
        static let config = "Config"
    }
    
    static let `default`: Configuration! = Configuration(resource: Constants.config)
    
    private init?(resource name: String, in bundle: Bundle = .main) {
        guard let url = bundle.url(forResource: name, withExtension: Constants.plist),
              let data = try? Data(contentsOf: url),
              let propertyList = try? PropertyListDecoder().decode(Configuration.self, from: data) else {
            return nil
        }
        self = propertyList
    }
}
