//
//  ViewController.swift
//  GridViewAnimation
//
//  Created by Rakesh Jyoti on 1/22/18.
//  Copyright © 2018 RJ. All rights reserved.
//

import UIKit



class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var cnstViewHorizental: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func startAnimation(with delay: Double) {
        
//        var centerPoint = viewBG.center
//        centerPoint.y += 50
//        viewBG.center = centerPoint
        viewBG.alpha = 0.0
//        centerPoint.y -= 50
        
        cnstViewHorizental.constant = 50
        self.layoutIfNeeded()
        
        
        cnstViewHorizental.constant = 0

        
        UIView.animate(withDuration: 0.25, delay: delay, options: .curveEaseOut, animations: {
            
            self.layoutIfNeeded()
            self.viewBG.alpha = 1.0
            
        }) { (isCompleted) in
            
        }
    }
    
}



class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delayCounter = 0.25
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func viewDidLayoutSubviews() {
        didTapReloadBtn(nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapReloadBtn(_ sender: UIButton?) {
        
        delayCounter = 0.0
        collectionView.reloadData()
    }


}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 2 * 5)/3
        
        return CGSize.init(width: width, height: 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        cell.viewBG.alpha = 0.0
        cell.viewBG.frame = cell.bounds
        
        
        delayCounter += 0.15
        if indexPath.row % 3 == 0 {
            delayCounter -= 0.15
        }

        
        cell.startAnimation(with: delayCounter)

        
//
//        switch indexPath.row % 3 {
//        case 0,1:
//            cell.startAnimation(with: delayCounter)
//
//        case 2:
//            cell.startAnimation(with: delayCounter + 0.25)
//
//        default: break
//
//        }
        
        
//        cell.startAnimation(with: delayCounter)
        
        
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delayCounter = 0.0

    }
}

