//
//  AddExercise.swift
//  Liftr2
//
//  Created by Connor Berry on 08/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import Foundation

struct AddExer {

    let exerID: String
    let workName: String
    let message: String
    let date: Date

    init?(exerID: String, dict:[String: Any]) {
        self.exerID = exerID
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz "
        
        guard let workName = dict["workName"] as? String,
        let message = dict["message"] as? String,
        let dateString = dict["date"] as? String,
        let date = dateFormatter.date(from: dateString)
        else { return nil }
    
    self.workName = workName
    self.message = message
    self.date = date
    }
}
