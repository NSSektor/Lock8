//
//  Login.h
//  Lock8
//
//  Created by Angel Rivas on 4/14/15.
//  Copyright (c) 2015 Tecnologizame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface Login : UIViewController<UITextFieldDelegate>{
    UITextField* txt_usuario;
    UITextField* txt_pass;
    UIButton*     check_button;
    UIButton*     btn_login;
    UIButton*     btn_olvide;
    UIImageView* img_presentation;
    UIView* contenedor_txt;
    UIView* contenedor_general;
}

-(IBAction)actualizarimagen:(id)sender;
-(IBAction)check:(id)sender;
-(IBAction)Login:(id)sender;
-(void)Ajustar;
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;
-(void)ActualConnection:(Reachability*)reachability;


@end
