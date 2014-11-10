//
//  BEPaciente.h
//  CocoaHeadsBrasilia
//
//  Created by IRAWILD ALMADA on 26/10/14.
//
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>

@interface BEPaciente : PFObject <PFSubclassing>

@property (nonatomic, strong) NSNumber *matricula;
@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSString *sexo;

@end
