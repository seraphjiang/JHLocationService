//
//  ViewController.swift
//  JHLocationService
//
//  Created by jianghuan on 05/17/2016.
//  Copyright (c) 2016 jianghuan. All rights reserved.
//

import UIKit
import CoreLocation
import JHLocationService

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var lon: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        JHLocationService.instance.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        if !CLLocationManager.locationServicesEnabled() {
            show("you need to enable location service")
        }
        else {
            if CLLocationManager.authorizationStatus() != .AuthorizedAlways {
                show("you need to grant 'Always' permisson for location service ")
                
                JHLocationService.instance.locationManager.requestAlwaysAuthorization()
            }
        }
        
        lat.text = String(JHLocationService.instance.currentLocation?.coordinate.latitude)
        lon.text = String(JHLocationService.instance.currentLocation?.coordinate.longitude)
        
    }
    
    @IBAction func onUpdate(sender: AnyObject) {
        lat.text = String(JHLocationService.instance.currentLocation?.coordinate.latitude)
        lon.text = String(JHLocationService.instance.currentLocation?.coordinate.longitude)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status != .AuthorizedAlways {
//            print(status)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func show(message: String) -> Void {
        if var topController = UIApplication.sharedApplication().keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            let alertView = UIView(frame: CGRectMake(0, -80, UIScreen.mainScreen().bounds.width, 80))
            alertView.backgroundColor = UIColor.darkGrayColor()
            
            //Create a label to display the message and add it to the alertView
            let width = alertView.bounds.width
            let theMessage = UILabel(frame: CGRectMake(20, 0, width - 40, CGRectGetHeight(alertView.bounds)));
            theMessage.numberOfLines = 0
            theMessage.lineBreakMode = .ByWordWrapping;
            
            theMessage.text = message
            theMessage.textColor = UIColor.whiteColor()
            alertView.addSubview(theMessage)
            
            topController.view.addSubview(alertView)
            
            //Create the ending frame or where you want it to end up on screen, in this case 0 y origin
            var newFrm = alertView.frame;
            newFrm.origin.y = 0;
            
            //Animate it in
            UIView.animateWithDuration(
                1,
                delay:0,
                options:[],
                animations: {
                    alertView.frame.origin.y = 0
                },
                completion: { (finished: Bool) in
                    UIView.animateWithDuration(
                        0.5,
                        delay:2,
                        options:[],
                        animations: {
                            alertView.frame.origin.y = -80
                        },
                        completion: { (f:Bool) in
                            alertView.removeFromSuperview()
                    })
            })
            
        }
    }

}

