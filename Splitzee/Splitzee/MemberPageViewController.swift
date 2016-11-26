//
//  MemberPageViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class MemberPageViewController: UIViewController {
    
    var segmentedView: UISegmentedControl!
    var groupsButton: UIButton!
    var newTransactionButton: UIButton!
    var tableView: UITableView!
    var backgroundGradient: UIImageView!
    var pending = true
    var currUser: CurrentUser!
    let constants = Constants()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        backgroundGradient = UIImageView(frame: view.frame)
        backgroundGradient.image = #imageLiteral(resourceName: "whiteBlueGradientBG")
        view.addSubview(backgroundGradient)
        
        groupsButton = UIButton(frame: CGRect(x: view.frame.width * 0.053, y: view.frame.height * 0.143, width: view.frame.width * 0.058, height: view.frame.height * 0.032))
        groupsButton.setImage(#imageLiteral(resourceName: "menuSymbol"), for: .normal)
        groupsButton.imageView?.contentMode = .scaleAspectFill
        groupsButton.addTarget(self, action: #selector(groupsPressed), for: .touchUpInside)
        view.addSubview(groupsButton)
        
        newTransactionButton = UIButton(frame: CGRect(x: view.frame.width * 0.896, y: view.frame.height * 0.138, width: view.frame.width * 0.058, height: view.frame.height * 0.032))
        newTransactionButton.setTitle("+", for: .normal)
        newTransactionButton.titleLabel?.font = UIFont(name: "SFUIText-Light", size: 43)
        newTransactionButton.setTitleColor(constants.fontMediumBlue, for: .normal)
        newTransactionButton.imageView?.contentMode = .scaleAspectFit
        newTransactionButton.addTarget(self, action: #selector(newTransactionPressed), for: .touchUpInside)
        view.addSubview(newTransactionButton)
        
        setupNavBar()
        setupSegmentedControl()
        setupTableView()
    }
    
    func newTransactionPressed() {
        performSegue(withIdentifier: "memberPageToNewMemberTransaction", sender: self)
    }
    
    func groupsPressed() {
//        performSegue(withIdentifier: "memberToSideBar", sender: self)
        dismiss(animated: true, completion: nil)
    }
    
    func setupNavBar() {
        self.title = "Group Name" // change to group name
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: constants.fontMediumBlue, NSFontAttributeName: UIFont(name: "SFUIText-Light", size: 20)!]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    func setupSegmentedControl() {
        let items = ["Incoming", "Outgoing", "History"]
        let attr = NSDictionary(object: UIFont(name: "SFUIText-Regular", size: 14.0)!, forKey: NSFontAttributeName as NSCopying)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject] , for: .normal)
        segmentedView = UISegmentedControl(items: items)
        segmentedView.selectedSegmentIndex = 0
        segmentedView.frame = CGRect(x: view.frame.width * 0.142, y: view.frame.height * 0.140, width: view.frame.width * 0.720, height: 28)
        segmentedView.layer.cornerRadius = 3
        segmentedView.backgroundColor = UIColor.white
        segmentedView.tintColor = constants.mediumBlue
        segmentedView.addTarget(self, action: #selector(switchView), for: .valueChanged)
        view.addSubview(segmentedView)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: view.frame.height * 0.185, width: view.frame.width, height: view.frame.height * 0.820))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MemberPendingTableViewCell.self, forCellReuseIdentifier: "pendingMemberCell")
        tableView.register(MemberHistoryTableViewCell.self, forCellReuseIdentifier: "historyMemberCell")
        view.addSubview(tableView)
    }
    
    func switchView(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            pending = true
            //more
        } else if (sender.selectedSegmentIndex == 1) {
            pending = true
            //more
        } else {
            pending = false
            //more
        }
    }
}

extension MemberPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pendingCell = tableView.dequeueReusableCell(withIdentifier: "pendingMemberCell", for: indexPath) as! MemberPendingTableViewCell
        let historyCell = tableView.dequeueReusableCell(withIdentifier: "historyMemberCell", for: indexPath) as! MemberHistoryTableViewCell
        if pending {
            for subview in pendingCell.contentView.subviews {
                subview.removeFromSuperview()
            }
            pendingCell.awakeFromNib()
            return pendingCell
        } else {
            for subview in historyCell.contentView.subviews {
                subview.removeFromSuperview()
            }
            historyCell.awakeFromNib()
            return historyCell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let pendingCell = cell as! MemberPendingTableViewCell
        let historyCell = cell as! MemberHistoryTableViewCell
    }
}
