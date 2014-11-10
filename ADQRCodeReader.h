//
//  ADQRCodeReader.h
//
//  Created by IRAWILD ALMADA on 28/08/14.
//  Copyright (c) 2014 Almadata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADQRCodeViewController.h"

typedef void (^ReadBlock)(NSString *qrCode, NSError *error);

typedef enum EncodeType : NSUInteger {
    kClear,
    kBase64,
    kDoubleBase64
} EncodeType;

@interface ADQRCodeReader : NSObject

-(void)readWithViewController:(UIViewController*)viewController andEncodeType:(EncodeType)encodeType andReadBlock:(ReadBlock)block;

@end
