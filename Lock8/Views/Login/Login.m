//
//  Login.m
//  Lock8
//
//  Created by Angel Rivas on 4/14/15.
//  Copyright (c) 2015 Tecnologizame. All rights reserved.
//

#import "Login.h"
#import <QuartzCore/QuartzCore.h>
#import "Unidades.h"


extern NSString* dispositivo;
extern NSString* documentsDirectory;
extern NSString* url_web_service;
extern NSString* GlobalString;
extern NSString* GlobalUsu;
extern NSString*Globalpass;

NSMutableArray*  MArrayFlota;
NSMutableArray*  MArrayEco;
NSMutableArray*  MArrayID;
NSMutableArray*  MArrayIP;
NSMutableArray*  MArrayLatitud;
NSMutableArray*  MArrayLongitud;
NSMutableArray*  MArrayAngulo;
NSMutableArray*  MArrayVelocidad;
NSMutableArray*  MArrayFecha;
NSMutableArray*  MArrayEvento;
NSMutableArray*  MArrayEstatus;
NSMutableArray*  MArrayIcono;
NSMutableArray*  MArrayUbicacion;
NSMutableArray*  MArrayMotor;
NSMutableArray*  MArrayTelefono;
NSMutableArray*  MArrayMensajes;
NSMutableArray*  MArrayIcono_Mapa;

NSString* limite_velocidad;
NSString* tiempo_unidad_ociosa;
NSString* mapas;
NSString* busqueda;
extern NSString* vista_activa;
extern CGRect rect_original_login;
extern CGRect rect_original_unidades;
extern UIView* sub_contenedor_incidencia;

@interface Login (){
    BOOL checked;
    NSString* img_1;
    NSString* img_2;
    NSString* img_3;
    NSString* img_4;
    NSString* img_5;
    int contador_bienvenida;
    NSTimer* contadorTimer;
    BOOL AjustarTeclado;
    BOOL stayup;
    CGFloat height_keyboard;
    NSString *remoteHostName;
    BOOL reachable;
    SYSoapTool *soapTool;
    NSMutableArray* autocompletar_usuarios;
    NSMutableArray* MAUsuarios;
    NSString* metodo_;
    NSString* fileName_Cookies;
    
}

@end

@implementation Login



