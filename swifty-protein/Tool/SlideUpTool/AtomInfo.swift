//
//  AtomInfo.swift
//  swifty-protein
//
//  Created by Kristine Sonu on 1/17/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import Foundation

struct Elements : Decodable {
    let name: String?
    let symbol: String
    let number: Int?
    let melt: Double?
    let boil: Double?
    let density: Double?
    let atomic_mass: Double?
    let category: String?
    let discovered_by: String?
    let period: Int?
    let phase: String?
    let molar_heat: Double?
}

class GetAtomInfo {
    func getAtomInfo() -> [Elements]? {
        var data:[Elements]? = nil
        if let path = Bundle.main.path(forResource: "PTJSON", ofType: "json") {
            do {
                let result = try Data(contentsOf: URL(fileURLWithPath: path))
                data = try JSONDecoder().decode([Elements].self, from: result)
                return data
            }
            catch {
                print("error reading json file")
            }
        }
        return data
    }
}
