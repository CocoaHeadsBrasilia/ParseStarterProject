//
//  CHPacienteViewController.m
//  CocoaHeadsBrasilia
//
//  Created by IRAWILD ALMADA on 26/10/14.
//
//

#import "CHPacienteViewController.h"
#import "ADQRCodeReader.h"

@interface CHPacienteViewController ()

@end

@implementation CHPacienteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)identificarPaciente:(id)sender
{
    ADQRCodeReader *reader = [[ADQRCodeReader alloc] init];
    [reader readWithViewController:self andEncodeType:kClear andReadBlock:^(NSString *qrCode, NSError *error)
    {
        if (!error)
        {
            [BRPaciente pesquisarPacienteWithObjectId:qrCode andBlock:^(BEPaciente *paciente, NSError *brError)
            {
                if (!error)
                {
                    self.paciente = paciente;
                    self.nome.text = self.paciente.nome;
                    self.matricula.text = [self.paciente.matricula stringValue];
                    self.sexo.text = self.paciente.sexo;
                }
                else
                {
                    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Falha"
                                                                         message:@"Paciente não encontrado."
                                                                        delegate:nil
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil, nil];
                    [errorAlert show];
                }
            }];
            
            //NSLog(@"QRCode lido com o valor %@", qrCode);
        }
    }];
}

@end
