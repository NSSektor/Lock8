//
//  NuevaConfiguracion.m
//  Tracking
//
//  Created by Angel Rivas on 4/3/15.
//  Copyright (c) 2015 tecnologizame. All rights reserved.
//

#import "NuevaConfiguracion.h"
#import "ConfiguracionMenu.h"

extern NSString* GlobalUsu;
extern NSString* fileName;
extern NSString*limite_velocidad;
extern NSString* GlobalUsu;
extern NSString* Globalpass;
extern NSString* configuracion;
extern NSString* mapas;
extern NSString* busqueda;
extern NSString* tiempo_unidad_ociosa;
extern NSString* dispositivo;

@interface NuevaConfiguracion ()

@end

@implementation NuevaConfiguracion{
    NSArray               *array_configuracion2;
    NSArray               *array_configuracionvelocidad;
    NSMutableArray *array_configuracion;
    NSMutableArray *array_configuracion_img;
    BOOL Show_Opciones;
    NSString* tiempo_configuracion;
    NSString* tiempo_configuracion_old;
    NSInteger index_sel;
    NSInteger index_velocidad;
    NSString* velocidad_maxima;
    NSString* opcion;
    NSMutableArray* opciones;
    BOOL Show_Contrato;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    array_configuracion2 = [[NSArray alloc]initWithObjects:@"5", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55", @"60", nil ];
    
    array_configuracionvelocidad = [[NSArray alloc]initWithObjects:@"20", @"30", @"40", @"50", @"60", @"70", @"80", @"90", @"100", @"110", @"120", @"130", @"140", @"150", @"160", @"170", @"180", nil ];
    
    Show_Opciones = NO;
    Show_Contrato = NO;
    
    [self ActualizaConfiguracion];

    CGRect rect_btn_menu          = CGRectMake(10, 25, 30, 30);
    CGRect rect_lbl_bienvenido   = CGRectMake(0, 20, self.view.frame.size.width, 40);
    CGRect rect_img_bienvenido = CGRectMake(self.view.frame.size.width / 2- 87 , 60, 174, 165);
    CGFloat height_table = 200;
    CGFloat height_label = 25;
    
    
    if ([dispositivo isEqualToString:@"iPhone5"])
        rect_img_bienvenido = CGRectMake(self.view.frame.size.width / 2- 138 , 60, 266, 253);
    else if ([dispositivo isEqualToString:@"iPhone6"])
        rect_img_bienvenido = CGRectMake(self.view.frame.size.width / 2- 185 , 60, 370, 352);
    else if ([dispositivo isEqualToString:@"iPhone6plus"])
        rect_img_bienvenido = CGRectMake(self.view.frame.size.width / 2- 222 , 60, 444, 421);
    else if ([dispositivo isEqualToString:@"iPad"]){
        rect_img_bienvenido = CGRectMake(self.view.frame.size.width / 2- 210 , 60, 420, 399);
        height_table = 500;
        height_label = 30;
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    
    // Do any additional setup after loading the view from its nib.
    lbl_bienvenido = [[UILabel alloc] initWithFrame:rect_lbl_bienvenido];
    lbl_bienvenido.textAlignment = NSTextAlignmentCenter;
    lbl_bienvenido.textColor = [UIColor blackColor];
    lbl_bienvenido.text = @"Configuración";
    [self.view addSubview:lbl_bienvenido];
    
    btn_atras = [[UIButton alloc] initWithFrame:rect_btn_menu];
    [btn_atras addTarget:self action:@selector(Atras:) forControlEvents:UIControlEventTouchUpInside];
    [btn_atras setImage:[UIImage imageNamed:@"btn_atras"] forState:UIControlStateNormal];
    [self.view addSubview:btn_atras];
    
    UILabel* lbl_ = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 320, rect_img_bienvenido.size.height)];
    lbl_.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lbl_];
    
    UIImageView* img_ =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"config"]];
    img_.frame = rect_img_bienvenido;
    [self.view addSubview:img_];
    
    UILabel* lbl_tbl = [[UILabel alloc] initWithFrame:CGRectMake(5,  self.view.frame.size.height - height_label - height_table - height_label - 5, self.view.frame.size.width - 5, height_label)];
    lbl_tbl.text = @"Opciones";
    [self.view addSubview:lbl_tbl];
    
    tbl_configuracion = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - height_table - height_label - 5, self.view.frame.size.width,height_table) style:UITableViewStylePlain];
    tbl_configuracion.backgroundColor = [UIColor groupTableViewBackgroundColor];
    tbl_configuracion.separatorColor = [UIColor groupTableViewBackgroundColor];
    tbl_configuracion.dataSource = self;
    tbl_configuracion.delegate = self;
    tbl_configuracion.scrollEnabled = NO;
    [self.view addSubview:tbl_configuracion];
    
    btn_terminos = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - height_label, self.view.frame.size.width, height_label)];
    [btn_terminos setTitle:@"Ver Términos y condiciones" forState:UIControlStateNormal];
    btn_terminos.backgroundColor = [UIColor whiteColor];
    [btn_terminos.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [btn_terminos setTitleColor: [UIColor colorWithRed:245.0/255.0 green:123.0/255.0 blue:32.0/255.0 alpha:1.0] forState:UIControlStateNormal ];
    btn_terminos.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    [btn_terminos addTarget:self action:@selector(ShowContrato:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_terminos];
    
    contenedor_opciones = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 60, self.view.frame.size.width, self.view.frame.size.height - 60)];
    contenedor_opciones.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contenedor_opciones];
    
    lbl_opcion = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    lbl_opcion.text = @"Opciones";
    lbl_opcion.textAlignment = NSTextAlignmentCenter;
    [contenedor_opciones addSubview:lbl_opcion];
    
    opciones = [[NSMutableArray alloc] init];
    
    tbl_opciones = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, contenedor_opciones.frame.size.width, contenedor_opciones.frame.size.height - 20) style:UITableViewStylePlain];
    tbl_opciones.backgroundColor = [UIColor whiteColor];
    tbl_opciones.separatorColor = [UIColor whiteColor];
    tbl_opciones.dataSource = self;
    tbl_opciones.delegate = self;
    tbl_opciones.scrollEnabled = NO;
    [contenedor_opciones addSubview:tbl_opciones];
    
    contenedor_contrato = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contenedor_contrato.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contenedor_contrato];
    
    // Do any additional setup after loading the view from its nib.
    UILabel* lbl_terminos = [[UILabel alloc] initWithFrame:rect_lbl_bienvenido];
    lbl_terminos.textAlignment = NSTextAlignmentCenter;
    lbl_terminos.textColor = [UIColor blackColor];
    lbl_terminos.text = @"Términos y condiciones";
    [contenedor_contrato addSubview:lbl_terminos];
    
    btn_cerrar_contrato = [[UIButton alloc] initWithFrame:rect_btn_menu];
    [btn_cerrar_contrato addTarget:self action:@selector(ShowContrato:) forControlEvents:UIControlEventTouchUpInside];
    [btn_cerrar_contrato setImage:[UIImage imageNamed:@"btn_regresa"] forState:UIControlStateNormal];
    [contenedor_contrato addSubview:btn_cerrar_contrato];
    
    txt_contrato = [[UITextView alloc] initWithFrame:CGRectMake(0, 60, contenedor_contrato.frame.size.width, contenedor_contrato.frame.size.height - 60)];
    txt_contrato.text = txt_contrato_old.text;
    [contenedor_contrato addSubview:txt_contrato];

    
}

