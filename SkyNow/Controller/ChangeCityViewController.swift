//
//  ChangeCityViewController.swift
//  SkyNow
//
//  Created by Fatimah Galhoum on 5/17/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import UIKit

protocol changeCityDelegate {
    func userEnteredANewCityName (city : String)
}




class ChangeCityViewController: UIViewController {

    //Outlets
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    var delegate : changeCityDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func getWeatherButtonClicked(_ sender: Any) {
        
        let cityName = changeCityTextField.text
        delegate?.userEnteredANewCityName(city: cityName ?? "No city Name")
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    

}
