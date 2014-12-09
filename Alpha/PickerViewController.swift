//
//  File.swift
//  Alpha
//
//  Created by Cristian Monterroza on 12/9/14.
//  Copyright (c) 2014 wrkstrm. All rights reserved.
//

import UIKit

class PickerViewContrller : UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    var image:UIImage?
    @IBOutlet var pickButton: UIButton!
    
    override func awakeFromNib() {
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    @IBAction func pick(sender: UIButton) {
        var picker = UIImagePickerController();
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceType.Camera;
        picker.cameraDevice = UIImagePickerControllerCameraDevice.Front
        picker.modalPresentationStyle = UIModalPresentationStyle.FullScreen;
        picker.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve;
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        picker.navigationBar.tintColor = UIColor.blackColor()
        picker.navigationBar.backgroundColor = UIColor.blackColor()
        picker.navigationBar.translucent = false
        picker.view.backgroundColor = UIColor.blackColor()
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            image = UIImage.resizeImage(info[UIImagePickerControllerOriginalImage] as UIImage,
                newSize: CGSizeMake(200, 200))
            image = image?.imageRotatedByDegrees(90.0)
            pickButton.setImage(image, forState: UIControlState.Normal)
            self.dismissViewControllerAnimated(true, completion: nil)
    }
}