//
//  ViewController.swift
//  mylabeluserlocation
//
//  Created by Muhammed Essa on 1/19/20.
//  Copyright © 2020 Muhammed Essa. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate{
    
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var moreinfo: UILabel!
    
    
    
    
    
    

    var manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
    //    print(locations)
        let location = locations[0]
        latitude.text = String( location.coordinate.latitude )
        longitude.text = String( location.coordinate.longitude )
        speed.text = String( location.speed )
        altitude.text = String( location.altitude )
     
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if(error != nil){
                print( error )
            }else{
                if let placemark = placemarks?[0]{
                    var gaddress = ""
                    if placemark.subThoroughfare != nil {
                        gaddress += placemark.subThoroughfare! + " "
                    }
                    if placemark.subLocality != nil {
                                    gaddress += placemark.subLocality! + "\n"
                                }
                    if placemark.thoroughfare != nil {
                                    gaddress += placemark.thoroughfare! + "\n"
                                }
                    if placemark.subAdministrativeArea != nil {
            gaddress += placemark.subAdministrativeArea! + "\n"
                                }
                    if placemark.postalCode != nil {
                       gaddress += placemark.postalCode! + "\n"
                                }
                    if placemark.country != nil {
                          self.address.text = placemark.country! + "\n"
                                    gaddress += placemark.country! + "\n"
                                }
                     
                    self.moreinfo.text = gaddress  
                    print(gaddress)
                }
            }
        }
        
    }


}

