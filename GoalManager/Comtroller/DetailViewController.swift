//
//  DetailViewController.swift
//  GoalManager
//
//  Created by Amin Saedi on 2023-04-01.
//

import UIKit

protocol DetailViewControllerDelegate {
    
    func detailViewControllerChangedDataSource()
    
}

class DetailViewController: UIViewController {
    
    var object: Goal?
    
    var index: Int = -1
    
    var delegate : DetailViewControllerDelegate?
    
    @IBOutlet var headerLabel: UILabel!
    
    @IBOutlet var labelTextInput: UITextField!
    
    @IBOutlet weak var progressSlider: UISlider!
    
    @IBOutlet weak var importanceControl: UISegmentedControl!
    
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let object = object {
            headerLabel.text = object.label
            labelTextInput.text = object.label
            progressSlider.value = object.progress
            if (object.importance == "High") {
                importanceControl.selectedSegmentIndex = 0
            }
            else if (object.importance == "Medium") {
                importanceControl.selectedSegmentIndex = 1
            }
            else if (object.importance == "Low") {
                importanceControl.selectedSegmentIndex = 2
            }
            deleteButton.isEnabled = true
        } else {
            headerLabel.text = "Create a new goal"
            deleteButton.isEnabled = false
        }

        // Do any additional setup after loading the view.
    }
    
    
    private func handle_update(){
        var importance = "High"
        if (importanceControl.selectedSegmentIndex == 1) {
            importance = "Medium"
        }
        else if (importanceControl.selectedSegmentIndex == 2) {
            importance = "Low"
        }
        
        
        let updatedObject = Goal(label: labelTextInput.text!, importance: importance, progress: progressSlider.value, color: ["red": 255, "green": 255, "blue": 255])
        
        ObjectAPI.update(id: index, object: updatedObject) { (error, response) in
            if let error = error {
                print("Error updating object: \(error.localizedDescription)")
            } else if let response = response {
                print("Object updated successfully: \(response)")
                if self.delegate != nil {
                    self.delegate!.detailViewControllerChangedDataSource()
                }
            } else {
                print("Unknown error occurred while updating object")
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func handle_create(){
        var importance = "High"
        if (importanceControl.selectedSegmentIndex == 1) {
            importance = "Medium"
        }
        else if (importanceControl.selectedSegmentIndex == 2) {
            importance = "Low"
        }
        
        
        let updatedObject = Goal(label: labelTextInput.text!, importance: importance, progress: progressSlider.value, color: ["red": 255, "green": 255, "blue": 255])
        
        ObjectAPI.create(object: updatedObject) { (error, response) in
            if let error = error {
                print("Error updating object: \(error.localizedDescription)")
            } else if let response = response {
                print("Object created successfully: \(response)")
                if self.delegate != nil {
                    self.delegate!.detailViewControllerChangedDataSource()
                }
                
            } else {
                print("Unknown error occurred while updating object")
            }
        }
       
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onSaveTouch(_ sender: Any) {

        if (index != -1 ) {
            handle_update()
        } else {
            handle_create()
        }
    }
    
    @IBAction func onDelete(_ sender: Any) {
        ObjectAPI.delete(id: index) { (error) in
            if let error = error {
                print("Error updating object: \(error.localizedDescription)")
            } else {
                print("Deleted successfully")
                if self.delegate != nil {
                    self.delegate!.detailViewControllerChangedDataSource()
                }
            }
        }
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
}
