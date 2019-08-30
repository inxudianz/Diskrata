//
//  PhysicsCategory.swift
//  Diskrata
//
//  Created by William Inx on 30/08/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import Foundation

struct  PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let player: UInt32 = 0b01
    static let enemy: UInt32 = 0b10
    static let projectile: UInt32 = 0b11
}
