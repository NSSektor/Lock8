//
//  Login.m
//  Lock8
//
//  Created by Angel Rivas on 4/14/15.
//  Copyright (c) 2015 Tecnologizame. All rights reserved.
//

#import "Login.h"
#import <QuartzCore/QuartzCore.h>


extern NSString* dispositivo;

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
    CGRect rect_original;
    NSString *remoteHostName;
    BOOL reachable;
}

@end

@implementation Login

#pragma mark -
#pragma mark Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Add Observer
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    remoteHostName = @"www.apple.com";
    
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
    
    
    UIImageView* img_logo = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100, 60, self.view.frame.size.width - 100, (292 / (681 / (self.view.frame.size.width - 100))))];
    img_logo.image = [UIImage imageNamed:@"logo"];
    [contenedor_general addSubview:img_logo];
    
    contenedor_txt = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - (self.view.frame.size.height / 2.5) , self.view.frame.size.width, self.view.frame.size.height / 2.5)];
    contenedor_txt.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
    [contenedor_general addSubview:contenedor_txt];
    
    rect_original = contenedor_general.frame;
    
    txt_usuario = [[UITextField alloc] initWithFrame:CGRectMake(10, contenedor_txt.frame.size.height *  0.04, contenedor_txt.frame.size.width - 20, contenedor_txt.frame.size.height *  0.20)];
    txt_usuario.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.4];
    //txt_usuario.placeholder = [NSString stringWithFormat:@"%@", NSLocalizedString(@"USER", nil)];
    txt_usuario.placeholder = @"Usuario";
    txt_usuario.delegate = self;
    [contenedor_txt addSubview:txt_usuario];
    
    txt_pass = [[UITextField alloc] initWithFrame:CGRectMake(10, contenedor_txt.frame.size.height *  0.28, contenedor_txt.frame.size.width - 20, contenedor_txt.frame.size.height *  0.20)];
    txt_pass.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.4];
    txt_pass.placeholder = @"Contraseña";
    txt_pass.secureTextEntry = YES;
    txt_pass.delegate = self;
    [contenedor_txt addSubview:txt_pass];
    
    UILabel* recordar_ = [[UILabel alloc] initWithFrame:CGRectMake(contenedor_txt.frame.size.width - 10 - (contenedor_txt.frame.size.width * 0.55), contenedor_txt.frame.size.height *  0.52, contenedor_txt.frame.size.width * 0.55, contenedor_txt.frame.size.height *  0.10)];
    recordar_.text = @"Recordar contraseña";
    recordar_.textColor = [UIColor whiteColor];
    recordar_.textAlignment = NSTextAlignmentRight;
    [contenedor_txt addSubview:recordar_];
    
    check_button = [[UIButton alloc] initWithFrame:CGRectMake(contenedor_txt.frame.size.width - 10 - (contenedor_txt.frame.size.width * 0.55) - (contenedor_txt.frame.size.height *  0.10), contenedor_txt.frame.size.height *  0.52, contenedor_txt.frame.size.height *  0.10, contenedor_txt.frame.size.height *  0.10)];
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
    
    btn_olvide = [[UIButton alloc] initWithFrame:CGRectMake(10, contenedor_txt.frame.size.height *  0.90, contenedor_txt.frame.size.width - 20, contenedor_txt.frame.size.height *  0.10)];
    [btn_olvide setTitle:@"Olvide mi contraseña" forState:UIControlStateNormal];
    //btn_login.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    [btn_olvide addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [btn_olvide setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    btn_olvide.backgroundColor = [UIColor clearColor];
    [contenedor_txt addSubview:btn_olvide];
    
    
    img_1 = [NSString stringWithFormat:@"img_1_%@", dispositivo];
    img_2 = [NSString stringWithFormat:@"img_2_%@", dispositivo];
    img_3 = [NSString stringWithFormat:@"img_3_%@", dispositivo];
    img_4 = [NSString stringWithFormat:@"img_4_%@", dispositivo];
    img_5 = [NSString stringWithFormat:@"img_5_%@", dispositivo];
    
    if ([dispositivo isEqualToString:@""]) {
        img_1 = [img_1 stringByReplacingOccurrencesOfString:@"_" withString:@""];
        img_2 = [img_2 stringByReplacingOccurrencesOfString:@"_" withString:@""];
        img_3 = [img_3 stringByReplacingOccurrencesOfString:@"_" withString:@""];
        img_4 = [img_4 stringByReplacingOccurrencesOfString:@"_" withString:@""];
        img_5 = [img_5 stringByReplacingOccurrencesOfString:@"_" withString:@""];
    }
    
    img_presentation.image = [UIImage imageNamed:img_1];
    

    
    contadorTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(actualizarimagen:) userInfo:nil repeats:YES];
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
            connectionRequired = NO;
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
     //   NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
   //     statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    
}



-(void)Ajustar{
    
}

-(IBAction)Login:(id)sender{
    
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
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
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
    stayup = YES;
    [self setViewMoveUp:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    stayup = NO;
    [self setViewMoveUp:NO];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMoveUp:(BOOL)moveUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    
    
    CGRect rect = contenedor_general.frame;
    if (moveUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        
        if (rect.origin.y == self.view.frame.origin.y ) {
            rect.origin.y = rect.origin.y - height_keyboard + 10;
        }
        
    }
    else
    {
        if (stayup == NO) {
            rect.origin.y = rect_original.origin.y;
        }
    }
    contenedor_general.frame = rect;
    [UIView commitAnimations];
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
