//
//  Part.swift
//  garagee
//
//  Created by Jozef Matus on 22/04/2017.
//  Copyright © 2017 Jozef Matus. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import CoreData

struct Part {
    var id: String
    var code: String
    var name: String
    var warrantyDays: Int
}

extension Part: Persistable {
    
    public typealias T = NSManagedObject
    
    let pes = type(of: self)
    
    static var entityName: String = "Part"
    
    static var primaryAttributeName: String = "id"
    
    
    init(entity: T) {
        
    }
    
    func update(_ entity: NSManagedObject) {
        
    }
}
