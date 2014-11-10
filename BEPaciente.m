//
//  BEPaciente.m
//  CocoaHeadsBrasilia
//
//  Created by IRAWILD ALMADA on 26/10/14.
//
//

#import "BEPaciente.h"

@implementation BEPaciente

@dynamic matricula;
@dynamic nome;
@dynamic sexo;

+(NSString*)parseClassName
{
    return @"Paciente";
}

@end