-(void)ActualizaConfiguracion{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    NSString* fileName = [NSString stringWithFormat:@"%@%@", GlobalUsu, @"_Tiempo.txt"];
    fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    NSString *contents = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:nil error:nil];
    if (contents == nil || [contents isEqualToString:@""]) {
        
        tiempo_configuracion = @"300";
    }
    else{
        NSArray* arraytiempo = [contents componentsSeparatedByString:@","];
        tiempo_configuracion = [arraytiempo objectAtIndex:1];
    }
    
    tiempo_configuracion_old = tiempo_configuracion;
    
    for (int i =0; i <[array_configuracion2 count]; i++) {
        
        int j = 0;
        j = [[array_configuracion2 objectAtIndex:i] intValue];
        j = j * 60;
        
        
        
        tiempo_configuracion = [NSString stringWithFormat: @"%d", (int)j];
        
        if ([tiempo_configuracion_old isEqualToString:tiempo_configuracion]) {
            j = j / 60;
            tiempo_configuracion = [NSString stringWithFormat: @"%d", (int)j];
            tiempo_configuracion = [tiempo_configuracion stringByAppendingString:@" min."];
            tiempo_configuracion = [@"Frecuencia de actualización - " stringByAppendingString:tiempo_configuracion];
            index_sel = i;
            break;
            
            
        }
        
    }
    
    //velocidad
    
    fileName = [NSString stringWithFormat:@"%@%@", GlobalUsu, @"_Velocidad.txt"];
    fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    contents = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:nil error:nil];
    if (contents == nil || [contents isEqualToString:@""]) {
        
        velocidad_maxima = @"Límite de velocidad - 90 km";
        index_velocidad = 7;
        limite_velocidad = @"90";
    }
    else{
        
        for (int i=0; i<[array_configuracionvelocidad count]; i++) {
            
            if ([contents isEqualToString:[array_configuracionvelocidad objectAtIndex:i]]) {
                index_velocidad = i;
                limite_velocidad = contents;
            }
            
        }
        velocidad_maxima = @"Límite de velocidad  - ";
        velocidad_maxima = [velocidad_maxima stringByAppendingString:contents];
        velocidad_maxima = [velocidad_maxima stringByAppendingString:@" km."];
    }
    
    if ([mapas isEqualToString:@"Detalle"]) {
        //    array_configuracion_img = nsmu
        array_configuracion_img = [[NSMutableArray alloc]initWithObjects:@"reloj", nil];
        array_configuracion = [[NSMutableArray alloc]initWithObjects: tiempo_configuracion,nil];
    }
 /*   else{
        array_configuracion_img = [[NSMutableArray alloc]initWithObjects:@"iosmaps.png", @"reloj.pnj", @"speed.png", @"searching.png", @"clock.png",nil];
        array_configuracion = [[NSMutableArray alloc]initWithObjects:@"Mapas - Apple Maps", tiempo_configuracion,  velocidad_maxima,[[NSString stringWithFormat:@"Búsqueda -%@", busqueda] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]], [NSString stringWithFormat:@"Unidad sin reportar-%d%@",[tiempo_unidad_ociosa intValue] / 60, @"hrs"],nil];
    }*/
}

