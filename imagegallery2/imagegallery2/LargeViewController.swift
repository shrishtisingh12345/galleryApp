//
//  LargeViewController.swift
//  imagegallery2
//
//  Created by shrishti singh on 04/08/21.
//

import UIKit


//MARK:- Protocol For deleate


var num = [UIImage]()




class LargeViewController: UIViewController  {
    
 
    
    
    //MARK:- View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }
    
    //MARK :- Overide View Did Load Fuction For Change A Image On Evry Slide On Clicking on same image and getting row stated from there
    
    override func viewDidLayoutSubviews() {
        self.largeViewCollectionView.scrollToItem(at: IndexPath(item: self.selectedIndex, section: 0), at: .left, animated: false)
    }
    
    
    //MARK:- Variables
    
    var img:UIImage!
    var name = ""
    var imageArray = [UIImage]()
    var selectedIndex = 0
    var num = [UIImage]()
    

    
    
    //MARK:- IBOutelet Of LargeViewController Cell
    
    @IBOutlet weak var largeViewCollectionView: UICollectionView!
    
   
    
}

//MARK:- Extention for collection view



extension LargeViewController:UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return num.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "largeCell", for: indexPath) as! LargeViewCollectionViewCell
    
    cell2.largeCollectionViewCellImage.image = num[indexPath.item]
    
    
    return cell2
}
    
    

    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        
      return true
    }

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
{
    return CGSize(width:collectionView.frame.size.width, height: collectionView.frame.size.height)
}
}


//MARK:- Class Of Lare View Controller Cell


class LargeViewCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var largeCollectionViewCellImage: UIImageView!
 
    //variables for protocols
   
   
   
    }
