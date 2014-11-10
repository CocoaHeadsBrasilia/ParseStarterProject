//
//  CHPacienteViewController.h
//  CocoaHeadsBrasilia
//
//  Created by IRAWILD ALMADA on 26/10/14.
//
//

#import <UIKit/UIKit.h>
#import "BRPaciente.h"
#import "BEPaciente.h"

@interface CHPacienteViewController : UIViewController

@property (nonatomic, strong) BEPaciente *paciente;
@property (strong, nonatomic) IBOutlet UILabel *nome;
@property (strong, nonatomic) IBOutlet UILabel *matricula;
@property (strong, nonatomic) IBOutlet UILabel *sexo;

- (IBAction)identificarPaciente:(id)sender;


@end
