//
//  HMDataSet.h
//  HotmobLibrary
//
//  Created by Chiu on 14/11/2017.
//  Copyright © 2017 Choi Wing Chiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMDataSet : NSObject

- (instancetype) init;

- (void) add:(NSString*)key withValue:(NSString*)value;

@end
