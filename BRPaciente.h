//
//  BRPaciente.h
//  CocoaHeadsBrasilia
//
//  Created by IRAWILD ALMADA on 26/10/14.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "BEPaciente.h"

typedef void (^RetornarUnicoBlock)(BEPaciente *paciente, NSError *error);
typedef void (^PesquisarBlock)(NSArray *pacientes, NSError *error);
typedef void (^SalvarBlock)(BOOL pacienteSalvo, NSError *error);

@interface BRPaciente : NSObject

+(void)pesquisarPacienteWithObjectId:(NSString*)objectId andBlock:(RetornarUnicoBlock)block;

@end
