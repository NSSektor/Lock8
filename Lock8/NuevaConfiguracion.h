//
//  NuevaConfiguracion.h
//  Tracking
//
//  Created by Angel Rivas on 4/3/15.
//  Copyright (c) 2015 tecnologizame. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NuevaConfiguracion : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    UILabel* lbl_bienvenido;
    UIButton* btn_atras;
    UITableView *tbl_configuracion;
    UIButton* btn_terminos;
    UIView* contenedor_opciones;
    UITableView* tbl_opciones;
    UILabel* lbl_opcion;
   UIView* contenedor_contrato;
   UIButton* btn_cerrar_contrato;
    UITextView* txt_contrato;
    __weak IBOutlet UITextView *txt_contrato_old;
    
}

-(void)Guardar;
-(void)DameArregloOpciones;
-(IBAction)ShowConfiguracion:(id)sender;
-(IBAction)Atras:(id)sender;
-(void)ActualizaConfiguracion;
-(IBAction)ShowContrato:(id)sender;

@end
