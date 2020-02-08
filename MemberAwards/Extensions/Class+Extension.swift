//
//  Class+Extension.swift
//  MemberAwards
//
//  Created by Chris Ferdian on 08/02/20.
//  Copyright © 2020 Chrizers. All rights reserved.
//

import Foundation
public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
