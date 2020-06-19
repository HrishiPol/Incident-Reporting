//
//  ReportListTableViewCell.swift
//  Incident Reporting
//
//  Created by Hrishikesh Pol on 19/6/20.
//  Copyright © 2020 Hrishikesh Pol. All rights reserved.
//

import UIKit

/// Tableview cell to show incident report details.
class ReportListTableViewCell: UITableViewCell {

    @IBOutlet weak var machineNameLabel: UILabel!
    @IBOutlet weak var incidentIDLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
