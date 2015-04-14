//
//  Login.m
//  Lock8
//
//  Created by Angel Rivas on 4/14/15.
//  Copyright (c) 2015 Tecnologizame. All rights reserved.
//

#import "Login.h"

extern NSString* dispositivo;

@interface Login (){
    BOOL checked;
}

@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView* img_logo = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100, 60, self.view.frame.size.width - 100, (292 / (681 / (self.view.frame.size.width - 100))))];
    img_logo.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:img_logo];
    
    UIView* contenedor_txt = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 3 * 2 , self.view.frame.size.width, self.view.frame.size.height / 3)];
    contenedor_txt.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5];
    [self.view addSubview:contenedor_txt];
  /*  if ([dispositivo isEqualToString:@"iPhone5"]) {
        
    }
    else if ([dispositivo isEqualToString:@"iPhone6"]){
        frame_logo = CGRectMake(20, 60, 300, 128);
    }else if ([dispositivo isEqualToString:@"iPhone6plus"]){
        
    }else if ([dispositivo isEqualToString:@"iPad"]){
        
    }*/

    
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

@end
