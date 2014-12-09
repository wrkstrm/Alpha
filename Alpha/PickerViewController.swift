//
//  File.swift
//  Alpha
//
//  Created by Cristian Monterroza on 12/9/14.
//  Copyright (c) 2014 wrkstrm. All rights reserved.
//

import UIKit

class PickerViewContrller : UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate , AFPhotoEditorControllerDelegate {
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
            weak var that = self
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                var editorController = AFPhotoEditorController(image:
                    info[UIImagePickerControllerOriginalImage] as UIImage)
                editorController.delegate = self
                that?.presentViewController(editorController, animated: true, completion: nil)
            })
    }
    
    func photoEditor(editor: AFPhotoEditorController!, finishedWithImage image: UIImage!) {
        pickButton.setImage(image, forState: UIControlState.Normal)
        var scaledImage = image.imageByScalingProportionallyToSize(pickButton.frame.size)
        pickButton.setBackgroundImage(scaledImage, forState: UIControlState.Normal)
        pickButton.tintColor = UIColor.clearColor()
        let center = pickButton.center
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func photoEditorCanceled(editor: AFPhotoEditorController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}