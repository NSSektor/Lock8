//
//  Login.h
//  Lock8
//
//  Created by Angel Rivas on 4/14/15.
//  Copyright (c) 2015 Tecnologizame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "SYSoapTool.h"

@interface Login : UIViewController<UITextFieldDelegate,SOAPToolDelegate, NSXMLParserDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>{
    UITextField* txt_usuario;
    UITextField* txt_pass;
    UIButton*     check_button;
    UIButton*     btn_login;
    UIButton*     btn_olvide;
    UIImageView* img_presentation;
    UIView* contenedor_txt;
    UIView* contenedor_general;
    UIView* contenedor_animacion;
    UITableView* autocompleteTableView;
    
    ////xml///
    NSString* currentElement;
    NSMutableDictionary* currentElementData;
    NSMutableString* currentElementString;
    NSString *StringCode;
    NSString *StringMsg;
    
    Reachability* internetReachable;
    Reachability* hostReachable;
    
}

-(IBAction)actualizarimagen:(id)sender;
-(IBAction)check:(id)sender;
-(IBAction)Login:(id)sender;
-(void) checkNetworkStatus:(NSNotification *)notice;
-(NSString*)ReadFileRecordar;
-(void)EscribirArchivos;
-(void)FillArray;

@end
