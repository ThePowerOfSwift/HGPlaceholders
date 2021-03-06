//
//  CollectionViewController.swift
//  HGPlaceholders
//
//  Created by Hamza Ghazouani on 26/07/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import HGPlaceholders

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var placeholderCollectionView: CollectionView? {
        get { return collectionView as? CollectionView }
    }
    
    var data = [
        "collectionView.showLoadingPlaceholder()",
        "collectionView.showNoResultsPlaceholder()",
        "collectionView.showErrorPlaceholder()",
        "collectionView.showNoConnectionPlaceholder()",
        "collectionView.showCustomPlaceholder(with: key)",
        "/* From XIB */\ncollectionView.showCustomPlaceholder(with: key)"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeholderCollectionView?.placeholdersProvider = .summer
        placeholderCollectionView?.placeholderDelegate = self
        placeholderCollectionView?.showLoadingPlaceholder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BasicCollectionViewCell
        
        cell.titleLabel.text = data[indexPath.row]
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            placeholderCollectionView?.showLoadingPlaceholder()
        case 1:
            placeholderCollectionView?.showNoResultsPlaceholder()
        case 2:
            placeholderCollectionView?.showErrorPlaceholder()
        case 3:
            placeholderCollectionView?.showNoConnectionPlaceholder()
        case 4:
            let key = PlaceholderKey.custom(key: "starWars")
            placeholderCollectionView?.showCustomPlaceholder(with: key)
        case 5:
            let key = PlaceholderKey.custom(key: "XIB")
            placeholderCollectionView?.showCustomPlaceholder(with: key)
            
        default:
            placeholderCollectionView?.showDefault()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.bounds.width, height: 101)
        return size
    }
}

extension CollectionViewController: PlaceholderDelegate {
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        (view as? CollectionView)?.showDefault()
    }
}