-(NSString*)ReadFileRecordar{
    NSString* fileName = [NSString stringWithFormat:@"%@/ConfigFile.txt", documentsDirectory];
    NSString *contents = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:nil error:nil];
    if (contents == nil && [contents isEqualToString:@""]) {
        contents = @"Error";
    }
    
    return contents;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    vista_activa = @"Login";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    remoteHostName = @"www.apple.com";
    
    autocompletar_usuarios = [[NSMutableArray alloc]init];
    
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
    
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachability startNotifier];
    [self updateInterfaceWithReachability:self.wifiReachability];
    
    
    contenedor_general = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:contenedor_general];
    
    
    img_presentation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [contenedor_general addSubview:img_presentation];
    
    contador_bienvenida = 1;
    
    
    UIImageView* img_logo = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - ((self.view.frame.size.width - 100)/2), 60, self.view.frame.size.width - 100, (292 / (681 / (self.view.frame.size.width - 100))))];
    img_logo.image = [UIImage imageNamed:@"logo"];
    [contenedor_general addSubview:img_logo];
    
    contenedor_txt = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - (self.view.frame.size.height / 2.5) , self.view.frame.size.width, self.view.frame.size.height / 2.5)];
    contenedor_txt.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
    [contenedor_general addSubview:contenedor_txt];
    
    rect_original_login = contenedor_general.frame;
    
    txt_usuario = [[UITextField alloc] initWithFrame:CGRectMake(10, contenedor_txt.frame.size.height *  0.04, contenedor_txt.frame.size.width - 20, contenedor_txt.frame.size.height *  0.20)];
    txt_usuario.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.4];
    //txt_usuario.placeholder = [NSString stringWithFormat:@"%@", NSLocalizedString(@"USER", nil)];
    txt_usuario.placeholder = @"Usuario";
    txt_usuario.keyboardType = UIKeyboardTypeEmailAddress;
    txt_usuario.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_usuario.textColor = [UIColor whiteColor];
    txt_usuario.delegate = self;
    [contenedor_txt addSubview:txt_usuario];
    
    txt_pass = [[UITextField alloc] initWithFrame:CGRectMake(10, contenedor_txt.frame.size.height *  0.30, contenedor_txt.frame.size.width - 20, contenedor_txt.frame.size.height *  0.20)];
    txt_pass.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.4];
    txt_pass.placeholder = @"Contraseña";
    txt_pass.secureTextEntry = YES;
    txt_pass.delegate = self;
    txt_pass.textColor = [UIColor whiteColor];
    [contenedor_txt addSubview:txt_pass];
    
    txt_usuario.clearButtonMode = UITextFieldViewModeWhileEditing;
    txt_pass.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UILabel* recordar_ = [[UILabel alloc] initWithFrame:CGRectMake(contenedor_txt.frame.size.width - 10 - (contenedor_txt.frame.size.width * 0.55), contenedor_txt.frame.size.height *  0.54, contenedor_txt.frame.size.width * 0.55, contenedor_txt.frame.size.height *  0.06)];
    recordar_.text = @"Recordar contraseña";
    recordar_.textColor = [UIColor whiteColor];
    recordar_.textAlignment = NSTextAlignmentRight;
    [contenedor_txt addSubview:recordar_];
    
    check_button = [[UIButton alloc] initWithFrame:CGRectMake(contenedor_txt.frame.size.width - 5 - (contenedor_txt.frame.size.width * 0.55) - (contenedor_txt.frame.size.height *  0.10), contenedor_txt.frame.size.height *  0.54, contenedor_txt.frame.size.height *  0.065, contenedor_txt.frame.size.height *  0.065)];
    [check_button addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    [check_button setImage:[UIImage imageNamed:@"checkbox-unchecked-gray-md"] forState:UIControlStateNormal];
    [contenedor_txt addSubview:check_button];
    
    btn_login = [[UIButton alloc] initWithFrame:CGRectMake(10, contenedor_txt.frame.size.height *  0.66, contenedor_txt.frame.size.width - 20, contenedor_txt.frame.size.height *  0.20)];
    [btn_login setTitle:@"Entrar" forState:UIControlStateNormal];
    //btn_login.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    [btn_login addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [btn_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    btn_login.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:34.0/255.0 blue:36.0/255.0 alpha:1];
    [contenedor_txt addSubview:btn_login];
    
    [btn_login.layer setCornerRadius:2];
    [btn_login.layer setMasksToBounds:YES];
    [btn_login.layer setCornerRadius:10];
    [btn_login.layer setMasksToBounds:YES];
    
    btn_olvide = [[UIButton alloc] initWithFrame:CGRectMake(10, contenedor_txt.frame.size.height *  0.90, contenedor_txt.frame.size.width - 20, contenedor_txt.frame.size.height *  0.06)];
    [btn_olvide setTitle:@"Olvide mi contraseña" forState:UIControlStateNormal];
    //btn_login.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    [btn_olvide addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [btn_olvide setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    btn_olvide.backgroundColor = [UIColor clearColor];
    [contenedor_txt addSubview:btn_olvide];
    
    
    img_1 = [NSString stringWithFormat:@"img1_%@", dispositivo];
    img_2 = [NSString stringWithFormat:@"img2_%@", dispositivo];
    img_3 = [NSString stringWithFormat:@"img3_%@", dispositivo];
    img_4 = [NSString stringWithFormat:@"img4_%@", dispositivo];
    img_5 = [NSString stringWithFormat:@"img5_%@", dispositivo];
    
    if ([dispositivo isEqualToString:@""]) {
        img_1 = [img_1 stringByReplacingOccurrencesOfString:@"_" withString:@""];
        img_2 = [img_2 stringByReplacingOccurrencesOfString:@"_" withString:@""];
        img_3 = [img_3 stringByReplacingOccurrencesOfString:@"_" withString:@""];
        img_4 = [img_4 stringByReplacingOccurrencesOfString:@"_" withString:@""];
        img_5 = [img_5 stringByReplacingOccurrencesOfString:@"_" withString:@""];
    }
    
    img_presentation.image = [UIImage imageNamed:img_1];
    
    contenedor_animacion = [[UIView alloc]initWithFrame:self.view.frame];
    contenedor_animacion.backgroundColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:0.5];
    contenedor_animacion.hidden = YES;
    [contenedor_general addSubview:contenedor_animacion];
    
    UIActivityIndicatorView* actividad_global = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    actividad_global.color = [UIColor colorWithRed:234.0/255.0 green:34.0/255.0 blue:36.0/255.0 alpha:1];
    actividad_global.hidesWhenStopped = TRUE;
    CGRect newFrames = actividad_global.frame;
    newFrames.origin.x = (contenedor_animacion.frame.size.width / 2) -13;
    newFrames.origin.y = (contenedor_animacion.frame.size.height / 2) - 13;
    actividad_global.frame = newFrames;
    actividad_global.backgroundColor = [UIColor clearColor];
    actividad_global.hidden = NO;
    [actividad_global startAnimating];
    [contenedor_animacion addSubview:actividad_global];
    
    [contenedor_animacion addSubview:actividad_global];
    
    contadorTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(actualizarimagen:) userInfo:nil repeats:YES];
    
    NSString* datos_usuario = [self ReadFileRecordar];
    
    if (![datos_usuario isEqualToString:@"Error"]) {
        NSArray *chunks2 = [datos_usuario componentsSeparatedByString: @"|"];
        if ([chunks2 count]==2){
            
            txt_usuario.text  = [NSString stringWithFormat:@"%@", [chunks2 objectAtIndex:0]];
            txt_pass.text  = [NSString stringWithFormat:@"%@", [chunks2 objectAtIndex:1]];
            [check_button setImage:[UIImage imageNamed:@"checkbox-checked-gray-md.png"] forState:UIControlStateNormal];
            checked = YES;
        }
    }
    
    fileName_Cookies = [NSString stringWithFormat:@"%@/ConfigFile_Cookies.txt", documentsDirectory];
    MAUsuarios  = [[NSMutableArray alloc]initWithContentsOfFile:fileName_Cookies];
    if (MAUsuarios==nil || [MAUsuarios count]==0) {
        MAUsuarios = [[NSMutableArray alloc]init];
    }
    
    autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(txt_usuario.frame.origin.x, txt_usuario.frame.origin.y + 30, txt_usuario.frame.size.width, 120) style:UITableViewStylePlain];
    autocompleteTableView.delegate = self;
    autocompleteTableView.dataSource = self;
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = YES;
    [contenedor_txt addSubview:autocompleteTableView];
    
    soapTool = [[SYSoapTool alloc]init];
    soapTool.delegate = self;
    
}


- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.hostReachability)
    {
      //  NetworkStatus netStatus = [reachability currentReachabilityStatus];
        BOOL connectionRequired = [reachability connectionRequired];
        if (connectionRequired)
            NSLog(@"Cellular data network is available.\nInternet traffic will be routed through it after a connection is established., Reachability text if a connection is required");
        else
           NSLog(@"Cellular data network is active.\nInternet traffic will be routed through it. Reachability text if a connection is not required");
    }
    
    if (reachability == self.internetReachability)
        [self ActualConnection:reachability];
    if (reachability == self.wifiReachability)
        [self ActualConnection:reachability];
}

-(void)ActualConnection:(Reachability*)reachability{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];

    
    switch (netStatus)
    {
        case NotReachable:{
            reachable = NO;
            connectionRequired = YES;
            break;
        }
        case ReachableViaWWAN:{
            reachable = YES;
            NSLog(@"Reachable WWAN");
            break;
        }
        case ReachableViaWiFi:{
            reachable = YES;
            NSLog(@"Reachable WiFi");
            break;
        }
    }
    
    if (connectionRequired)
    {
        NSLog(@"Connection Required");
        reachable = NO;
     //   NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
   //     statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    
}


-(IBAction)Login:(id)sender{
    NSString* error = @"";
 //   [txt_pass resignFirstResponder];
 //   [txt_usuario resignFirstResponder];
    if (!reachable)
        error = @"No existe conexión a internet";
    if ([[txt_pass.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        error= @"Debe insertar una contraseña valida";
        [txt_pass becomeFirstResponder];
    }
    if ([[txt_usuario.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        error= @"Debe insertar un usuario valido";
        [txt_usuario becomeFirstResponder];
    }
    if ([error isEqualToString:@""]) {
        NSString* fileName = [NSString stringWithFormat:@"%@%@", txt_usuario.text, @"_Velocidad.txt"];
        fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
        NSString* contents = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:nil error:nil];
        if (contents == nil || [contents isEqualToString:@""]) {
            
            limite_velocidad = @"90";
        }
        else{
            limite_velocidad = contents;
        }
        
        NSString* usuario_completo = txt_usuario.text;
        usuario_completo = [usuario_completo stringByAppendingString:@"+i+1.1"];
        
        
        fileName = [NSString stringWithFormat:@"%@%@", txt_usuario.text, @"_tiempo_unidad_ociosa.txt"];
        fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
        
        NSString *contentstiempo_unidad_ociosa = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:nil error:nil];
        if (contentstiempo_unidad_ociosa == nil || [contentstiempo_unidad_ociosa isEqualToString:@""]) {
            
            tiempo_unidad_ociosa = @"60";
            
        }
        else{
            tiempo_unidad_ociosa = contentstiempo_unidad_ociosa;
        }
        
        MArrayFlota = [[NSMutableArray alloc]init];
        MArrayEco = [[NSMutableArray alloc]init];
        MArrayID = [[NSMutableArray alloc]init];
        MArrayIP = [[NSMutableArray alloc]init];
        MArrayLatitud = [[NSMutableArray alloc]init];
        MArrayLongitud = [[NSMutableArray alloc]init];
        MArrayAngulo = [[NSMutableArray alloc]init];
        MArrayVelocidad = [[NSMutableArray alloc]init];
        MArrayFecha = [[NSMutableArray alloc]init];
        MArrayEvento = [[NSMutableArray alloc]init];
        MArrayEstatus = [[NSMutableArray alloc]init];
        MArrayIcono = [[NSMutableArray alloc]init];
        MArrayUbicacion = [[NSMutableArray alloc]init];
        MArrayMotor = [[NSMutableArray alloc]init];
        MArrayTelefono = [[NSMutableArray alloc]init];
        MArrayMensajes = [[NSMutableArray alloc]init];
        MArrayIcono_Mapa = [[NSMutableArray alloc]init];
        
        contenedor_animacion.hidden = NO;
        
        NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"usName", @"usPassword",@"usVelocidad", @"usMinSinReporte", nil];
        NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:usuario_completo, txt_pass.text, limite_velocidad, tiempo_unidad_ociosa, nil];
        metodo_ = @"GetPositions";
        [soapTool callSoapServiceWithParameters__functionName:@"GetPositions" tags:tags vars:vars wsdlURL:url_web_service];

    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"Lock8" message:error delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil] show];
        error = @"";
    }
}

