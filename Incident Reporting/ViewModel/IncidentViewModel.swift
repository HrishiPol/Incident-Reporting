//
//  IncidentViewModel.swift
//  Incident Reporting
//
//  Created by Hrishikesh Pol on 18/6/20.
//  Copyright © 2020 Hrishikesh Pol. All rights reserved.
//

import RealmSwift
import Foundation

/// Enum for incident.
enum IncidentStatus {
    case valid
    case invalid
}

typealias IncidentValidateCompletionClosure = (_ status: IncidentStatus) -> Void
typealias IncidentSubmitCompletionClosure = (_ error: String) -> Void

/// Viewmodel for Reports module.
class IncidentViewModel {
    
    /// Realm database object.
    var realm : Realm!
    
    /// Init method.
    init() {
        realm = try! Realm()
    }
    
    /// Method to validate incident report.
    /// - Parameters:
    ///   - name: Machine name.
    ///   - location: Location details.
    ///   - description: Description details.
    ///   - completionHanlder: Handler on validation.
    func validate(_ name: String, _ location: String, _ description: String, completionHanlder: @escaping IncidentValidateCompletionClosure) {
        
        /// Check for non empty entry..
        if name.count <= 0 || location.count <= 0 || description.count <= 0 {
            completionHanlder(IncidentStatus.invalid)
        } else {
            completionHanlder(IncidentStatus.valid)
        }
    }
    
    
    /// Method to submit report and save it to local database.
    /// - Parameters:
    ///   - name: Machine name
    ///   - location: location details.
    ///   - shortDescription: short description.
    ///   - timeStamp: Timestamp details.
    ///   - completionHandler: Handler on submit.
    func submit( _ name: String,
                 _ location: String,
                 _ shortDescription: String,
                 _ timeStamp: String,
                 completionHandler: @escaping IncidentSubmitCompletionClosure) {
        
        // Save to local database.
        let newIncdident = create(withName: name,
                                  locationName: location,
                                  timeStamp: timeStamp,
                                  shortDescription: shortDescription)
        
        do {
            try realm.write {
                realm.add(newIncdident)
                completionHandler("")
            }
        } catch let error as NSError {
            // handle error
            completionHandler(error.localizedDescription)
        }
    }
    
    /// Method to retrive reported incidents.
    /// - Returns: List of reported incidents.
    func getIncidentReportsList() -> Results<Incident> {
        let incidentList = realm.objects(Incident.self)
        return incidentList
    }
    
    /// Method to search particular incident by machine name.
    /// - Parameter name: Machine name
    /// - Returns: List of incidents matching search text.
    func searchIncident(byMachineName name: String) -> Results<Incident> {
        let incident = realm.objects(Incident.self).filter("machineName contains %@", name)
        return incident
    }
    
    /// Method to create incident entity.
    /// - Parameters:
    ///   - machineName: Machine name.
    ///   - locationName: Location details.
    ///   - timeStamp: Timestamp details.
    ///   - shortDescription: Incident short description.
    /// - Returns: Incident entity.
    func create(withName machineName: String,
                locationName: String,
                timeStamp: String,
                shortDescription: String) -> Incident {
        // Retrive last primary key
        let lastID = realm.objects(Incident.self).map{$0.id}.last ?? 0
        
        let incident = Incident()
        incident.id = lastID + 1 // Incremental primary key.
        incident.machineName = machineName
        incident.locationName = locationName
        incident.timeStamp = timeStamp
        incident.shortDescription = shortDescription
        return incident
    }
}
