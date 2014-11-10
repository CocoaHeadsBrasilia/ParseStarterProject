//
//  BRPaciente.m
//  CocoaHeadsBrasilia
//
//  Created by IRAWILD ALMADA on 26/10/14.
//
//

#import "BRPaciente.h"

@implementation BRPaciente

+(void)pesquisarPacienteWithObjectId:(NSString*)objectId andBlock:(RetornarUnicoBlock)block
{
    PFQuery *query = [PFQuery queryWithClassName:[BEPaciente parseClassName]];
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *paciente, NSError *error)
     {
         NSLog(@"%@", paciente);
         block((BEPaciente*)paciente, error);
     }];
}

@end