-(IBAction)check:(id)sender{
    
    if (!checked) {
        [check_button setImage:[UIImage imageNamed:@"checkbox-checked-gray-md.png"] forState:UIControlStateNormal];
        checked = YES;
    }
    else{
        [check_button setImage:[UIImage imageNamed:@"checkbox-unchecked-gray-md.png"] forState:UIControlStateNormal];
        checked = NO;
    }
    
}

-(IBAction)actualizarimagen:(id)sender{
    contador_bienvenida++;
    UIImage* newImage = [UIImage imageNamed:img_1];
    switch(contador_bienvenida) {
        case 1:{
            newImage = [UIImage imageNamed:img_1];
        }
            break;
        case 2:{
            newImage = [UIImage imageNamed:img_2];
        }
            break;
        case 3:{
            newImage = [UIImage imageNamed:img_3];
            
        }
            break;
        case 4:{
            newImage = [UIImage imageNamed:img_4];
        }
            break;
        case 5:{
            newImage = [UIImage imageNamed:img_5];
            contador_bienvenida = 0;
        }
            break;
        default:
            break;
            
            // do something by default;
    }
    // set up an animation for the transition the content
    img_presentation.image = newImage;
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.1f;
    //  animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFilterLinear;
    animation.removedOnCompletion = YES;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [[img_presentation layer] addAnimation:animation forKey:@"SwitchToView1"];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.9f];
    
    
    
    [UIView commitAnimations];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    autocompleteTableView.hidden = YES;
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    autocompleteTableView.hidden = YES;
    [textField resignFirstResponder];
    return NO;
}


- (void)keyboardWillHide:(NSNotification *)notif {
   height_keyboard = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey ] CGRectValue].size.height;
    [self setViewMoveUp:NO];
}


