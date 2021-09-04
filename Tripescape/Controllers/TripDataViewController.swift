//
//  TripDataViewController.swift
//  Tripescape
//
//  Created by Emilio Castellano on 01/09/2021.
//

import UIKit

class TripDataViewController: UIViewController  {

    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var sliderNumPer: UISlider!
    @IBOutlet weak var pickerBudget: UIPickerView!
    @IBOutlet weak var pickerActivities: UIPickerView!
    var startDate: String?
    var endDate: String?
    var numPer: Int?
    var budgetData: [String] = [String]()
    var activityData: [String] = [String]()
    
    @IBOutlet weak var lblNumPersons: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.pickerBudget.delegate = self
        self.pickerBudget.dataSource = self
        
        self.pickerActivities.delegate = self
        self.pickerActivities.dataSource = self
        
        budgetData = ["<100", "100-200", "200-500", "500+"]
        activityData = ["Skiing", "Surfing", "Hiking", "Rowing"]
        
    }
    
    @IBAction func sliderNumPerChanged(_ sender: Any) {
        self.numPer = Int(sliderNumPer.value)
        lblNumPersons.text = String(self.numPer!)
    }
    
    
    @IBAction func startDateChanged(_ sender: Any) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        startDate = dateFormatter.string(from: startDatePicker.date)
        print("Selected start date: \(startDate)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TripDataViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return budgetData.count
        } else {
            return activityData.count
        }
    }
    
    func  pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return "\(budgetData[row])"
        } else {
            return "\(activityData[row])"
        }
    }
    
    
}
