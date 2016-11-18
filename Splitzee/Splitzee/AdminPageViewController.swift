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
    var collectionView: UICollectionView!
    var backgroundGradient: UIImageView!
    let constants = Constants()

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
        self.performSegue(withIdentifier: "adminPageToNewTransaction", sender: newTransactionButton)
        view.addSubview(newTransactionButton)
        
        totalLoopImage = UIImageView(frame: CGRect(x: view.frame.width * 0.344, y: view.frame.height * 0.139, width: view.frame.width * 0.315, height: view.frame.height * 0.181))
        totalLoopImage.image = #imageLiteral(resourceName: "Loop")
        totalLoopImage.contentMode = .scaleAspectFit
        view.addSubview(totalLoopImage)
        
        totalAmount = UILabel(frame: CGRect(x: view.frame.width * 0.397, y: view.frame.height * 0.213, width: view.frame.width * 0.208, height: view.frame.height * 0.045))
        totalAmount.text = "$100.00"
        totalAmount.textColor = constants.fontMediumBlue
//        totalAmount.font = UIFont(name: "SF-UI-Display-Thin", size: 30)
        totalAmount.textAlignment = .center
        view.addSubview(totalAmount)
        
        addMoneyButton = UIButton(frame: CGRect(x: view.frame.width * 0.693, y: view.frame.height * 0.182, width: view.frame.width * 0.075, height: view.frame.height * 0.046))
        addMoneyButton.setImage(#imageLiteral(resourceName: "plusSign"), for: .normal)
        addMoneyButton.imageView?.contentMode = .scaleAspectFill
        view.addSubview(addMoneyButton)
        
        subtractMoneyButton = UIButton(frame: CGRect(x: view.frame.width * 0.693, y: view.frame.height * 0.243, width: view.frame.width * 0.075, height: view.frame.height * 0.046))
        subtractMoneyButton.setImage(#imageLiteral(resourceName: "minusSign"), for: .normal)
        subtractMoneyButton.imageView?.contentMode = .scaleAspectFill
        view.addSubview(subtractMoneyButton)
        
        setupNavBar()
        setupSegmentedControl()
        setupCollectionView()
    }
    
    func setupNavBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.111))
        navBar.backgroundColor = UIColor.white
        let navTitle = UINavigationItem(title: "What's going on?") // change to group name
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : constants.fontMediumBlue]
        navBar.setItems([navTitle], animated: false)
        
        view.addSubview(navBar)
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
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: view.frame.height * 0.397, width: view.frame.width, height: view.frame.height * 0.603) , collectionViewLayout: layout)
        collectionView.register(AdminCollectionViewCell.self, forCellWithReuseIdentifier: "adminCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AdminPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // some count
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adminCell", for: indexPath) as! AdminCollectionViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let adminCell = cell as! AdminCollectionViewCell
        // set UI stuff
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3), height: view.frame.height * 0.25)
    }
}