- (void)keyboardWillShow:(NSNotification *)notif{
    height_keyboard = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey ] CGRectValue].size.height;
    [self setViewMoveUp:YES];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
 //   stayup = YES;
  //  [self setViewMoveUp:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
 //   stayup = NO;
 //   [self setViewMoveUp:NO];
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autocompletar_usuarios removeAllObjects];
    for(NSString *curString in MAUsuarios) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [autocompletar_usuarios addObject:curString];
        }
    }
    if ([autocompletar_usuarios count]>0) {
        autocompleteTableView.hidden = NO;
    }
    else{
        autocompleteTableView.hidden = YES;
    }
    [autocompleteTableView reloadData];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==txt_usuario) {
        NSString *substring = [NSString stringWithString:textField.text];
        substring = [substring stringByReplacingCharactersInRange:range withString:string];
        [self searchAutocompleteEntriesWithSubstring:substring];
    }
    return YES;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return autocompletar_usuarios.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    
    NSArray *chunks2 = [[autocompletar_usuarios objectAtIndex:indexPath.row] componentsSeparatedByString: @"|"];
    
    cell.textLabel.text = [chunks2 objectAtIndex:0];
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *chunks2 = [[autocompletar_usuarios objectAtIndex:indexPath.row] componentsSeparatedByString: @"|"];
    txt_usuario.text = [chunks2 objectAtIndex:0];
    txt_pass.text = [chunks2 objectAtIndex:1];
    autocompleteTableView.hidden = YES;
    [txt_usuario resignFirstResponder];
    //  [self goPressed];
    
}


//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMoveUp:(BOOL)moveUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2]; // if you want to slide up the view
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    if ([vista_activa isEqualToString:@"Login"]) {
        CGRect rect = contenedor_general.frame;
        if (moveUp)
        {
            // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
            // 2. increase the size of the view so that the area behind the keyboard is covered up.
            
            if (rect.origin.y == self.view.frame.origin.y ) {
                rect.origin.y = rect_original_login.origin.y - height_keyboard;
            }
            
        }
        else
        {
            if (stayup == NO) {
                rect.origin.y = rect_original_login.origin.y;
            }
        }
        contenedor_general.frame = rect;
        [UIView commitAnimations];
    }
    else{
 /*       CGRect rect = sub_contenedor_incidencia.frame;
        if (moveUp)
        {
            // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
            // 2. increase the size of the view so that the area behind the keyboard is covered up.
            
            if (rect.origin.y == rect_original_unidades.origin.y ) {
                rect.origin.y = -20;
            }
            
        }
        else
        {
            if (stayup == NO) {
                rect.origin.y = rect_original_unidades.origin.y;
            }
        }
        sub_contenedor_incidencia.frame = rect;*/
    }
}


