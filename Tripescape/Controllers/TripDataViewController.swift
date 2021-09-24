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
    var startDate: String?
    var endDate: String?
    var numPer: Int = 1
    var budgetData: [String] = [String]()
    var activityData: [String] = [String]()
    @IBOutlet weak var switchCanoeing: UISwitch!
    @IBOutlet weak var switchSailing: UISwitch!
    @IBOutlet weak var switchSkiing: UISwitch!
    @IBOutlet weak var switchWineTasking: UISwitch!
    @IBOutlet weak var switchHiking: UISwitch!
    @IBOutlet weak var switchSightseeing: UISwitch!
    var desiredActivities: [String] = [String]()
    
    @IBOutlet weak var lblNumPersons: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        self.pickerBudget.delegate = self
        self.pickerBudget.dataSource = self

        budgetData = ["<100", "100-200", "200-500", "500+"]
        activityData = ["Skiing", "Surfing", "Hiking", "Rowing"]
        
        startDatePicker.minimumDate = Date()
        endDatePicker.minimumDate = Date()
        
        switchSkiing.addTarget(self, action: #selector(self.switchClicked), for: .valueChanged)
        switchCanoeing.addTarget(self, action: #selector(self.switchClicked), for: .valueChanged)
        switchSailing.addTarget(self, action: #selector(self.switchClicked), for: .valueChanged)
        switchSightseeing.addTarget(self, action: #selector(self.switchClicked), for: .valueChanged)
        switchWineTasking.addTarget(self, action: #selector(self.switchClicked), for: .valueChanged)
        switchHiking.addTarget(self, action: #selector(self.switchClicked), for: .valueChanged)
        
        switchHiking.isOn = true
        switchSightseeing.isOn = true
        switchCanoeing.isOn = true
        switchSkiing.isOn = true
        switchWineTasking.isOn = true
        switchSailing.isOn = true
        
        TripService.sharedInstance.trip = Trip()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        readSwitchesData()
        TripService.sharedInstance.initTrip(startDate: startDatePicker.date, endDate: endDatePicker.date, desiredActivities: self.desiredActivities, numPersons: numPer, budget: 1, userid: DatabaseService.sharedInstance.getCurrentUserId())
    }
    
    @objc func switchClicked(mySwitch: UISwitch) {
        readSwitchesData()
    }
    
    func readSwitchesData() {
        //Read UI stuff
        let listSwitch = [switchSkiing : Enums.Activity.Skiing, switchHiking: Enums.Activity.Hiking, switchSailing: Enums.Activity.Sailing, switchCanoeing: Enums.Activity.Canoeing, switchSightseeing: Enums.Activity.Sightseeing, switchWineTasking: Enums.Activity.Wine_Tasting]
        
        for mySwitch in listSwitch {
            if mySwitch.key!.isOn {
                if !desiredActivities.contains(mySwitch.value.description) {
                    desiredActivities.append(mySwitch.value.description)
                }
            } else {
                if(desiredActivities.contains(mySwitch.value.description)) {
                    let index = desiredActivities.firstIndex(of: mySwitch.value.description)!
                    desiredActivities.remove(at: index)
                }
            }
        }
        TripService.sharedInstance.trip!.desiredActivities = desiredActivities
    }
    
    @IBAction func sliderNumPerChanged(_ sender: Any) {
        self.numPer = Int(sliderNumPer.value)
        lblNumPersons.text = String(self.numPer)
        TripService.sharedInstance.trip!.numPersons = self.numPer
    }
    
    
    @IBAction func startDateChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        startDate = dateFormatter.string(from: startDatePicker.date)
        endDatePicker.minimumDate = startDatePicker.date
    }
    
    @IBAction func endDateChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        endDate = dateFormatter.string(from: endDatePicker.date)
    }
    
    
    func displayAlert(title: String, message: String) {
        let alerta = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: { (accion) in
            alerta.dismiss(animated: true, completion: nil)
        }))
        self.present(alerta, animated: true, completion: nil)
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
