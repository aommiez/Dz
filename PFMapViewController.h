//
//  PFMapViewController.h
//  DanceZone
//
//  Created by aOmMiez on 10/9/56 BE.
//  Copyright (c) 2556 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFMapView.h"
#import "CMMapLauncher.h"

@interface PFMapViewController : UIViewController<CLLocationManagerDelegate>
@property (retain, nonatomic) IBOutlet PFMapView *mapView;
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) CLLocation *currentLocation;
@end
