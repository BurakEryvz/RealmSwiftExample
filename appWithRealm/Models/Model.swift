//
//  Model.swift
//  appWithRealm
//
//  Created by Burak Eryavuz on 11.07.2023.
//

import Foundation
import RealmSwift

class Model : Object {
    
    @Persisted var name : String = ""
    @Persisted var releaseDate : String = ""
    
    @Persisted(originProperty: "models") var assignee : LinkingObjects<Brand>
}
