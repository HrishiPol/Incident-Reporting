//
//  ReportListViewController.swift
//  Incident Reporting
//
//  Created by Hrishikesh Pol on 18/6/20.
//  Copyright © 2020 Hrishikesh Pol. All rights reserved.
//

import UIKit
import RealmSwift

/// Class to show list of reported incident.
class ReportListViewController: UIViewController {
    
    /// Incident view model.
    var incidentViewModel: IncidentViewModel? = nil
    
    /// Array holds reported incidents.
    var listItems:  Results<Incident>? = nil
    
    /// Array holds search incidents.
    var searchItems: Results<Incident>? = nil
    
    /// Boolean to check if search is on.
    var isSearching = false
    
    /// List table view.
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.kListTitle.rawValue

        // Fetch list of reported incidents.
        incidentViewModel = IncidentViewModel.init()
        listItems = incidentViewModel?.getIncidentReportsList()
        
        // Register cell for tableview.
        listTableView.register(UINib.init(nibName: Constant.kListCellIdentifier.rawValue, bundle: nil), forCellReuseIdentifier: Constant.kListCellIdentifier.rawValue)
        
        // Hide unwanted empty lines.
        listTableView.tableFooterView = UIView()
        
        // Show search bar if any item exits.
        if listItems?.count ?? 0 > 0 {
            addSearchBar()
        }
    }
    
    /// Function to add search bar.
    private func addSearchBar() {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = Constant.kSearchPlaceHolder.rawValue
        searchBar.sizeToFit()
        listTableView.tableHeaderView = searchBar
    }
}

// MARK: UISearchBarDelegate methods.
extension ReportListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool {
        isSearching = true
        searchItems = incidentViewModel?.searchIncident(byMachineName: text)
        self.listTableView.reloadData()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if let text = searchBar.text {
            searchItems = incidentViewModel?.searchIncident(byMachineName: text)
            self.listTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        isSearching = false
        searchBar.text = ""
        self.listTableView.reloadData()
    }
}

// MARK: UITableViewDataSource and UITableViewDelegate methods.
extension ReportListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if isSearching {
            count = searchItems?.count ?? 0
        } else {
            count = listItems?.count ?? 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.kListCellIdentifier.rawValue, for: indexPath) as? ReportListTableViewCell
        var incident = Incident()
        if isSearching {
            incident = searchItems?[indexPath.row] ?? Incident()
        } else {
            incident = listItems?[indexPath.row] ?? Incident()
        }
        cell?.incidentIDLabel.text = incident.incidentID
        cell?.machineNameLabel.text = incident.machineName
        cell?.timeStampLabel.text = incident.timeStamp
        return cell ?? UITableViewCell()
    }
}
