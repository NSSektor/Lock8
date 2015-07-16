//
//  ComoFunciona.m
//  TACCSI
//
//  Created by Angel Rivas on 3/6/15.
//  Copyright (c) 2015 Tecnologizame. All rights reserved.
//

#import "ComoFunciona.h"



extern NSString* dispositivo;

@interface ComoFunciona ()

@end

@implementation ComoFunciona

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect_btn_menu  = CGRectMake( 0, 20, 30, 30);

   if ([dispositivo isEqualToString:@"iPad"]){
        rect_btn_menu  = CGRectMake(0, 20, 70, 70);
    }

    fondo_pantalla = [[UIImageView alloc] initWithFrame:CGRectMake(0, rect_btn_menu.size.height + 20, self.view.frame.size.width, self.view.frame.size.height- rect_btn_menu.size.height  - 20)];
    fondo_pantalla.image = [UIImage imageNamed:@"fondo_taccsitas_1536x2048"];
    [self.view addSubview:fondo_pantalla];
    
    
    lbl_navbar = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, rect_btn_menu.size.height)];
    lbl_navbar.text = @"Como funciona";
    lbl_navbar.textAlignment = NSTextAlignmentCenter;
    lbl_navbar.textColor = [UIColor blackColor];
    lbl_navbar.backgroundColor = [UIColor whiteColor];
    lbl_navbar.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
    [self.view addSubview:lbl_navbar];
    
    UIButton* btn_atras = [[UIButton alloc] initWithFrame:rect_btn_menu];
    [btn_atras addTarget:self action:@selector(Atras:) forControlEvents:UIControlEventTouchUpInside];
    [btn_atras setImage:[UIImage imageNamed:@"btn_atras"] forState:UIControlStateNormal];
    [self.view addSubview:btn_atras];
    
    _ghView = [[GHWalkThroughView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60)];
    [_ghView setDataSource:self];
    [_ghView setWalkThroughDirection:GHWalkThroughViewDirectionHorizontal];
    self.ghView.isfixedBackground =  NO;
    [self.view addSubview:_ghView];
    
    
    img_descripcion = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flotas"]];
    
    
    if ([dispositivo isEqualToString:@""]){
        img_descripcion.frame = CGRectMake(self.view.frame.size.width / 2 - 102, 70, 204, 364);
    }else if ([dispositivo isEqualToString:@"iPhone5"]){
        img_descripcion.frame = CGRectMake(self.view.frame.size.width / 2 - 128, 70, 256, 456);
    }else if ([dispositivo isEqualToString:@"iPhone6"]){
        img_descripcion.frame = CGRectMake(self.view.frame.size.width / 2 - 160, 70, 320, 568);
    }else if ([dispositivo isEqualToString:@"iPhone6plus"]){
        img_descripcion.frame = CGRectMake(self.view.frame.size.width / 2 - 160, 70, 320, 568);
    }else if ([dispositivo isEqualToString:@"iPad"]){
        img_descripcion.frame = CGRectMake(self.view.frame.size.width / 2 - 224, 100, 448, 796);
    }
    
    [self.view addSubview:img_descripcion];
    pg_control = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 30, self.view.frame.size.width, 20)];
    
    //Set defersCurrentPageDisplay to YES to prevent page control jerking when switching pages with page control. This prevents page control from instant change of page indication.
    
    pg_control.currentPageIndicatorTintColor = [UIColor whiteColor];
    pg_control.pageIndicatorTintColor = [UIColor grayColor];
    pg_control.numberOfPages = 6;
    [self.view addSubview:pg_control];
    

}

#pragma mark - GHDataSource

-(NSInteger) numberOfPages
{
    return 6;
}

- (void) configurePage:(GHWalkThroughPageCell *)cell atIndex:(NSInteger)index
{
    pg_control.currentPage = index;
    
    if (index == 0){
        img_descripcion.image = [UIImage imageNamed:@"flotas"];
        cell.title = [NSString stringWithFormat:@""];
       // cell.titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"Titulo %ld", index+1]];
        cell.desc = [NSString stringWithFormat:@""];
    }
    else if (index == 1){
        img_descripcion.image = [UIImage imageNamed:@"menu"];
        cell.title = [NSString stringWithFormat:@""];
        // cell.titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"Titulo %ld", index+1]];
        cell.desc = [NSString stringWithFormat:@""];
        
    }
    else if (index == 2){
        img_descripcion.image = [UIImage imageNamed:@"unidades"];
        cell.title = [NSString stringWithFormat:@""];
        // cell.titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"Titulo %ld", index+1]];
        cell.desc = [NSString stringWithFormat:@""];    }
    else if (index == 3){
        img_descripcion.image = [UIImage imageNamed:@"unidad"];
        cell.title = [NSString stringWithFormat:@""];
        // cell.titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"Titulo %ld", index+1]];
        cell.desc = [NSString stringWithFormat:@""];
    }
    else if (index == 4){
        img_descripcion.image = [UIImage imageNamed:@"street"];
        cell.title = [NSString stringWithFormat:@""];
        // cell.titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"Titulo %ld", index+1]];
        cell.desc = [NSString stringWithFormat:@""];
    }
    else if (index == 5){
        img_descripcion.image = [UIImage imageNamed:@"revision-1"];
        cell.title = [NSString stringWithFormat:@""];
        // cell.titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"Titulo %ld", index+1]];
        cell.desc = [NSString stringWithFormat:@""];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Atras:(id)sender{
     [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSUInteger)supportedInterfaceOrientations {
    
    NSUInteger retorno;
    //  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    retorno = UIInterfaceOrientationMaskPortrait;
    // else
    //   retorno = UIInterfaceOrientationMaskLandscape;
    return retorno;
}

- (UIImage*) bgImageforPage:(NSInteger)index
{
    NSString* imageName =[NSString stringWithFormat:@"bg_0%d.jpg", index+1];
    UIImage* image = [UIImage imageNamed:imageName];
    return image;
}


@end
