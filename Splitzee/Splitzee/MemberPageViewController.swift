//
//  MemberPageViewController.swift
//  Splitzee
//
//  Created by Vidya Ravikumar on 11/16/16.
//  Copyright © 2016 Mohit Katyal. All rights reserved.
//

import UIKit

class MemberPageViewController: UINavigationController {
    
    var segmentedView: UISegmentedControl!
    var groupsButton: UIButton!
    var newTransactionButton: UIButton!
    var collectionView: UICollectionView!
    var backgroundGradient: UIImageView!

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
        setupNavBar()
        setupSegmentedControl()
        setupCollectionView()
    }
    
    func setupNavBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.111))
        navBar.backgroundColor = UIColor.white
        let navTitle = UINavigationItem(title: "What's going on?") // change to group name
        navBar.setItems([navTitle], animated: false)
        view.addSubview(navBar)
    }
    
    func setupSegmentedControl() {
        let items = ["Incoming", "Outgoing", "History"]
        segmentedView = UISegmentedControl(items: items)
        segmentedView.selectedSegmentIndex = 0
        segmentedView.frame = CGRect(x: view.frame.width * 0.066, y: view.frame.height * 0.181, width: view.frame.width * 0.867, height: view.frame.height * 0.061)
        segmentedView.layer.cornerRadius = 3
        segmentedView.backgroundColor = UIColor.white
        segmentedView.tintColor = UIColor.black
        segmentedView.addTarget(self, action: #selector(switchView), for: .valueChanged)
        view.addSubview(segmentedView)
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: view.frame.height * 0.397, width: view.frame.width, height: view.frame.height * 0.603) , collectionViewLayout: layout)
        collectionView.register(AdminCollectionViewCell.self, forCellWithReuseIdentifier: "memberCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
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

extension MemberPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // some count
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memberCell", for: indexPath) as! MemberCollectionViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let memberCell = cell as! MemberCollectionViewCell
        // set UI stuff
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3), height: view.frame.height * 0.25)
    }
}
