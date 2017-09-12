//
//  StudySet.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/08/24.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import RealmSwift

class StudySet: Object {
    dynamic var title = String()
    dynamic var studySetID = String()
    dynamic var createdAt = String()
    
    override static func primaryKey() -> String? {
        return "studySetID"
    }
}
