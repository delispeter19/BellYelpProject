//
//  ViewController.swift
//  yelpCloneProj
//
//  Created by Peter Delis on 2022-07-28.
//

import UIKit

protocol ViewControllerProtocol {
    func display(businessData: YelpBusiness)
}

class ViewController: UIViewController, ViewControllerProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter = ViewPresenter()
    
    var yelpData = YelpBusinesses()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presenter.controller = self
        
        // configure table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        
        // configure search bar
        searchBar.delegate = self
        searchBar.placeholder = "Search by business, location, cuisine..."
    }
    
    func display(businessData: YelpBusiness){
        let businessCardController = self.storyboard?.instantiateViewController(withIdentifier: "BusinessCardController") as! BusinessCardController
        let presenter = BusinessCardPresenter(controller: businessCardController,
                                               businessData: businessData)
        businessCardController.presenter = presenter
        self.present(businessCardController, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let cellValue = yelpData.businesses
        else { return 0 }
        
        return cellValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let business = yelpData.businesses![indexPath.row]
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = business.name
        cell.selectionStyle = .blue
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBusiness = yelpData.businesses![indexPath.row]
        
        guard let bId = selectedBusiness.id else {
            debugPrint("No ID")
            return
        }
        
        presenter.yelpAPISearchBusinessBy(id: bId){ business in
            DispatchQueue.main.async {
                self.display(businessData: business)
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        if let searchString = searchBar.text, !searchBar.text!.isEmpty {
            
            let params = presenter.determineAPISearchParameters(for: searchString)
            
            presenter.yelpAPISearchBusinessesBy(params){ response in
                DispatchQueue.main.async {
                    self.yelpData = response
                    self.tableView.reloadData()
                }
            }
            
            return
        }
    }
}
