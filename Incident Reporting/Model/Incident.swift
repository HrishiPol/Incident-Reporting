//
//  Incident.swift
//  Incident Reporting
//
//  Created by Hrishikesh Pol on 18/6/20.
//  Copyright © 2020 Hrishikesh Pol. All rights reserved.
//

import RealmSwift
import Foundation

/// Incident entity.
class Incident: Object {
    
    /// Primary key for incident.
    @objc dynamic var id : Int = 0
    
    /// Incident ID.
    @objc dynamic var incidentID: String = UUID().uuidString
    
    /// Represet the fault machine name.
    @objc dynamic var machineName: String = ""
    
    /// Location of faulty machine.
    @objc dynamic var locationName: String = ""
    
    /// Timestamp when incident reported.
    @objc dynamic var timeStamp: String = ""
    
    /// Short description about incident.
    @objc dynamic var shortDescription: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

