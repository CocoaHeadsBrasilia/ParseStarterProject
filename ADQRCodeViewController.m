//
//  ADQRCodeViewController.m
//
//  Created by IRAWILD ALMADA on 20/10/14.
//  Copyright (c) 2014 Almadata. All rights reserved.
//

#import "ADQRCodeViewController.h"

@interface ADQRCodeViewController ()

//Objeto de sessão de captura
@property (nonatomic, strong) AVCaptureSession *captureSession;

//Objeto para renderização das imagens capturadas
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

//Flag para indicação da leitura
@property (nonatomic) BOOL isReading;

//Objeto para reprodução de áudio
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

-(void)loadBeepSound;

@end

@implementation ADQRCodeViewController

- (IBAction)btnVoltarSelected:(id)sender
{
    self.localReadQRCodeBlock(nil,nil);
}

- (void)startReadingWithBlock:(ReadQRCodeBlock)readQRCodeBlock {
    
    
    self.localReadQRCodeBlock = readQRCodeBlock;
    
    //Criação do objeto que promove acesso ao hardware de captura de vídeo.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    //Objeto de erro para ser passado como referência na criação do objeto input
    NSError *error;
    
    //Criação do objeto input, vinculando-o ao device anteriormente criado para intereptar a captura.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    //Verificação de ocorrência de erro na criação do objeto de input, que
    //pode ser problema do device ou uma não autorização do usuário para uso da câmera.
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        self.localReadQRCodeBlock(nil, error);
        return;
    }
    
    //Cria a sessão de captura
    _captureSession = [[AVCaptureSession alloc] init];
    
    //Adiciona o objeto input à sessão de captura
    [_captureSession addInput:input];
    
    //Cria o objeto output para identificar metadados nas imagens capturadas
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    //Adiciona o objeto output à sessão de captura
    [_captureSession addOutput:captureMetadataOutput];

    //Cria o coordenador de fila de processamento
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    
    //Configura o output para usar este ViewController como seu delegate e o dispatchQueue como organizador da fila de execução
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    //Definie que o tipo de metadados que será rastreado pelo output será apenas QRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];

    //Cria a layer associando-a à sessão de captura
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];

    //Define a forma de exibição da imagem capturada à layer sem ajustes
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    //Define o tamanho do quadro da layer como sendo o tamanho do frame da UIView
    [_videoPreviewLayer setFrame:self.captureView.layer.bounds];
    
    //Adiciona a layer como sublayer da UIView para exibição das imagens
    [self.captureView.layer addSublayer:_videoPreviewLayer];

    //Inicia a sessão de captura
    [_captureSession startRunning];
}

-(void)stopReading
{
    //Encerra a sessão de captura
    [_captureSession stopRunning];
    _captureSession = nil;
  
    //Remove a layer da UIView
    [_videoPreviewLayer removeFromSuperlayer];

    //Retorna via Block o valor lido
    self.localReadQRCodeBlock(self.valorLido, nil);

    //Remove a view do leitor da UIView que a adicionou como filha
    [self.view removeFromSuperview];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0)
    {
        //Captura o primeiro objeto do array de metadados recebido pelo delegate
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];

        //Verfica se o tipo de metadado capturado é um QRCode. No caso específico dessa nossa implementação
        //este teste é dispensável uma vez que o único tipo de metadado que configuramos no nosso objeto de output
        //é o tipo de QRCode.
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode])
        {
            //Atribui o valor do QRCode lido à propriedade local valorLido para posterior retorno assíncrono
            [self setValorLido:[metadataObj stringValue]];
            
            //Uma vez identificado um QRCode válido chama o selector de encerramento da sessão em background
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            
            _isReading = NO;
            
            if (_audioPlayer)
            {
                //Toda vez que um QRCode for lido, um som é emitido para indicar que a leitura ocorreu
                [_audioPlayer play];
            }
        }
    }    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isReading = NO;
    _captureSession = nil;
    [self loadBeepSound];
// Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadBeepSound
{
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    NSError *error;
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        [_audioPlayer prepareToPlay];
    }
}

@end
