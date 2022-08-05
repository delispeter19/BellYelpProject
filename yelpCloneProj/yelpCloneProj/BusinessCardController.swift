//
//  BusinessCardController.swift
//  yelpCloneProj
//
//  Created by Peter Delis on 2022-08-04.

import Foundation
import UIKit

class BusinessCardController: UIViewController, ViewControllerProtocol {
    
    @IBOutlet weak var businessImage: UIImageView!
    
    @IBOutlet weak var businessName: UILabel!
    
    @IBOutlet weak var businessCategories: UILabel!
    
    @IBOutlet weak var businessAddress: UILabel!
    
    @IBOutlet weak var businessContact: UILabel!
    
    @IBOutlet weak var businessRating: UILabel!
    
    @IBOutlet weak var businessHours: UILabel!
    
    weak var presenter: BusinessCardPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.presentInfo()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func display(businessData: YelpBusiness) {
        
        guard let url = URL(string: businessData.image_url!)
        else {
            print("--- URL failed! ---")
            return
        }
        
        getData(from: url) { data, response, error in
                guard let data = data, error == nil
                else {
                    return
                }
            
                // always update the UI from the main thread
                DispatchQueue.main.async() { [weak self] in
                    self?.businessImage.image = UIImage(data: data)
                }
            }
        
        businessName.text = businessData.name
        
        businessCategories.text = businessData.categories?[0].alias
        
        businessAddress.text = businessData.location?.address1
        
        businessContact.text = businessData.phone
        
        businessRating.text = businessData.rating?.description
        
        businessHours.text = businessData.hours?[0].hours_type
        
    }
    
//    @objc func buttonTap() {
//        presenter?.presentAnotherController(scanType: .creditCard)
//    }
}

class BusinessCardPresenter {
    private let controller: BusinessCardController
    private let businessData: YelpBusiness
    
    init(controller: BusinessCardController, businessData: YelpBusiness) {
        self.controller = controller
        self.businessData = businessData
    }
    
    func presentInfo() {
        controller.display(businessData: businessData)
    }
    
}