-(void)retriveFromSYSoapTool:(NSMutableArray *)_data{
    StringCode = @"";
    StringMsg = @"";
    StringCode = @"-10";
    StringMsg = @"Error en la conexión";
    
    NSLog(@"%@", GlobalString);
    
    NSData* data = [GlobalString dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    if(![parser parse]){
        NSLog(@"Error al parsear");
        
        
    }
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}


//xml
-(void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"The XML document is now being parsed.");
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Parse error: %ld", (long)[parseError code]);
    [self FillArray];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    //Store the name of the element currently being parsed.
    currentElement = [elementName copy];
    
    //Create an empty mutable string to hold the contents of elements
    currentElementString = [NSMutableString stringWithString:@""];
    
    //Empty the dictionary if we're parsing a new status element
    if ([elementName isEqualToString:@"Response"]) {
        [currentElementData removeAllObjects];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //Take the string inside an element (e.g. <tag>string</tag>) and save it in a property
    [currentElementString appendString:string];
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"code"])
        StringCode = [currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([elementName isEqualToString:@"msg"])
        StringMsg = [currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([metodo_ isEqualToString:@"GetPositions"]) {
       /* if ([elementName isEqualToString:@"ocultar"])
            ocultar = [currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];*/
        if ([elementName isEqualToString:@"Flota"])
            [MArrayFlota addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Eco"])
            [MArrayEco addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"ID"])
            [MArrayID addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"IP"])
            [MArrayIP addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Latitud"])
            [MArrayLatitud addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Longitud"])
            [MArrayLongitud addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Angulo"])
            [MArrayAngulo addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Velocidad"])
            [MArrayVelocidad addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Fecha"])
            [MArrayFecha addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Evento"])
            [MArrayEvento addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Estatus"])
            [MArrayEstatus addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Icono"])
            [MArrayIcono addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Ubicacion"])
            [MArrayUbicacion addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Motor"])
            [MArrayMotor addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Telefono"])
            [MArrayTelefono addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Mensajes"])
            [MArrayMensajes addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        if ([elementName isEqualToString:@"Icono_mapa"])
            [MArrayIcono_Mapa addObject:[currentElementString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //Document has been parsed. It's time to fire some new methods off!
    
    [self FillArray];
    
}


-(void)FillArray{
    
    if ([metodo_ isEqualToString:@"GetPositions"]) {
        NSString* mensajeAlerta = StringMsg;
        
        NSInteger code = [StringCode intValue];
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Lock8"
                                                          message:mensajeAlerta
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        if (code <0) {
            contenedor_animacion.hidden = YES;
            [message show];
        }
        else if (code == 0){
            mensajeAlerta = @"El usuario no tiene unidades asignadas";
            [message show];
        }
        else{
            StringMsg = [StringMsg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            if ([StringMsg isEqualToString:@"ACTUALIZAR"]) {
                UIAlertView *messages = [[UIAlertView alloc] initWithTitle:@"Tracking"
                                                                   message:@"Existe una nueva versión disponible. ¿Desea actualizar en este momento?"
                                                                  delegate:self
                                                         cancelButtonTitle:@"Aceptar"
                                                         otherButtonTitles:@"Cancelar",nil];
                [messages setTag:1];
                [messages show];
            }
            else{
                [self EscribirArchivos];
            }
        }
    }
    
}

-(void)EscribirArchivos{
    NSString* fileName = [NSString stringWithFormat:@"%@/ConfigFile.txt", documentsDirectory];
    NSString* DataMobileUser = @"";
    if (checked == YES) {
        DataMobileUser = [DataMobileUser stringByAppendingString:txt_usuario.text];
        DataMobileUser = [DataMobileUser stringByAppendingString:@"|"];
        DataMobileUser = [DataMobileUser stringByAppendingString:txt_pass.text];
        [DataMobileUser writeToFile:fileName atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
        NSMutableArray* MAUsuariostem = [[NSMutableArray alloc]init];
        if (MAUsuarios ==nil || [MAUsuarios count] == 0) {
            MAUsuariostem = [[NSMutableArray alloc] initWithObjects:DataMobileUser, nil];
        }
        else{
            BOOL existe_usuario = false;
            NSString* string_ = [NSString stringWithFormat:@"%@|%@", txt_usuario.text, txt_pass.text];
            for (int i = 0; i<[MAUsuarios count]; i++) {
                NSArray *chunks2 = [[MAUsuarios objectAtIndex:i] componentsSeparatedByString: @"|"];
                if ([txt_usuario.text isEqualToString:[chunks2 objectAtIndex:0]]) {
                    [MAUsuariostem addObject:string_];
                    existe_usuario = true;
                }
                else{
                    [MAUsuariostem addObject:[MAUsuarios objectAtIndex:i]];
                }
            }
            if (!existe_usuario) {
                [MAUsuariostem addObject:string_];
            }
        }
        [MAUsuariostem writeToFile:fileName_Cookies atomically:YES];
    }
    else{
        [@"Error" writeToFile:fileName atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
    }
    GlobalUsu = txt_usuario.text;
    Globalpass = txt_pass.text;
    fileName = [NSString stringWithFormat:@"%@%@", GlobalUsu, @"_Mapas.txt"];
    fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    NSString *contentsMapas = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:nil error:nil];
    if (contentsMapas == nil || [contentsMapas isEqualToString:@""]) {
        mapas = @"Detalle";
    }
    else{
        mapas = contentsMapas;
    }
    
    fileName = [NSString stringWithFormat:@"%@%@", GlobalUsu, @"_Busqueda.txt"];
    fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    NSString *contentsBusqueda = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:nil error:nil];
    if (contentsBusqueda == nil || [contentsBusqueda isEqualToString:@""])
        busqueda = @"Ecónomico, Dirección";
    else
        busqueda = contentsBusqueda;
    
    fileName = [NSString stringWithFormat:@"%@%@", GlobalUsu, @"_tiempo_unidad_ociosa.txt"];
    fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    
    NSString *contentstiempo_unidad_ociosa = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:nil error:nil];
    if (contentstiempo_unidad_ociosa == nil || [contentstiempo_unidad_ociosa isEqualToString:@""]) {
        
        tiempo_unidad_ociosa = @"60";
        
    }
    else{
        tiempo_unidad_ociosa = contentstiempo_unidad_ociosa;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString* view_name = @"Unidades";
    if (![dispositivo isEqualToString:@""]) {
        view_name = [NSString stringWithFormat:@"%@_%@", view_name,dispositivo];
    }
    
    Unidades *view = [[Unidades alloc] initWithNibName:view_name bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:view animated:YES completion:nil];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
