//
//  AdminPageViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//
import UIKit

class AdminPageViewController: UIViewController {
    
    var segmentedView: UISegmentedControl!
    var groupsButton: UIButton!
    var newTransactionButton: UIButton!
    var addMoneyButton: UIButton!
    var subtractMoneyButton: UIButton!
    var totalLoopImage: UIImageView!
    var totalAmount: UILabel!
    var tableView: UITableView!
    var backgroundGradient: UIImageView!
    let constants = Constants()
    var alertViewAdd: UIAlertController!
    var alertViewSub: UIAlertController!
    var pending = true
    var currUser: CurrentUser!
    var group: Group!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currUser = CurrentUser()
        setupUI()
    }
    
    func setupUI() {
        // BACKGROUND
        backgroundGradient = UIImageView(frame: view.frame)
        backgroundGradient.image = #imageLiteral(resourceName: "whiteBlueGradientBG")
        view.addSubview(backgroundGradient)
        
        // GROUPS BUTTON LEFT
        groupsButton = UIButton(frame: CGRect(x: view.frame.width * 0.048, y: view.frame.height * 0.337, width: view.frame.width * 0.058, height: view.frame.height * 0.032))
        groupsButton.setImage(#imageLiteral(resourceName: "menuSymbol"), for: .normal)
        groupsButton.imageView?.contentMode = .scaleAspectFill
        groupsButton.addTarget(self, action: #selector(groupsPressed), for: .touchUpInside)
        view.addSubview(groupsButton)
        
        // NEW TRANSACTION BUTTON RIGHT
        newTransactionButton = UIButton(frame: CGRect(x: view.frame.width * 0.896, y: view.frame.height * 0.333, width: view.frame.width * 0.058, height: view.frame.height * 0.032))
        newTransactionButton.setTitle("+", for: .normal)
        newTransactionButton.titleLabel?.font = UIFont(name: "SFUIText-Light", size: 43)
        newTransactionButton.setTitleColor(constants.fontMediumBlue, for: .normal)
        
        newTransactionButton.addTarget(self, action: #selector(touchNewAdminTransactionButton), for: .touchUpInside)
        view.addSubview(newTransactionButton)
        
        // BALANCE CIRCLE
        totalLoopImage = UIImageView(frame: CGRect(x: view.frame.width / 2 - 0.175 * view.frame.width, y: view.frame.height * 0.110, width: view.frame.width * 0.35, height: view.frame.height * 0.200))
        totalLoopImage.image = #imageLiteral(resourceName: "Loop")
        totalLoopImage.contentMode = .scaleAspectFit
        view.addSubview(totalLoopImage)
        
        // BALANCE AMOUNT
        totalAmount = UILabel(frame: CGRect(x: view.frame.width / 2 - 0.175 * view.frame.width, y: view.frame.height * 0.19, width: view.frame.width * 0.35, height: view.frame.height * 0.045))
        totalAmount.text = String(group.total) //Actual group total
        totalAmount.textAlignment = .center
        totalAmount.font = UIFont(name: "SFUIText-Light", size: 18)
        totalAmount.textColor = constants.fontMediumBlue
        totalAmount.textAlignment = .center
        view.addSubview(totalAmount)
        
        // ADD BUTTON
        addMoneyButton = UIButton(frame: CGRect(x: view.frame.width * 0.693, y: view.frame.height * 0.155, width: view.frame.width * 0.075 + 15, height: view.frame.height * 0.046 + 15))
        addMoneyButton.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
        addMoneyButton.imageView?.contentMode = .scaleAspectFill
        addMoneyButton.addTarget(self, action: #selector(addMoneyPressed), for: .touchUpInside)
        view.addSubview(addMoneyButton)
        
        // SUBTRACT BUTTON
        subtractMoneyButton = UIButton(frame: CGRect(x: view.frame.width * 0.693, y: view.frame.height * 0.216, width: view.frame.width * 0.075 + 15, height: view.frame.height * 0.046 + 15))
        subtractMoneyButton.setImage(#imageLiteral(resourceName: "minusSign"), for: .normal)
        subtractMoneyButton.imageView?.contentMode = .scaleAspectFill
        subtractMoneyButton.addTarget(self, action: #selector(subMoneyPressed), for: .touchUpInside)
        view.addSubview(subtractMoneyButton)
        
        setupNavBar()
        setupSegmentedControl()
        setupTableView()
    }
    
    func groupsPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupNavBar() {
        self.title = group.name // Actual group name
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: constants.fontMediumBlue, NSFontAttributeName: UIFont(name: "SFUIText-Light", size: 20)!]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    func setupSegmentedControl() {
        let items = ["Incoming", "Outgoing", "History"]
        let attr = NSDictionary(object: UIFont(name: "SFUIText-Regular", size: 14.0)!, forKey: NSFontAttributeName as NSCopying)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject] , for: .normal)
        segmentedView = UISegmentedControl(items: items)
        segmentedView.selectedSegmentIndex = 0
        segmentedView.frame = CGRect(x: view.frame.width * 0.145, y: view.frame.height * 0.334, width: view.frame.width * 0.720, height: 28)
        segmentedView.layer.cornerRadius = 3
        segmentedView.backgroundColor = UIColor.white
        segmentedView.tintColor = constants.mediumBlue
        segmentedView.addTarget(self, action: #selector(switchView), for: .valueChanged)
        view.addSubview(segmentedView)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: view.frame.height * 0.397, width: view.frame.width, height: view.frame.height * 0.603), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AdminPendingTableViewCell.self, forCellReuseIdentifier: "pendingAdminCell")
        tableView.register(AdminHistoryTableViewCell.self, forCellReuseIdentifier: "historyAdminCell")
        view.addSubview(tableView)
    }
    
    func touchNewAdminTransactionButton(sender: UIButton!) {
        performSegue(withIdentifier: "adminPageToNewAdminTransaction", sender: self)
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
    
    func addMoneyPressed() {
        alertViewAdd = UIAlertController(title: "Add an amount:", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertViewAdd.addTextField { (textField) -> Void in
            textField.placeholder = "$0.00"
        }
        alertViewAdd.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            let textF = self.alertViewAdd.textFields![0] as UITextField
            print(textF.text!)
        }))
        alertViewAdd.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            self.alertViewAdd.dismiss(animated: true, completion: nil)
        }))
        self.present(alertViewAdd, animated: true, completion: nil)
    }
    
    func subMoneyPressed() {
        alertViewSub = UIAlertController(title: "Subtract an amount:", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertViewSub.addTextField { (textField) -> Void in
            textField.placeholder = "$0.00"
        }
        alertViewSub.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            let textF = self.alertViewSub.textFields![0] as UITextField
            print(textF.text!)
        }))
        alertViewSub.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            self.alertViewSub.dismiss(animated: true, completion: nil)
        }))
        self.present(alertViewSub, animated: true, completion: nil)
    }

}
//-----------------functions----------------------------------
    

    
    


//-----------------Sets up the tableviews---------------------------
extension AdminPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pendingCell = tableView.dequeueReusableCell(withIdentifier: "pendingAdminCell", for: indexPath) as! AdminPendingTableViewCell
        let historyCell = tableView.dequeueReusableCell(withIdentifier: "historyAdminCell", for: indexPath) as! AdminHistoryTableViewCell
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
        if let pendingCell = cell as? AdminPendingTableViewCell {
            
        } else if let historyCell = cell as? AdminHistoryTableViewCell {
            
        }
    }
}




