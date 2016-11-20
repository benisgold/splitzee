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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        backgroundGradient = UIImageView(frame: view.frame)
        backgroundGradient.image = #imageLiteral(resourceName: "whiteBlueGradientBG")
        view.addSubview(backgroundGradient)
        
        groupsButton = UIButton(frame: CGRect(x: view.frame.width * 0.053, y: view.frame.height * 0.296, width: view.frame.width * 0.058, height: view.frame.height * 0.032))
        groupsButton.setImage(#imageLiteral(resourceName: "menuSymbol"), for: .normal)
        groupsButton.imageView?.contentMode = .scaleAspectFill
        view.addSubview(groupsButton)
        
        newTransactionButton = UIButton(frame: CGRect(x: view.frame.width * 0.896, y: view.frame.height * 0.296, width: view.frame.width * 0.058, height: view.frame.height * 0.032))
        newTransactionButton.setImage(#imageLiteral(resourceName: "pencilSymbol"), for: .normal)
        newTransactionButton.imageView?.contentMode = .scaleAspectFit
        
        newTransactionButton.addTarget(self, action: #selector(touchNewAdminTransactionButton), for: .touchUpInside)
        view.addSubview(newTransactionButton)
        
        totalLoopImage = UIImageView(frame: CGRect(x: view.frame.width * 0.344, y: view.frame.height * 0.139, width: view.frame.width * 0.315, height: view.frame.height * 0.181))
        totalLoopImage.image = #imageLiteral(resourceName: "Loop")
        totalLoopImage.contentMode = .scaleAspectFit
        view.addSubview(totalLoopImage)
        
        totalAmount = UILabel(frame: CGRect(x: view.frame.width * 0.397, y: view.frame.height * 0.213, width: view.frame.width * 0.208, height: view.frame.height * 0.045))
        totalAmount.text = "$100.00"
        totalAmount.textColor = constants.fontMediumBlue
        totalAmount.textAlignment = .center
        view.addSubview(totalAmount)
        
        addMoneyButton = UIButton(frame: CGRect(x: view.frame.width * 0.693, y: view.frame.height * 0.182, width: view.frame.width * 0.075, height: view.frame.height * 0.046))
        addMoneyButton.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
        addMoneyButton.imageView?.contentMode = .scaleAspectFill
        addMoneyButton.addTarget(self, action: #selector(addMoneyPressed), for: .touchUpInside)
        view.addSubview(addMoneyButton)
        
        subtractMoneyButton = UIButton(frame: CGRect(x: view.frame.width * 0.693, y: view.frame.height * 0.243, width: view.frame.width * 0.075, height: view.frame.height * 0.046))
        subtractMoneyButton.setImage(#imageLiteral(resourceName: "minusSign"), for: .normal)
        subtractMoneyButton.imageView?.contentMode = .scaleAspectFill
        subtractMoneyButton.addTarget(self, action: #selector(subMoneyPressed), for: .touchUpInside)
        view.addSubview(subtractMoneyButton)
        
        setupNavBar()
        setupSegmentedControl()
        setupTableView()
    }
    
    func setupNavBar() {
        self.title = "What's going on?" // change to group name
    }
    
    func setupSegmentedControl() {
        let items = ["Incoming", "Outgoing", "History"]
        segmentedView = UISegmentedControl(items: items)
        segmentedView.selectedSegmentIndex = 0
        segmentedView.frame = CGRect(x: view.frame.width * 0.066, y: view.frame.height * 0.334, width: view.frame.width * 0.867, height: 28)
        segmentedView.layer.cornerRadius = 3
        segmentedView.backgroundColor = UIColor.white
        segmentedView.tintColor = constants.mediumBlue
        segmentedView.addTarget(self, action: #selector(switchView), for: .valueChanged)
        view.addSubview(segmentedView)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: view.frame.height * 0.397, width: view.frame.width, height: view.frame.height * 0.603))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AdminPendingTableViewCell.self, forCellReuseIdentifier: "pendingAdminCell")
        view.addSubview(tableView)
    }
    
    func touchNewAdminTransactionButton(sender: UIButton!) {
        performSegue(withIdentifier: "adminPageToNewAdminTransaction", sender: self)
    }
    
    func switchView(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            // incoming
        } else if (sender.selectedSegmentIndex == 1) {
            // outgoing
        } else {
            // history
        }
    }
    
    func addMoneyPressed() {
        alertViewAdd = UIAlertController(title: "Add an amount:", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertViewAdd.addTextField { (textField) -> Void in
            textField.placeholder = "$0.00"
        }
        alertViewAdd.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            let textF = self.alertViewAdd.textFields![0] as UITextField
            print(textF.text)
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
            print(textF.text)
        }))
        alertViewSub.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            self.alertViewAdd.dismiss(animated: true, completion: nil)
        }))
        self.present(alertViewSub, animated: true, completion: nil)
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

extension AdminPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pendingAdminCell", for: indexPath) as! AdminPendingTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! AdminPendingTableViewCell
    }
}
