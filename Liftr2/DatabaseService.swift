//
//  DatabaseService.swift
//  Liftr2
//
//  Created by Connor Berry on 08/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import Foundation
import Firebase

class DatabaseService {
    
    
    static let shared = DatabaseService ()
    private init() {}
    
    let addExRef = Database.database().reference().child("addExer")
    let workNameRef = Database.database().reference().child("workName")
}
