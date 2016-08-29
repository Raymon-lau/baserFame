//
//  RMMapLocation.m
//  StaffManagement
//
//  Created by 刘闻天 on 16/4/14.
//  Copyright © 2016年 Raymon. All rights reserved.
//

#import "RMMapLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface RMMapLocation ()<CLLocationManagerDelegate,UIAlertViewDelegate>
@property (strong, nonatomic)CLLocationManager *locManager;

@end

@implementation RMMapLocation

+ (instancetype)sharedGpsManager
{
    static id mapLocation;    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!mapLocation) {
            mapLocation = [[RMMapLocation alloc] init];
        }
    });
    return mapLocation;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getCurrentLocation];
    }
    return self;
}



- (void)getCurrentLocation
{
    self.locManager = [[CLLocationManager alloc] init];
    self.locManager.delegate = self;
    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locManager.distanceFilter = 10.0;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //使用期间
//        [self.locManager requestWhenInUseAuthorization];
        //始终
        [self.locManager requestAlwaysAuthorization];
    }

}



- (void)getGps:(void (^)(double lat, double lng))gps
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        NSLog(@"请打开您的位置服务!");
        [RMUtils alertWithTitle:@"设置" message:@"请打开您的位置服务!" delegate:self tag:101 cancelButtonTitle:@"不允许" otherButtonTitles:@"允许"];
    }
    
    if ([CLLocationManager locationServicesEnabled] == NO) {
        
        return;
    }
    saveGpsCallBack = [gps copy];
//    [self.locManager stopUpdatingLocation];
    [self.locManager startUpdatingLocation];
}

+ (void)getGps:(void (^)(double, double))block
{
    [[RMMapLocation sharedGpsManager] getGps:block];
}

- (void)stop
{
    [self.locManager stopUpdatingLocation];
}

+ (void)stop
{
    [[RMMapLocation sharedGpsManager] stop];
}

#pragma mark - locationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    RMLog(@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    double latitude = newLocation.coordinate.latitude;
    double longitude = newLocation.coordinate.longitude;
    if (saveGpsCallBack) {
        saveGpsCallBack(latitude,longitude);
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    RMLog(@"%@",error);
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locManager requestAlwaysAuthorization];
            }
            break;
            
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //定位服务设置界面
        NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
