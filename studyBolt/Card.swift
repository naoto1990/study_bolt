//
//  Card.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/08/24.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import RealmSwift

class Card: Object {
    dynamic var studySetID: String?
    dynamic var term: String?
    dynamic var definition: String?

}
