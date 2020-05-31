//
//  CreateNewDishViewController.swift
//  RestaurantManager_DATN
//
//  Created by Hoang Dinh Huy on 5/31/20.
//  Copyright © 2020 Hoang Dinh Huy. All rights reserved.
//

class DishManagerViewController : UIViewController {

    @IBOutlet weak var imvDishImage: UIImageView!
    @IBOutlet weak var txtDishName: UITextField!
    @IBOutlet weak var txtDishPrice: UITextField!
    @IBOutlet weak var txtDishUnit: UITextField!
    @IBOutlet weak var txtDishDescription: UITextField!
    @IBOutlet weak var txtDishCategory: UITextField!
    @IBOutlet weak var swIsInMenu: UISwitch!
    
    var dish: MonAn?
    
    private var pickedImageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtDishCategory.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(txtCategoryTapped))
        txtDishCategory.addGestureRecognizer(tapGesture)
    }
    
    @objc private func txtCategoryTapped() {
        let presentHandler = PresentHandler()
        presentHandler.presentManagerDataVC(self, manageType: .dishCategory, isForPickData: true)
    }

    @IBAction func imvDishImageWasTapped(_ sender: Any) {
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.mediaTypes = ["public.image"]
        
        self.presentInFullScreen(imagePicker, animated: true)
    }
    
    @IBAction func btnConfirmWasTapped(_ sender: Any) {
        
        let dishName = txtDishName.text ?? ""
        let dishPrice = txtDishPrice.text ?? ""
        let dishUnit = txtDishUnit.text ?? ""
        let dishDescription = txtDishDescription.text ?? ""
        let dishCategory = txtDishCategory.text ?? ""
        let isInMenu = swIsInMenu.isOn ? 1 : 0
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        if dish == nil {
            let db = Firestore.firestore()
            dish = MonAn()
            if let pickedImageData = pickedImageData {
                let imageRef = storageRef.child("DishImage/" + dish!.idmonan + ".jpg")
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpeg"
                imageRef.putData(pickedImageData, metadata: metaData) { (_, _) in
                    
                    imageRef.downloadURL { (url, error) in
                        guard let downloadURL = url else { return }
                        db.collection("MonAn").document(self.dish!.idmonan!).setData([
                            "idmonan": self.dish!.idmonan!,
                            "tenmonan": dishName,
                            "donvimonan": dishUnit,
                            "dongia": dishPrice,
                            "motachitiet": dishDescription,
                            "idtheloaimonan": dishCategory,
                            "diachianh": downloadURL.absoluteString,
                            "trongthucdon": isInMenu
                        ]) { err in
                            
                        }
                    }
                }
            }
        }
        
        self.dismiss(animated: true)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension DishManagerViewController: UINavigationControllerDelegate {
    
}

extension DishManagerViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let type = info[.mediaType] as? String
        
        if type == "public.image",
            let image = info[.originalImage] as? UIImage,
            let data = image.jpegData(compressionQuality: 1.0) as NSData? {
            imvDishImage.image = image
            pickedImageData = data as Data
        }
        self.dismiss(animated: true)
    }
}

extension DishManagerViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == txtDishCategory {
//            return false
//        }
//        return true
//    }
}
