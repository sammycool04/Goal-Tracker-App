//
//  NewIdeaCreation.swift
//  Goal Tracker
//
//  Created by Sam  on 6/8/19.
//  Copyright © 2019 Sam. All rights reserved.
//

import UIKit
import RealmSwift
import DSColorPicker
import PickerViewCell


protocol AddItemDelegate {
    func addItem(item: item)
}


class NewIdeaCreation: UITableViewController {
    
    var calendarHandlerViewModel: CalendarSelectionViewModelContrast!
    
    let colorArray = [ 0x000000, 0xfe0000, 0xff7900, 0xffb900, 0xffde00, 0xfcff00, 0xd2ff00, 0x05c000, 0x00c0a7, 0x0600ff, 0x6700bf, 0x9500c0, 0xbf0199, 0xffffff ]
    
    let daysDates: [Date] = []


    var backgroundColor: Int?
    
    @IBOutlet weak var fromDateLabel: UILabel!
    
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var nameTextField: UITextField!
    
        
    @IBAction func sliderChange(_ sender: Any) {
        
//        print("\(colorArray[Int(slider.value)])")
        return backgroundColor = colorArray[Int(slider.value)]
    }
    
    
    let realm = try! Realm()
    
    var delegate: AddItemDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.becomeFirstResponder()
//        tableView.register(UINib.init(nibName: "MyCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "daysCell")
        
        
        }
    
    
    //Date Selection Method Data Source Method (use another way to do TableView
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        var cell = tableView.dequeueReusableCell(withIdentifier: "daysCell", for: indexPath)
//        if let rangePickerCell = cell as? DateRangePickerTableViewCell {
//
//        configureChallengeFieldCell(rangePickerCell)
//        }
//
//        return cell
//
//            }
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        formatter.timeStyle = DateFormatter.Style.none
        return formatter
    }()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? DatePickerTableViewCell {
            cell.delegate = self
            if !cell.isFirstResponder {
                _ = cell.becomeFirstResponder()
            }
        }
//        } else if let cell = tableView.cellForRow(at: indexPath) as? PickerTableViewCell {
//            cell.delegate = self
//            cell.dataSource = self
//            if !cell.isFirstResponder {
//                _ = cell.becomeFirstResponder()
//            }
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view {
            self.view.resignFirstResponder()
        }
    }
    
    
    //function to store and display the Name Field
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        let ideaName = item()
        
        ideaName.name = nameTextField.text ?? ""
        ideaName.color = String(colorArray[Int(slider.value)]) //Data Type?
        
        delegate?.addItem(item: ideaName)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // a function that can convert Date type to String type
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
//    private func configureChallengeFieldCell(_ cell:DateRangePickerTableViewCell) {
//        cell.fromDateLabel.text = calendarHandlerViewModel.getFirstDateText() ?? "--"
//    }

}

//extension NewIdeaCreation: AddDateRange {
//
//    func addDate(_ dateSelected: [Date]) {
////        let dateString = date2String(dateSelected)
//        calendarHandlerViewModel.setDays(daysDates)
////        fromDateLabel.text = dateString
//        tableView.reloadData()
//        print("Date Added")
//    }
//}


extension NewIdeaCreation: DatePickerTableCellDelegate {
    
    func onDateChange(_ sender: UIDatePicker, cell: DatePickerTableViewCell) {
        fromDateLabel.text = dateFormatter.string(from: sender.date)
    }
    
    func onDatePickerOpen(_ cell: DatePickerTableViewCell) {
        fromDateLabel.text = fromDateLabel.text!.isEmpty ? dateFormatter.string(from: Date()) : fromDateLabel.text
        fromDateLabel.textColor = UIColor.red
    }
    
    func onDatePickerClose(_ cell: DatePickerTableViewCell) {
        fromDateLabel.textColor = UIColor.gray
    }
    
}

// MARK: - PickerTableCellDataSource

extension NewIdeaCreation: PickerTableCellDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView, forCell cell: PickerTableViewCell) -> Int {
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int, forCell cell: PickerTableViewCell) -> Int {
        return 10
    }
    
}


