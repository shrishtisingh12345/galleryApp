//
//  CollectionViewCell.swift
//  imagegallery2
//
//  Created by shrishti singh on 04/08/21.
//

import UIKit

protocol DeletePhotoCell {
    func passData(cell:CollectionViewCell)
    
}
class CollectionViewCell: UICollectionViewCell {

    //IBOutlet for UIcollection view cell
    
    @IBOutlet weak var smallImage: UIImageView!
    @IBOutlet weak var deleteButtonBackgroundView: UIView!
    
    var delegate: DeletePhotoCell?
    
    
    
    //every time the isinediting mode change its going to update the button bg
    var isInEditing:Bool = true {
        didSet{
            
            deleteButtonBackgroundView.backgroundColor = .white
            deleteButtonBackgroundView.isHidden = !isInEditing
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        delegate?.passData(cell: self)
    }
    
   
}