-(IBAction)Atras:(id)sender{
    if (Show_Opciones){
        [self ShowConfiguracion:self];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(IBAction)ShowContrato:(id)sender{
    CGRect frame_tbl = contenedor_contrato.frame;
    if (Show_Contrato==NO) {
        Show_Contrato = YES;
        frame_tbl.origin.x = 0;
    }
    else{
        Show_Contrato = NO;
        frame_tbl.origin.x = self.view.frame.size.width;
    }
    
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:0.2];
    contenedor_contrato.frame = frame_tbl;
    [UIView commitAnimations];
}

-(IBAction)ShowConfiguracion:(id)sender{
    
    CGRect frame_tbl = contenedor_opciones.frame;
    if (Show_Opciones==NO) {
        Show_Opciones = YES;
        frame_tbl.origin.x = 0;
    }
    else{
        Show_Opciones = NO;
        frame_tbl.origin.x = self.view.frame.size.width;
    }
    
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:0.2];
    contenedor_opciones.frame = frame_tbl;
    [UIView commitAnimations];
    
}

-(void)DameArregloOpciones{
    if ([opcion isEqualToString:@"tiempo"]) {
        opciones = [[NSMutableArray alloc]initWithObjects:@"5 minutos", @"10 minutos", @"15 minutos", @"20 minutos", @"25 minutos", @"30 minutos", @"35 minutos", @"40 minutos", @"45 minutos", @"50 minutos", @"55 minutos", @"60 minutos", nil ];
        lbl_opcion.text = @"Frecuencia de Actualización de Datos";
    }
    else if([opcion isEqualToString:@"velocidad"]){
        opciones = [[NSMutableArray alloc]initWithObjects:@"20 km", @"30 km", @"40 km", @"50 km", @"60 km", @"70 km", @"80 km", @"90 km", @"100 km", @"110 km", @"120 km", @"130 km", @"140 km", @"150 km", @"160 km", @"170 km", @"180 km", nil];
        lbl_opcion.text = @"Límite de velocidad ";
    }
    else if ([opcion isEqualToString:@"busqueda"]){
        opciones = [[NSMutableArray alloc]initWithObjects:@"Ecónomico, Dirección", @"Ecónomico", @"Dirección", nil];
        lbl_opcion.text = @"Opciones de búsqueda";
    }
    else if ([opcion isEqualToString:@"ociosa"]){
        opciones = [[NSMutableArray alloc]initWithObjects:@"1 hora", @"2 horas", @"3 horas", @"4 horas", nil];
        lbl_opcion.text = @"Tiempo para considerar unidad sin reportar ";
    }
    else{
        opciones = [[NSMutableArray alloc]initWithObjects:@"Apple Maps", @"Google Maps", nil ];
        lbl_opcion.text = @"Tipo de mapas";
        if ([mapas isEqualToString:@"Detalle"]) {
            index_sel = 0;
        }
        else{
            index_sel = 1;
        }
    }
}

