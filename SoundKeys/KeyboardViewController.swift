//
//  KeyboardViewController.swift
//  SoundKeys
//
//  Created by Phil Scarfi on 1/26/15.
//  Copyright (c) 2015 Pioneer Mobile Applications. All rights reserved.
//

import UIKit
import AudioToolbox

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var sound1Button: UIButton!
    @IBOutlet var sound2Button: UIButton!
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        configureNextKeyboardButton()
        configureSoundButtons()
    }
    func registerNib() {
        // Register nib
        let nib = UINib(nibName: "KeyboardView", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        view = objects[0] as UIView;
    }
    func configureNextKeyboardButton() {
        // Add Next Keyboard Button
        nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
       nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        nextKeyboardButton.sizeToFit()
        nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        view.addSubview(self.nextKeyboardButton)
        
        // Set Next Keyboard Button Constraints
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }
    func configureSoundButtons() {
        // Configure Button Appearance
       sound1Button.backgroundColor = UIColor.blackColor()
       sound1Button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
       sound2Button.backgroundColor = UIColor.blueColor()
       sound2Button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
    
    // Key Press delegate methods
    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

    
    @IBAction func playSound1(sender: UIButton) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if let alertPath = NSBundle.mainBundle().pathForResource("drumroll", ofType: "wav") {
                if let alertURL = NSURL(fileURLWithPath: alertPath) {
                    let alertSound = alertURL as CFURLRef
                    var soundID:SystemSoundID = 0;
                    AudioServicesCreateSystemSoundID(alertSound, &soundID)
                    AudioServicesPlaySystemSound(soundID)
                }
            }
        }
    }
    
    @IBAction func playSound2(sender: UIButton) {

    }

}
