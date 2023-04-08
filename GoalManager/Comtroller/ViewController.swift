//
//  ViewController.swift
//  GoalManager
//
//  Created by Amin Saedi on 2023-04-01.
//

import UIKit
import Parse

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    var objects: [Goal] = []
    private var selectedIndex = -1;
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as! MyTableViewCell
        
        cell.setData(goal: objects[indexPath.row])
        
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        init_view()
        // Do any additional setup after loading the view.
    }
    
    private func load_data() {
        
        ObjectAPI.read { [weak self] (error, objects) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                print(error)
            } else if let objects = objects {
                self?.objects = objects
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    
    private func init_view() {
        tableView.register(UINib(nibName: MyTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MyTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        usernameLabel.text = PFUser.current()?.username ?? "N/A"
        createdAtLabel.text = "Created At: " + (PFUser.current()?.createdAt?.formatted() ?? "N/A")
        
        
        load_data()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "toDetailView", sender: nil)
    }
    
    @IBAction func onAddTouch(_ sender: Any) {
        selectedIndex = -1
        performSegue(withIdentifier: "toDetailView", sender: nil)
    }
    
    
    @IBAction func onLogoutBtnTouch(_ sender: Any) {
        PFUser.logOut();
        
        //performSegue(withIdentifier: "toLoginViewController", sender: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    func detailViewControllerChangedDataSource() {
        load_data()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.delegate = self
            detailVC.index = selectedIndex
            if (selectedIndex != -1) {
                detailVC.object = objects[selectedIndex]
            }
        }
    }
    
    
    
}

