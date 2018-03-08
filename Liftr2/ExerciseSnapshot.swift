//
//  ExerciseSnapshot.swift
//  Liftr2
//
//  Created by Connor Berry on 08/03/2018.
//  Copyright © 2018 Connor Berry. All rights reserved.
//

import Foundation
import Firebase

struct ExerSnapshot {
    
    
    let addExer: [AddExer]
    init?(with snapshot: DataSnapshot) {
        var addExer = [AddExer]()
        guard let snapDict = snapshot.value as? [String: [String: Any]] else { return nil }
        for snap in snapDict {
            guard let Exer = AddExer(exerID: snap.key, dict: snap.value) else { continue }
            addExer.append(Exer)
    }
    self.addExer = addExer
    }
}
