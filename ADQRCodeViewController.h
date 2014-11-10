//
//  ADQRCodeViewController.h
//
//  Created by IRAWILD ALMADA on 20/10/14.
//  Copyright (c) 2014 Almadata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

//Block para retorno assíncrono do código lido ou de informação de ocorrência de erro
typedef void (^ReadQRCodeBlock)(NSString *qrCode, NSError *error);

//Criação do UIViewController conformando-o ao protocolo de delegate de captura de metadados pelo objeto output da sessão de captura
@interface ADQRCodeViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) IBOutlet UIView *captureView;     //View que é usada para renderizar a layer de output das imagens capturadas
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;      //Label para exibir informações sobre o andamento do processo
@property (strong, nonatomic) IBOutlet UIButton *btnStartStop;  //Botão para retornar, caso o usuário deseje cancelar a operação de captura

@property (strong, nonatomic) ReadQRCodeBlock localReadQRCodeBlock;
@property (strong, nonatomic) NSString *valorLido;

//- (IBAction)btnStartStopSelected:(id)sender;
- (IBAction)btnVoltarSelected:(id)sender;
-(void)startReadingWithBlock:(ReadQRCodeBlock)readQRCodeBlock;
-(void)stopReading;

@end
