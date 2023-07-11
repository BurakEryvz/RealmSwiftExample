//
//  Brand.swift
//  appWithRealm
//
//  Created by Burak Eryavuz on 11.07.2023.
//

import Foundation
import RealmSwift

class Brand : Object {
    @Persisted var name : String = ""
    
    @Persisted var models : List<Model>
}
