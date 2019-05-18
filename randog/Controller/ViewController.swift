//
//  ViewController.swift
//  randog
//
//  Created by Ge on 5/13/19.
//  Copyright © 2019 Veronica Ge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    let breeds: [String] = ["greyhound", "poodle"] //these are just the default breeds to display in that picker view.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }
    
    //[CHAINING!!!] call the requestRandomImage function, which will inside it call the request image file
        
    //the completion handler:
        //Step 1: run the requestRandomImage function, at completion of this function, perform the completion handler, which is the handleRandomResponse function in this case.

    //        DogAPI.requestRandomImage(completionHandler: handleRandomResponse(imageData:error:))
    //    [MOVED INTO THE PICKER VIEW EXTENSION BELOW.
    
    
    //Helper Function 1 - get the random image struct through completion handler:
    func handleRandomResponse(imageData:DogImage?, error: Error?){
        
        //Step 1. extract the url from the struct named "imageData".
        guard let imageUrl = URL(string: imageData?.message ?? "") else {
            print("cannot create url")
            return
        }
        
        //Step 2. pass the image url to Helper Function 2 to set UIImage.
        DogAPI.requestImageFile(url: imageUrl, completionHandler: self.handleImageFileResponse(image:error:))
    }

    
    //Helper Function 2 - set the actual image to UIImage through the completion handler.
    func handleImageFileResponse(image: UIImage?, error: Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
            }
    }

}   //Must close the VC here so that the extension is not being interpreted as nested inside the VC.  (https://stackoverflow.com/questions/28554231/about-declaration-is-only-valid-at-file-scope)


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    //only ask the user to select 1 option from the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //populate the picker view with an array called breeds.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    //this is what happens when the pickerview stops spinning and the row has been slelected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(completionHandler: handleRandomResponse(imageData:error:))
    }
}



