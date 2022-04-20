//
//  Model.swift
//  lesson 4 Collection
//
//  Created by Alexander Myskin on 10.04.2022.
//

import Foundation

// MARK: FakeData
struct Items: Hashable {
    var uuid: String
    var title: String
    var label: String
}

struct HeadModel: Hashable {
    var title: String
}

final class DummyData {
    static func makeDummyItems() -> [Items] {
        var dummyData: [Items] = []
        for i in 0...Int.random(in: 2...5) {
            dummyData.append(Items(
                uuid: NSUUID().uuidString,
                title: "Titile \(i)",
                label: "label \(i+1)")
            )
        }
        return dummyData
    }

    static func makeDummyHead() -> [HeadModel] {
        var dummyHead: [HeadModel] = []
        for j in 0...Int.random(in: 4...5) {
            dummyHead.append(HeadModel(title: "Head \(j)"))
        }
        return dummyHead
    }
}