-(void)Guardar{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    if ([opcion isEqualToString:@"tiempo"]) {
        tiempo_configuracion = @"300";
        NSArray* tiempo = [[NSArray alloc]initWithObjects:@"300",@"600", @"900", @"1200", @"1500", @"1800",@"2100", @"2400",@"2700", @"3000", @"3300", @"3600", nil];
        for (int x=0; x<[tiempo count]; x++) {
            if (index_sel ==x) {
                tiempo_configuracion = [tiempo objectAtIndex:x];
                break;
            }
        }
        NSString* fileName = [NSString stringWithFormat:@"%@%@", GlobalUsu, @"_Tiempo.txt"];
        fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
        NSString *contents = [[NSString alloc] initWithContentsOfFile:fileName usedEncoding:nil error:nil];
        if (contents != nil || ![contents isEqualToString:@""]) {
            NSArray* arraytiempo = [contents componentsSeparatedByString:@","];
            NSString* resultString = [arraytiempo objectAtIndex:0];
            resultString = [resultString stringByAppendingString:@","];
            resultString = [resultString stringByAppendingString:tiempo_configuracion];
            [resultString writeToFile:fileName atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
        }
    }
    else if([opcion isEqualToString:@"velocidad"]){
        
        NSString* resultString = [opciones objectAtIndex:index_sel];
        limite_velocidad = resultString;
        resultString = [resultString stringByReplacingOccurrencesOfString:@" km" withString:@""];
        NSString* fileName = [NSString stringWithFormat:@"%@%@", GlobalUsu, @"_Velocidad.txt"];
        fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
        [resultString writeToFile:fileName atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
        
        
    }
    else if ([opcion isEqualToString:@"busqueda"]){
        NSString* fileName = [NSString stringWithFormat:@"%@%@", GlobalUsu, @"_Busqueda.txt"];
        fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
        
        if (index_sel==0) {
            busqueda = @"Ecónomico, Dirección";
        }
        else if (index_sel==1){
            busqueda = @"Ecónomico";
        }
        else{
            busqueda = @"Dirección";
        }
        [busqueda writeToFile:fileName atomically:NO encoding:NSStringEncodingConversionExternalRepresentation error:nil];
    }
    else if ([opcion isEqualToString:@"ociosa"]){
        NSString* fileName = [NSString stringWithFormat:@"%@%@", GlobalUsu, @"_tiempo_unidad_ociosa.txt"];
        fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
        
        if (index_sel==0) {
            tiempo_unidad_ociosa = @"60";
        }
        else if (index_sel==1){
            tiempo_unidad_ociosa = @"120";
        }
        else if (index_sel==2){
            tiempo_unidad_ociosa = @"180";
        }
        
        else{
            tiempo_unidad_ociosa = @"240";
        }
        [tiempo_unidad_ociosa writeToFile:fileName atomically:NO encoding:NSStringEncodingConversionExternalRepresentation error:nil];
    }
    else{
        NSString* fileName = [NSString stringWithFormat:@"%@%@", GlobalUsu, @"_Mapas.txt"];
        fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
        
        if (index_sel==0) {
            mapas = @"Detalle";
            
        }
        else{
            mapas = @"Detalle_iOS";
        }
        [mapas writeToFile:fileName atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat retorno = 40;
    if ([dispositivo isEqualToString:@"iPad"]) {
        retorno = 80;
    }
    if (tableView == tbl_opciones) {
        retorno = 33;
    }
    return retorno;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger retorno = 0;
    if (tableView==tbl_configuracion)
        retorno = [array_configuracion count];
    else if (tableView==tbl_opciones)
        retorno = [opciones count];
    return retorno;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  = nil;
    if (tableView==tbl_opciones) {
        cell  = [tableView dequeueReusableCellWithIdentifier:@"celda"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celda"];
        }
        
        cell.textLabel.text = [opciones objectAtIndex:indexPath.row];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        if (index_sel==indexPath.row) {
            cell.accessoryType =  UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType =  UITableViewCellAccessoryNone;
        }
        
        UIView* separatorLineView;
        
        if ([dispositivo isEqualToString:@"iPad"])
           separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(10, 78, self.view.frame.size.width - 10, 1)];
        else
            separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(10, 31, self.view.frame.size.width - 10, 1)];
        
        separatorLineView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]; // set color as you want.
        [cell.contentView addSubview:separatorLineView];
        
    }else if (tableView==tbl_configuracion){
        static NSString *simpleTableIdentifier = @"ConfiguracionMenu";
        ConfiguracionMenu *cell_;
        
        cell_ = (ConfiguracionMenu *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell_ == nil)
        {
            NSString* NibName = @"Configuracion_Menu";
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NibName owner:self options:nil];
                cell_ = [nib objectAtIndex:1];
            }
            else{
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NibName owner:self options:nil];
                cell_ = [nib objectAtIndex:0];
                if ([dispositivo isEqualToString:@"iPhone6"])
                    cell_ = [nib objectAtIndex:2];
                if ([dispositivo isEqualToString:@"iPhone6plus"])
                    cell_ = [nib objectAtIndex:3];
            }
        }
        cell_.img_menu.image = [UIImage imageNamed:[array_configuracion_img objectAtIndex:indexPath.row]];
        NSArray* array_ = [[array_configuracion objectAtIndex:indexPath.row] componentsSeparatedByString:@"-"];
        cell_.lbl_menu.text = [array_ objectAtIndex:0];
        cell_.lbl_opcion.text = [array_ objectAtIndex:1];
        cell_.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = cell_;
    }
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == tbl_configuracion) {
        if (indexPath.row == 0)
            opcion = @"tiempo";
        if (indexPath.row == 1)
            opcion = @"tiempo";
        if (indexPath.row == 2){
            opcion = @"velocidad";
            index_sel = index_velocidad;
        }
        if (indexPath.row == 3){
            opcion = @"busqueda";
            if ([busqueda isEqualToString:@"Ecónomico, Dirección"])
                index_sel = 0;
            else if ([busqueda isEqualToString:@"Ecónomico"])
                index_sel = 1;
            else if ([busqueda isEqualToString:@"Dirección"])
                index_sel = 2;
        }
        if (indexPath.row == 4) {
            opcion = @"ociosa";
            if ([tiempo_unidad_ociosa isEqualToString:@"60"])
                index_sel = 0;
            else if ([tiempo_unidad_ociosa isEqualToString:@"120"])
                index_sel = 1;
            else if ([tiempo_unidad_ociosa isEqualToString:@"180"])
                index_sel = 2;
            else if ([tiempo_unidad_ociosa isEqualToString:@"240"])
                index_sel = 0;
        }
        [self DameArregloOpciones];
        [tbl_opciones reloadData];
        [self ShowConfiguracion:self];
    }
    else{
        index_sel = indexPath.row;
        [tbl_opciones reloadData];
        [self Guardar];
        [self ActualizaConfiguracion];
        [tbl_configuracion reloadData];
        [self ShowConfiguracion:self];
    }
    return indexPath;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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
