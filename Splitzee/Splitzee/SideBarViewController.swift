//
//  SideBarViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/19/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit
import Firebase

class SideBarViewController: UIViewController {
    
    var background: UIImageView!
    var splitzeeLogo: UIImageView!
    var tableView: UITableView!
    var createGroupButton: UIButton!
    var joinGroupButton: UIButton!
    var logoutButton: UIButton!
    var joinGroupAlert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        // background
        background = UIImageView(image: #imageLiteral(resourceName: "purpleFogBG"))
        background.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(background)
        
        // splitzeeLogo
        splitzeeLogo = UIImageView(image: #imageLiteral(resourceName: "splitzeeStraight"))
        splitzeeLogo.frame = CGRect(x: view.frame.width * 0.052, y: view.frame.height * -0.01, width: view.frame.width, height: view.frame.height * 0.250)
        splitzeeLogo.contentMode = .scaleAspectFit
        view.addSubview(splitzeeLogo)
        
        // createGroupButton
        createGroupButton = UIButton(frame: CGRect(x: 0, y: view.frame.height * 0.834, width: view.frame.width * 0.5, height: view.frame.height * 0.071))
        createGroupButton.setTitle("+ Create new group", for: .normal)
        createGroupButton.backgroundColor = UIColor.clear
        createGroupButton.layer.borderWidth = 0.5
        createGroupButton.layer.borderColor = UIColor.white.cgColor
        createGroupButton.setTitleColor(UIColor.white, for: .normal)
        createGroupButton.addTarget(self, action: #selector(createNewGroup), for: .touchUpInside)
        view.addSubview(createGroupButton)
        
        // joinGroupButton
        joinGroupButton = UIButton(frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.834, width: view.frame.width * 0.5, height: view.frame.height * 0.071))
        joinGroupButton.backgroundColor = UIColor.clear
        joinGroupButton.setTitle("+ Join new group", for: .normal)
        joinGroupButton.layer.borderWidth = 0.5
        joinGroupButton.layer.borderColor = UIColor.white.cgColor
        joinGroupButton.setTitleColor(UIColor.white, for: .normal)
        joinGroupButton.addTarget(self, action: #selector(joinGroup), for: .touchUpInside)
        view.addSubview(joinGroupButton)
        
        // logoutButton
        logoutButton = UIButton(frame: CGRect(x: 0, y: view.frame.height * 0.905, width: view.frame.width, height: view.frame.height * 0.095))
        logoutButton.backgroundColor = UIColor.clear
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        view.addSubview(logoutButton)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: view.frame.height * 0.304, width: view.frame.width, height: view.frame.height * 0.53))
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SideBarTableViewCell.self, forCellReuseIdentifier: "sideBarCell")
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.contentInset = UIEdgeInsets.zero
        view.addSubview(tableView)
    }
    
    func logout() {
        do {
            try FIRAuth.auth()?.signOut()
            AppState.sharedInstance.signedIn = false
            performSegue(withIdentifier: "menuToSignIn", sender: self)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func createNewGroup() {
        performSegue(withIdentifier: "sideBarToCreateGroup", sender: self)
    }
    
    func joinGroup() {
        joinGroupAlert = UIAlertController(title: "Join Group", message: "Enter group code:", preferredStyle: UIAlertControllerStyle.alert)
        joinGroupAlert.addTextField { (textField) -> Void in
        }
        joinGroupAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            let textF = self.joinGroupAlert.textFields![0] as UITextField
            print(textF.text!)
        }))
        joinGroupAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            self.joinGroupAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(joinGroupAlert, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

extension SideBarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideBarCell", for: indexPath) as! SideBarTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let sideBarCell = cell as! SideBarTableViewCell
        sideBarCell.label.text = "admin" // Either admin or member
        sideBarCell.name.text = "Mobile Developers of Berkeley" // Group name
        sideBarCell.options.text = "..." // Always "..."
        sideBarCell.backgroundColor = UIColor.clear
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sideBarToAdmin", sender: self)
    }
   
}
