//
//  HMDataCollection.h
//  HotmobLibrary
//
//  Created by Chiu on 14/11/2017.
//  Copyright © 2017 Choi Wing Chiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMDataSet.h"

@interface HMDataCollection : NSObject
+ (void) captureEvent:(NSString*)key withValue:(NSString*)value;

+ (void) captureEvent:(NSString*)key withDictionary:(NSDictionary*)value;

+ (void) captureEvent:(NSString*)key withDataSet:(HMDataSet*)value;
@end
