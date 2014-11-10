//
//  ADQRCodeReader.m
//
//  Created by IRAWILD ALMADA on 28/08/14.
//  Copyright (c) 2014 Almadata. All rights reserved.
//

#import "ADQRCodeReader.h"

@implementation ADQRCodeReader

-(void)readWithViewController:(UIViewController*)viewController andEncodeType:(EncodeType)encodeType andReadBlock:(ReadBlock)block
{
    ADQRCodeViewController *qrReader = [[ADQRCodeViewController alloc] init];
    [viewController.view addSubview:qrReader.view];
    [qrReader startReadingWithBlock:^(NSString *qrCode, NSError *error)
     {
         [qrReader.view removeFromSuperview];
         if (!qrCode && !error)
         {
             block(qrCode, error);
             return;
         }
         switch (encodeType) {
             case kClear:
                 block(qrCode, error);
                 break;
             case kBase64:
                 block([self decodeBase64WithString:qrCode],error);
                 break;
             case kDoubleBase64:
                 block([self decodeBase64WithString:[self decodeBase64WithString:qrCode]], error);
                 break;
             default:
                 block(qrCode, error);
                 break;
         }
     }];
}

-(NSString*)decodeBase64WithString:(NSString*)string
{
    if (!string)
        return @"";
    
    if (string == [NSNull null])
        return @"";
    
    if ([string isEqualToString:@""])
        return string;
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:string options:0];
    return [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
}

@end
