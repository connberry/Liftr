//
//  DataService.swift
//  Liftr2
//
//  Created by Connor Berry on 04/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import KeychainSwift

let DB_BASE = Database.database().reference()

class DataService {
    private var _Keychain = KeychainSwift()
    private var _refDatabase = DB_BASE
    
    var Keychain: KeychainSwift {
        get {
            return _Keychain
        } set {
            _Keychain = newValue
        }
    }
}

