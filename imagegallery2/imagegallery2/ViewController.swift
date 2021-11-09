//
//  ViewController.swift
//  imagegallery2
//
//  Created by shrishti singh on 04/08/21.
//

import UIKit
import Photos

//MARK:- Main View Controller Class

class ViewController: UIViewController{
    
    //MARK:- Variable For PHAssests For Image Array
   var picImages = [PHAsset]()
    var imageArray = [UIImage]()
        
    
    
    //MARK:- IBOutlets For Collection View
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
   
  
    @IBAction func deletedbtn(_ sender: Any) {
        if let selectedCells = collectionViewOutlet.indexPathsForSelectedItems{
            let items = selectedCells.map { $0.item }.sorted().reversed()
            for item in items {
                      num.remove(at: item)
                  }
            collectionViewOutlet.deleteItems(at: selectedCells)
            collectionViewOutlet.reloadData()
        }
        }
    
    
   @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    //MARK:- View Did Load
        
        override func viewDidLoad() {
            super.viewDidLoad()
            collectionViewOutlet.delegate = self
            collectionViewOutlet.dataSource = self
            navigationItem.leftBarButtonItem = editButtonItem
            
            collectionViewOutlet.reloadData()
            Pic()
        }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)

        collectionViewOutlet.allowsMultipleSelection = editing
        let indexPaths = collectionViewOutlet.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionViewOutlet.cellForItem(at: indexPath) as! CollectionViewCell
            cell.isInEditing = editing
        }
    }
    
    
    //MARK:- IBAction For Camera Button
    
    @IBAction func cameraButton(_ sender: Any) {
        let cam = UIImagePickerController()
        cam.sourceType = .camera
        cam.delegate = self
        cam.allowsEditing = true
        
        present(cam, animated: true, completion: nil)
        
    }
    
    //MARK:- Adding Photos in the collection view
    
    @IBAction func addPhotos(_ sender: Any) {
        
       
        let imageAdd = UIImagePickerController()
        imageAdd.sourceType = .photoLibrary
        imageAdd.delegate = self
        imageAdd.allowsEditing = true
        
        present(imageAdd, animated: true, completion: nil)
        
        
    }
    //MARK:- Function For Authorization and Data Detching
        private func Pic(){
            
            PHPhotoLibrary.requestAuthorization { (status) in
                print(status)
                
                
                if status == .authorized {
                    let assest = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                    
                    assest.enumerateObjects { (object, _, _) in
                        print(object)
                        
                        self.picImages.append(object)
                    }
                    self.picImages.reverse()
                    
                    DispatchQueue.main.async {
                        self.collectionViewOutlet.reloadData()
                    }
                }
            }
            
            
        }
    
    
    
}



//MARK:- Extension For the collection

extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //METHOD:-  Protocols of DElegate And Data Source
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return imageArray.count
        return num.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "celliden", for: indexPath) as! CollectionViewCell
       // if cell is in editing mode then edit
        cell.isInEditing = isEditing
        
        
        cell.smallImage.image = num[indexPath.row]
        
        //delegate from collection View Cell in that there is a protocol
        cell.delegate = self as? DeletePhotoCell
        return cell
     
    }
   

    //MARK:- Size OF the Collection View Cell And Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width-30)/3, height: (collectionView.frame.size.width-30)/3)
    }

    
    
    
    //MARK:- Did Select Marthod Of Collection View
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LargeViewController") as! LargeViewController
        
                 vc.num = num
       
                self.navigationController?.pushViewController(vc, animated: true)
        
       
                
    }
     
        }

   extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print("\(info)UIImagePickerControllerEditedImage")
        
        
        if let pickedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
          
            
            //num = pickedImage
            
            num.append(pickedImage)
            
            
            //imageArray.append(pickedImage)
            self.collectionViewOutlet.reloadData()
            if num.count == 0 {
            self.collectionViewOutlet.insertItems(at: [IndexPath(item:num.count-1, section: 0)])
            }
            
            
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

//Protocol for that function
extension ViewController: DeletePhotoCell {
    
    
    func passData(cell: CollectionViewCell) {
        if let indexPath = collectionViewOutlet?.indexPath(for: cell){
            num.remove(at: indexPath.item)
            
            collectionViewOutlet?.deleteItems(at: [indexPath])
        }
    }
    
    
}
