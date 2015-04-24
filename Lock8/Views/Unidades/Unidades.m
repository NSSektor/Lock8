//
//  Unidades.m
//  Lock8
//
//  Created by Angel Rivas on 4/17/15.
//  Copyright (c) 2015 Tecnologizame. All rights reserved.
//

#import "Unidades.h"
#import "TableCellResumen.h"
#import "Login.h"
#import <QuartzCore/QuartzCore.h>

extern NSString* dispositivo;
extern NSString* GlobalString;
extern NSString* GlobalUsu;
extern NSString*Globalpass;
extern NSString* url_web_service;

extern NSMutableArray*  MArrayFlota;
extern NSMutableArray*  MArrayEco;
extern NSMutableArray*  MArrayID;
extern NSMutableArray*  MArrayIP;
extern NSMutableArray*  MArrayLatitud;
extern NSMutableArray*  MArrayLongitud;
extern NSMutableArray*  MArrayAngulo;
extern NSMutableArray*  MArrayVelocidad;
extern NSMutableArray*  MArrayFecha;
extern NSMutableArray*  MArrayEvento;
extern NSMutableArray*  MArrayEstatus;
extern NSMutableArray*  MArrayIcono;
extern NSMutableArray*  MArrayUbicacion;
extern NSMutableArray*  MArrayMotor;
extern NSMutableArray*  MArrayTelefono;
extern NSMutableArray*  MArrayMensajes;
extern NSMutableArray*  MArrayIcono_Mapa;
extern NSString* mapas;
extern NSString* busqueda;
extern NSString* tiempo_unidad_ociosa;
extern NSString* limite_velocidad;
extern NSString* vista_activa;
extern CGRect rect_original_login;
extern CGRect rect_original_unidades;
extern UIView* sub_contenedor_incidencia;

@interface Unidades (){
    BOOL ShowMenu;
    CGFloat width_;
    CGFloat size_celda_menu;
    float font_size;
    NSArray* array_menu;
    NSArray* array_menu_imagenes;
    NSMutableArray* ArrayNombreFlotas;
    NSMutableArray * ArregloFLotas;
    NSMutableArray* ArrayNombreFlotasSearch;
    NSMutableArray * ArregloFLotasSearch;
    BOOL Show_Table_Unidades;
    NSString* texto_busqueda;
    NSString* texto_busqueda_unidad;
    NSString* NombreFlotaUnidades;
    NSMutableArray* ArrayUnidades;
    NSMutableArray* ArrayUnidadestem;
    GMSMarker* marker_unidad;
    CLLocationCoordinate2D position_unidad;
    NSMutableArray* datos_unidad;
    BOOL Show_Mapa;
    SYSoapTool *soapTool;
    NSString* metodo_;
    BOOL cancelar_actualizacion;
    NSString* IP_unidad;
    BOOL Show_Street;
    NSMutableArray* descripcion_incidencias;
    BOOL tengo_incidencias;
    UIAlertView *setIncidencia;
    UITextField *txt_incidencia;
    UIPickerView* pk_incidencia;
    BOOL Show_Incidencias;
    NSString* incidencia;
    NSString* remoteHostName;
    CGFloat height_keyboard;
    BOOL reachable;
    BOOL stayup;
    NSString* detalle_unidad;
}

@end

@implementation Unidades


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
  /*  // Add Observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowUnidades:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideUnidades:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChangedUnidades:) name:kReachabilityChangedNotification object:nil];*/
    
    
    remoteHostName = @"www.apple.com";
    
    vista_activa = @"Unidades";
    
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
    
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachability startNotifier];
    [self updateInterfaceWithReachability:self.wifiReachability];
    
    ShowMenu = NO;
    Show_Table_Unidades = NO;
    cancelar_actualizacion = NO;
    Show_Street = NO;
    Show_Mapa = NO;
    Show_Incidencias = NO;
    texto_busqueda = @"";
    texto_busqueda_unidad = @"";
    soapTool = [[SYSoapTool alloc]init];
    soapTool.delegate = self;
    tengo_incidencias = NO;
    
    width_ = 270;
    font_size = 25.0f;
    contenedor_vista = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contenedor_vista.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contenedor_vista];
    
    contenedor_menu = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width - 50, self.view.frame.size.height)];
    contenedor_menu.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contenedor_menu];
    CGRect rect_btn_menu  = CGRectMake( 0, 15, 30, 30);
    

   if ([dispositivo isEqualToString:@"iPhone5"]) {
        size_celda_menu = 40;
       // rect_tbl_menu                = CGRectMake(0, 160, 270, 245);
    }
    else if ([dispositivo isEqualToString:@"iPhone6"]){
        size_celda_menu = 44;
        width_ = 325;
        font_size = 28.0f;
        rect_btn_menu  = CGRectMake(0, 20, 30, 30);
    }else if ([dispositivo isEqualToString:@"iPhone6plus"]){
        size_celda_menu = 44;
        width_ = 364;
        font_size = 28.0f;
        rect_btn_menu  = CGRectMake(0, 20, 30, 30);
    }else if ([dispositivo isEqualToString:@"iPad"]){
        size_celda_menu = 51;
        width_ = 716;
        font_size = 30.0f;
        rect_btn_menu  = CGRectMake(0, 10, 70, 70);
    //    rect_botones  = CGRectMake( 0, self.view.frame.size.height - 70, self.view.frame.size.width, 70);
    }
    
    contenedor_vista = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contenedor_vista.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contenedor_vista];
    
    contenedor_menu = [[UIView alloc] initWithFrame:CGRectMake(0 - width_, 0, width_, self.view.frame.size.height)];
    contenedor_menu.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contenedor_menu];
    
    btn_menu = [[UIButton alloc] initWithFrame:rect_btn_menu];
    [btn_menu addTarget:self action:@selector(ShowMenu:) forControlEvents:UIControlEventTouchUpInside];
    [btn_menu setImage:[UIImage imageNamed:@"btn_menu"] forState:UIControlStateNormal];
    [contenedor_vista addSubview:btn_menu];
    
    
    
    btn_atras = [[UIButton alloc] initWithFrame:rect_btn_menu];
    [btn_atras addTarget:self action:@selector(Atras:) forControlEvents:UIControlEventTouchUpInside];
    [btn_atras setImage:[UIImage imageNamed:@"btn_atras"] forState:UIControlStateNormal];
    [contenedor_vista addSubview:btn_atras];
    btn_atras.hidden = YES;
    
    img_titulo = [[UIImageView alloc] initWithFrame:CGRectMake(contenedor_vista.frame.size.width / 2 - (681 / (292 / btn_menu.frame.size.width)/2), 20, 681 / (292 / btn_menu.frame.size.width), btn_menu.frame.size.height)];
    img_titulo.image = [UIImage imageNamed:@"logo"];
    [contenedor_vista addSubview:img_titulo];
    
    lbl_nombre_unidad = [[UILabel alloc] initWithFrame:CGRectMake(btn_atras.frame.size.width + btn_atras.frame.origin.x + 10, btn_atras.frame.origin.y, contenedor_vista.frame.size.width - ((btn_atras.frame.size.width + btn_atras.frame.origin.x + 10)* 2), btn_atras.frame.size.height)];
    lbl_nombre_unidad.textColor = [UIColor blackColor];
    lbl_nombre_unidad.textAlignment = NSTextAlignmentCenter;
    lbl_nombre_unidad.hidden = YES;
    
    UILabel* lbl_titulo = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, contenedor_menu.frame.size.width, btn_menu.frame.size.height)];
    lbl_titulo.text = @" Opciones";
    lbl_titulo.textAlignment = NSTextAlignmentLeft;
    [lbl_titulo setFont:[UIFont fontWithName:@"Helvetica" size:font_size]];
    lbl_titulo.textColor = [UIColor colorWithRed:133.0/255.0 green:22.0/255.0 blue:24.0/255.0 alpha:1];
    [contenedor_menu addSubview:lbl_titulo];
    
    
    array_menu = [[NSArray alloc]initWithObjects:@"Mis Unidades", @"Configuración", @"Ayuda", @"Cerrar sesión", nil];
    
    array_menu_imagenes = [[NSArray alloc]initWithObjects:@"mis_unidades", @"configuracion", @"ayuda", @"cerrar_sesion", nil];
    
    
    
    
    tbl_menu = [[UITableView alloc] initWithFrame:CGRectMake(0, 20 + lbl_titulo.frame.size.height, contenedor_menu.frame.size.width, contenedor_menu.frame.size.height - 20 - lbl_titulo.frame.size.height) style:UITableViewStylePlain];
    tbl_menu.backgroundColor = [UIColor whiteColor];
    tbl_menu.separatorColor = [UIColor clearColor];
    [contenedor_menu addSubview:tbl_menu];
    tbl_menu.delegate = self;
    tbl_menu.dataSource = self;
    
    
    ArrayNombreFlotas = [[NSMutableArray alloc] init];
    ArregloFLotas = [[NSMutableArray alloc] init];
    ArrayNombreFlotasSearch = [[NSMutableArray alloc] init];
    ArregloFLotasSearch = [[NSMutableArray alloc] init];
    
    searchBar_flotas = [[UISearchBar alloc] initWithFrame:CGRectMake(0, btn_menu.frame.size.height + 20, self.view.frame.size.width, 40)];
    searchBar_flotas.tintColor = [UIColor colorWithRed:133.0/255.0 green:22.0/255.0 blue:24.0/255.0 alpha:1];
    searchBar_flotas.delegate = self;
    [contenedor_vista addSubview:searchBar_flotas];
    
    tbl_flotas = [[UITableView alloc] initWithFrame:CGRectMake(0, btn_menu.frame.size.height + 20 + 40, self.view.frame.size.width, self.view.frame.size.height - btn_menu.frame.size.height - 20) style:UITableViewStylePlain];
    tbl_flotas.backgroundColor = [UIColor whiteColor];
    tbl_flotas.separatorColor = [UIColor whiteColor];
    tbl_flotas.dataSource = self;
    tbl_flotas.delegate = self;
    [contenedor_vista addSubview:tbl_flotas];
    
    contenedor_tbl_unidades = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, btn_menu.frame.size.height + 20, self.view.frame.size.width, self.view.frame.size.height - btn_menu.frame.size.height - 20)];
    contenedor_tbl_unidades.backgroundColor = [UIColor whiteColor];
    [contenedor_vista addSubview:contenedor_tbl_unidades];
    
    searchBar_Unidades = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    searchBar_Unidades.tintColor = [UIColor colorWithRed:133.0/255.0 green:22.0/255.0 blue:24.0/255.0 alpha:1];
    searchBar_Unidades.delegate = self;
    [contenedor_tbl_unidades addSubview:searchBar_Unidades];
    
    tbl_unidades = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, contenedor_tbl_unidades.frame.size.width, contenedor_tbl_unidades.frame.size.height - 40) style:UITableViewStylePlain];
    tbl_unidades.backgroundColor = [UIColor whiteColor];
    tbl_unidades.separatorColor = [UIColor whiteColor];
    tbl_unidades.dataSource = self;
    tbl_unidades.delegate = self;
    [contenedor_tbl_unidades addSubview:tbl_unidades];
    
    
    contenedor_mapa = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contenedor_tbl_unidades.frame.size.width, contenedor_tbl_unidades.frame.size.height)];
    [contenedor_tbl_unidades addSubview:contenedor_mapa];
    contenedor_mapa.hidden = YES;
    
    position_unidad = CLLocationCoordinate2DMake([@"99.99" doubleValue], [@"-99.99" doubleValue]);
    
    mapView_ = [[GMSMapView alloc] initWithFrame:contenedor_mapa.frame];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:contenedor_mapa.frame camera:camera];
    mapView_.delegate = self;
    [contenedor_mapa addSubview:mapView_];
    
    CGRect rect_botones  = CGRectMake( 0, contenedor_mapa.frame.size.height - 50, contenedor_mapa.frame.size.width, 50);
    if ([dispositivo isEqualToString:@"iPad"]) {
        rect_botones  = CGRectMake( 0, contenedor_mapa.frame.size.height - 70, contenedor_mapa.frame.size.width, 70);
    }
    
    contenedor_botones = [[UIView alloc] initWithFrame:rect_botones];
    contenedor_botones.backgroundColor = [UIColor colorWithRed:133.0/255.0 green:22.0/255.0 blue:24.0/255.0 alpha:1.0];
    [contenedor_mapa addSubview:contenedor_botones];
    
    for (int i = 0; i <3; i++) {
        UIImageView* img_;
        UIButton* btn_;
        CGFloat orig_x =  ((contenedor_botones.frame.size.width / 3) /2) - ((600 / (300 / contenedor_botones.frame.size.height)) / 2);
        switch (i) {
            case 0:{
                img_ = [[UIImageView alloc] initWithFrame:CGRectMake((contenedor_botones.frame.size.width * 0.16666667) - (600 / (300 / contenedor_botones.frame.size.height)/2), 0, 600 / (300 / contenedor_botones.frame.size.height), contenedor_botones.frame.size.height)];
                img_.image = [UIImage imageNamed:@"actualizar"];
                btn_ = [[UIButton alloc] initWithFrame:img_.frame];
                [btn_ addTarget:self action:@selector(ActualizarPosicion:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 1:{
                img_ = [[UIImageView alloc] initWithFrame:CGRectMake((contenedor_botones.frame.size.width * 0.5) - (600 / (300 / contenedor_botones.frame.size.height)/2), 0, 600 / (300 / contenedor_botones.frame.size.height), contenedor_botones.frame.size.height)];
                orig_x = orig_x + img_.frame.size.width + img_.frame.origin.x;
                img_.image = [UIImage imageNamed:@"revision"];
                btn_ = [[UIButton alloc] initWithFrame:img_.frame];
                [btn_ addTarget:self action:@selector(SolicitarRevision:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 2:{
               img_ = [[UIImageView alloc] initWithFrame:CGRectMake((contenedor_botones.frame.size.width * 0.83333333) - (600 / (300 / contenedor_botones.frame.size.height)/2), 0, 600 / (300 / contenedor_botones.frame.size.height), contenedor_botones.frame.size.height)];
                orig_x = orig_x + img_.frame.size.width + img_.frame.origin.x;
                img_.image = [UIImage imageNamed:@"compartir"];
                btn_ = [[UIButton alloc] initWithFrame:img_.frame];
                [btn_ addTarget:self action:@selector(Compartir:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
                
            default:
                break;
        }
        [contenedor_botones addSubview:img_];
        [contenedor_botones addSubview:btn_];
    }
    
    
    
    
    
    NSString* NibName = @"TableCellResumen";
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NibName owner:self options:nil];
    contenedor_descripcion_unidad = [nib objectAtIndex:8];
    if ([dispositivo isEqualToString:@"iPhone6"])
        contenedor_descripcion_unidad = [nib objectAtIndex:9];
    else if ([dispositivo isEqualToString:@"iPhone6plus"])
        contenedor_descripcion_unidad = [nib objectAtIndex:10];
    else if ([dispositivo isEqualToString:@"iPad"])
        contenedor_descripcion_unidad = [nib objectAtIndex:11];
    
    contenedor_descripcion_unidad.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.7];
    [contenedor_mapa addSubview:contenedor_descripcion_unidad];
    

    UIButton* btn_street = [[UIButton alloc] initWithFrame:contenedor_descripcion_unidad.frame];
    [btn_street addTarget:self action:@selector(ShowStreetView:) forControlEvents:UIControlEventTouchUpInside];
    [contenedor_mapa addSubview:btn_street];

    
    contenedor_street = [[UIView alloc] initWithFrame:contenedor_mapa.frame];
    [contenedor_mapa addSubview:contenedor_street];
    contenedor_street.hidden = YES;
    
    panoView_ = [[GMSPanoramaView alloc] initWithFrame:contenedor_street.frame];
    [contenedor_street addSubview:panoView_];
    
    contenedor_incidencia = [[UIView alloc] initWithFrame:self.view.frame];
    contenedor_incidencia.backgroundColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:0.5];
    contenedor_incidencia.hidden = YES;
    [contenedor_vista addSubview:contenedor_incidencia];
    
    sub_contenedor_incidencia = [[UIView alloc] initWithFrame:CGRectMake( contenedor_incidencia.frame.size.width / 2  - 150, contenedor_incidencia.frame.size.height / 2  - 150,300,300) ];
    sub_contenedor_incidencia.backgroundColor = [UIColor whiteColor];
     [contenedor_incidencia addSubview:sub_contenedor_incidencia];
    
    rect_original_unidades = sub_contenedor_incidencia.frame;
    
    UILabel* lbl_fo = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, sub_contenedor_incidencia.frame.size.width, 50)];
    lbl_fo.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    [sub_contenedor_incidencia addSubview:lbl_fo];
    
    
   
    
    UILabel* lbl_r = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, sub_contenedor_incidencia.frame.size.width, 20)];
    lbl_r.text = @"Solicitar revisión";
    lbl_r.textAlignment = NSTextAlignmentCenter;
    lbl_r.textColor = [UIColor colorWithRed:133.0/255.0 green:22.0/255.0 blue:24.0/255.0 alpha:1];
    [sub_contenedor_incidencia addSubview:lbl_r];
    
    UIButton* cerrar_incidencia = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [cerrar_incidencia addTarget:self action:@selector(ShowIncidencias:) forControlEvents:UIControlEventTouchUpInside];
    [cerrar_incidencia setImage:[UIImage imageNamed:@"btn_atras"] forState:UIControlStateNormal];
    [sub_contenedor_incidencia addSubview:cerrar_incidencia];
    
    txt_incidencia_seleccionada = [[UITextField alloc] initWithFrame:CGRectMake(30, 60, sub_contenedor_incidencia.frame.size.width - 60, 30)];
    txt_incidencia_seleccionada.placeholder = @"Seleccione una opcion";
    txt_incidencia_seleccionada.enabled = NO;
    [sub_contenedor_incidencia addSubview:txt_incidencia_seleccionada];
     [txt_incidencia_seleccionada.layer setBorderWidth:1];
    [txt_incidencia_seleccionada.layer setBorderColor:[UIColor blackColor].CGColor];
     [txt_incidencia_seleccionada.layer setMasksToBounds:YES];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        txt_incidencia_seleccionada.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0];
        
    }
    else{
        
       txt_incidencia_seleccionada.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0];
        
    }
    
    
    UIButton* btn_seleccionar_incidencia = [[UIButton alloc] initWithFrame:CGRectMake(sub_contenedor_incidencia.frame.size.width - 60, 60, 30, 30)];
    [btn_seleccionar_incidencia setImage:[UIImage imageNamed:@"btn_abajo"] forState:UIControlStateNormal];
    [btn_seleccionar_incidencia addTarget:self action:@selector(ShowListaIncidencias:) forControlEvents:UIControlEventTouchUpInside];
    [sub_contenedor_incidencia addSubview:btn_seleccionar_incidencia];
    [btn_seleccionar_incidencia.layer setBorderWidth:1];
    [btn_seleccionar_incidencia.layer setBorderColor:[UIColor blackColor].CGColor];
    [btn_seleccionar_incidencia.layer setMasksToBounds:YES];
    
    txt_descripcion_incidencia = [[UITextView alloc] initWithFrame:CGRectMake(30, 100 , txt_incidencia_seleccionada.frame.size.width + btn_seleccionar_incidencia.frame.size.width - 30, 160 )];
    txt_descripcion_incidencia.backgroundColor = [UIColor whiteColor];
    txt_descripcion_incidencia.delegate = self;
    txt_descripcion_incidencia.text = @"Proporcione más información sobre su incidencia";
    txt_descripcion_incidencia.textColor = [UIColor lightGrayColor];
    [txt_descripcion_incidencia.layer setBorderWidth:1];
    [txt_descripcion_incidencia.layer setBorderColor:[UIColor blackColor].CGColor];
    [txt_descripcion_incidencia.layer setMasksToBounds:YES];
    [sub_contenedor_incidencia addSubview:txt_descripcion_incidencia];
    
    tbl_incidencias = [[UITableView alloc] initWithFrame:txt_descripcion_incidencia.frame];
    tbl_incidencias.backgroundColor= [UIColor whiteColor];
    tbl_incidencias.separatorColor = [UIColor whiteColor];
    tbl_incidencias.dataSource = self;
    tbl_incidencias.delegate = self;
    tbl_incidencias.hidden = YES;
    [sub_contenedor_incidencia addSubview:tbl_incidencias];
    
    
    UIButton* btn_enviar_incidencia = [[UIButton alloc] initWithFrame:CGRectMake(0, 270, sub_contenedor_incidencia.frame.size.width, 30)];
    [btn_enviar_incidencia setTitle:@"Entrar" forState:UIControlStateNormal];
    [btn_enviar_incidencia addTarget:self action:@selector(EnviarIncidencia:) forControlEvents:UIControlEventTouchUpInside];
    [btn_enviar_incidencia setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    btn_enviar_incidencia.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:34.0/255.0 blue:36.0/255.0 alpha:1];
    [sub_contenedor_incidencia addSubview:btn_enviar_incidencia];

    contenedor_invisible = [[UIView alloc]initWithFrame:self.view.frame];
    contenedor_invisible.backgroundColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:0.5];
    contenedor_invisible.hidden = YES;
    [contenedor_vista addSubview:contenedor_invisible];
    
    
    NSUInteger iIndex_grupo=-1;
    
    for (int i = 0; i < [MArrayID count]; i++) {
        
        NSMutableArray* arreglo_unidad = [[NSMutableArray alloc]init];
        [arreglo_unidad addObject:[[MArrayFlota objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayEco objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayID objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayIP objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayLatitud objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayLongitud objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayAngulo objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayVelocidad objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayFecha objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayEvento objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayEstatus objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayIcono objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayUbicacion objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayMotor objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayTelefono objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayMensajes objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [arreglo_unidad addObject:[[MArrayIcono_Mapa objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        
        NSString* stringenIndex = [[MArrayFlota objectAtIndex:i]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        iIndex_grupo = [ArrayNombreFlotas indexOfObject:stringenIndex];
        //si el grupo no exsite lo creo
        if (iIndex_grupo == NSNotFound) {
            [ArrayNombreFlotas addObject:[[MArrayFlota objectAtIndex:i]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            [ArrayNombreFlotasSearch addObject:[[MArrayFlota objectAtIndex:i]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            iIndex_grupo=[ArregloFLotas count]-1;
        }
        [ArregloFLotas addObject:arreglo_unidad];
        [ArregloFLotasSearch addObject:arreglo_unidad];
        
    }
    
    contenedor_animacion = [[UIView alloc]initWithFrame:self.view.frame];
    contenedor_animacion.backgroundColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:0.5];
    contenedor_animacion.hidden = YES;
    [self.view addSubview:contenedor_animacion];
    
    UIActivityIndicatorView* actividad_global = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    actividad_global.color = [UIColor colorWithRed:133.0/255.0 green:22.0/255.0 blue:24.0/255.0 alpha:1];
    actividad_global.hidesWhenStopped = TRUE;
    CGRect newFrames = actividad_global.frame;
    newFrames.origin.x = (contenedor_animacion.frame.size.width / 2) -13;
    newFrames.origin.y = (contenedor_animacion.frame.size.height / 2) - 13;
    actividad_global.frame = newFrames;
    actividad_global.backgroundColor = [UIColor clearColor];
    [actividad_global startAnimating];
    [contenedor_animacion addSubview:actividad_global];
    
    
    contenedor_cancelar = [[UIView alloc] initWithFrame:CGRectMake(contenedor_animacion.frame.size.width / 2 - 130, actividad_global.frame.origin.y + actividad_global.frame.size.height + 20, 260, 60)];
    contenedor_cancelar.backgroundColor = [UIColor whiteColor];
    [contenedor_animacion addSubview:contenedor_cancelar];
    
    UILabel* lbl_ = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, contenedor_cancelar.frame.size.width, 25)];
    lbl_.text = @"Actualizando posición";
    lbl_.textColor = [UIColor blackColor];
    lbl_.textAlignment = NSTextAlignmentCenter;
    [contenedor_cancelar addSubview:lbl_];
    
    UIButton* btn_cancelar = [[UIButton alloc] initWithFrame:CGRectMake(10, 35, contenedor_cancelar.frame.size.width - 20, 20)];
    [btn_cancelar setTitle:@"Cancelar" forState:UIControlStateNormal];
    [btn_cancelar addTarget:self action:@selector(Cancelar_Actualizacion_unidad:) forControlEvents:UIControlEventTouchUpInside];
    [btn_cancelar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    btn_cancelar.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:34.0/255.0 blue:36.0/255.0 alpha:1];
    [contenedor_cancelar addSubview:btn_cancelar];
    
    contenedor_cancelar.hidden = YES;
    
    pk_incidencia = [[UIPickerView alloc] init];
    pk_incidencia.dataSource = self;
    pk_incidencia.delegate = self;
    
}

- (void) reachabilityChangedUnidades:(NSNotification *)note
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

- (void)keyboardWillHideUnidades:(NSNotification *)notif {
    height_keyboard = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey ] CGRectValue].size.height;
    [self setViewMoveUp:NO];
}


- (void)keyboardWillShowUnidades:(NSNotification *)notif{
    height_keyboard = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey ] CGRectValue].size.height;
    [self setViewMoveUp:YES];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMoveUp:(BOOL)moveUp
{
    /*[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2]; // if you want to slide up the view
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    
    
    CGRect rect = sub_contenedor_incidencia.frame;
    if (moveUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        
        if (rect.origin.y == self.view.frame.origin.y ) {
            rect.origin.y = rect_original_unidades.origin.y - height_keyboard;
        }
        
    }
    else
    {
        if (stayup == NO) {
            rect.origin.y = rect_original_unidades.origin.y;
        }
    }
    sub_contenedor_incidencia.frame = rect;
    [UIView commitAnimations];*/
}

-(void)retriveFromSYSoapTool:(NSMutableArray *)_data{
    StringCode = @"";
    StringMsg = @"";
    StringCode = @"-10";
    StringMsg = @"Error en la conexión";
    
    NSData* data = [GlobalString dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    if(![parser parse]){
        NSLog(@"Error al parsear");
        
        
    }
    else{
        NSLog(@"OK Parsing");
        
        
    }
    
    
    
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    
    
}


//xml
-(void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"The XML document is now being parsed.");
    
    if ([metodo_ isEqualToString:@"SendCommand"]){
        if (cancelar_actualizacion==NO) {
            datos_unidad = [[NSMutableArray alloc] init];
        }
    }
    
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
    
     if ([metodo_ isEqualToString:@"DameIncidencias"]){
        if ([elementName isEqualToString:@"descripcion"]) {
            [descripcion_incidencias addObject:currentElementString];
        }
    }
    else if ([metodo_ isEqualToString:@"SendCommand"]){
        if ([elementName isEqualToString:@"Flota"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Eco"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"ID"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"IP"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Latitud"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Longitud"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Angulo"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Velocidad"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Fecha"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Evento"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Estatus"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Icono"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Ubicacion"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Motor"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Telefono"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Mensajes"])
            [datos_unidad addObject:currentElementString];
        if ([elementName isEqualToString:@"Icono_mapa"])
            [datos_unidad addObject:currentElementString];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //Document has been parsed. It's time to fire some new methods off!
    
    [self FillArray];
    
}


-(void)FillArray{
    contenedor_animacion.hidden = YES;
    contenedor_cancelar.hidden = YES;
    if([metodo_ isEqualToString:@"DameIncidencias"]){
        if ([descripcion_incidencias count]>0) {
            [tbl_incidencias reloadData];
            contenedor_animacion.hidden = YES;
            tengo_incidencias = YES;
            [self ShowIncidencias:self];
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"Loc8" message:@"No se pudo completar la petición intente de nuevo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil] show];
        }
    }
    else if ([metodo_ isEqualToString:@"Incidencia"]){
        NSString* mensajeAlerta = StringMsg;
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Loc8"
                                                          message:mensajeAlerta
                                                         delegate:nil
                                                cancelButtonTitle:@"Aceptar"
                                                otherButtonTitles:nil];
        
        [message show];
        //txt incidencia = @"";
        [self ShowIncidencias:self];
    }
    else if ([metodo_ isEqualToString:@"SendCommand"]){
        [self CargarMapa];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Atras:(id)sender{
    
    if (Show_Street) {
        [self ShowStreetView:self];
    }else{
        if (Show_Mapa) {
            [self ShowMapa:self];
        }
        else{
            if (Show_Table_Unidades) {
                [self ShowTableUnidades:self];
            }
        }
    }
}

-(IBAction)EnviarIncidencia:(id)sender{
    NSString *cadena = txt_incidencia_seleccionada.text;
    NSString *cadenaSinEspacios = [cadena stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([cadenaSinEspacios isEqualToString:(@"")]) {
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Loc8"
                                                          message:@"Debe escribir un comentario"
                                                         delegate:nil
                                                cancelButtonTitle:@"Aceptar"
                                                otherButtonTitles:nil];
        [message show];
        
    }
    else{
        if (reachable) {
            metodo_ = @"Incidencia";
            contenedor_animacion.hidden = NO;
            contenedor_cancelar.hidden = YES;
            NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"usName", @"usPassword", @"Tipo", @"Comentarios", @"Eco", @"IP", nil];
            NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:GlobalUsu, Globalpass, incidencia, txt_incidencia.text, detalle_unidad, IP_unidad, nil];
            [soapTool callSoapServiceWithParameters__functionName:@"Incidencia" tags:tags vars:vars wsdlURL:url_web_service];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"Loc8"
                                       message:@"No existe conexión a internet"
                                      delegate:nil
                             cancelButtonTitle:@"Aceptar"
                              otherButtonTitles:nil] show];
        }
        
        
        
    }
}

-(IBAction)ShowMenu:(id)sender{
    CGRect frame_panel_vista = contenedor_vista.frame;
    CGRect frame_menu = contenedor_menu.frame;
    if (ShowMenu==NO) {
        ShowMenu = YES;
        frame_panel_vista.origin.x = frame_panel_vista.origin.x + width_;
        frame_menu.origin.x = frame_menu.origin.x + width_;
        contenedor_invisible.hidden = NO;
    }
    else{
        ShowMenu = NO;
        frame_panel_vista.origin.x = frame_panel_vista.origin.x - width_;
        frame_menu.origin.x = frame_menu.origin.x - width_;
        contenedor_invisible.hidden = YES;
    }
    
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:0.9];
    contenedor_vista.frame = frame_panel_vista;
    contenedor_menu.frame = frame_menu;
    [UIView commitAnimations];
}

-(IBAction)ShowTableUnidades:(id)sender{
    
    CGRect frame_tbl_unidades = contenedor_tbl_unidades.frame;
    if (Show_Table_Unidades==NO) {
        Show_Table_Unidades = YES;
        frame_tbl_unidades.origin.x = 0;
        btn_atras.hidden = NO;
        btn_menu.hidden = YES;
    }
    else{
        if (![texto_busqueda isEqualToString:@""]) {
            [self->searchBar_flotas becomeFirstResponder];
        }
        Show_Table_Unidades = NO;
        btn_atras.hidden = YES;
        btn_menu.hidden = NO;
        frame_tbl_unidades.origin.x = self.view.frame.size.width;
    }
    
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:0.2];
    contenedor_tbl_unidades.frame = frame_tbl_unidades;
    [UIView commitAnimations];
    
}

-(IBAction)ShowMapa:(id)sender{
    if (Show_Mapa==NO) {
        Show_Mapa = YES;
        contenedor_mapa.hidden = NO;
    }
    else{
        if (![texto_busqueda_unidad isEqualToString:@""]) {
            [self->searchBar_Unidades becomeFirstResponder];
        }
        Show_Mapa = NO;
        contenedor_mapa.hidden = YES;
    }
    
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView commitAnimations];
}

-(IBAction)ShowStreetView:(id)sender{
    if (Show_Street==NO) {
        Show_Street = YES;
        contenedor_street.hidden = NO;
    }
    else{
        Show_Street = NO;
        contenedor_street.hidden = YES;
    }
    
    [UIView beginAnimations:Nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView commitAnimations];
}

-(IBAction)ShowIncidencias:(id)sender{
    
    if (tengo_incidencias) {
        if (Show_Incidencias==NO) {
            Show_Incidencias = YES;
            contenedor_incidencia.hidden = NO;
        }
        else{
            Show_Incidencias = NO;
            contenedor_incidencia.hidden = YES;
        }
        
        [UIView beginAnimations:Nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView commitAnimations];
    }else{
        
        if (reachable) {
            contenedor_animacion.hidden = NO;
            contenedor_cancelar.hidden = YES;
            descripcion_incidencias = [[NSMutableArray alloc]init];
            NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"usName", @"usPassword", nil];
            NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:GlobalUsu, Globalpass, nil];
            metodo_ = @"DameIncidencias";
            [soapTool callSoapServiceWithParameters__functionName:@"DameIncidencias" tags:tags vars:vars wsdlURL:url_web_service];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"Loc8"
                                        message:@"No existe conexión a internet"
                                       delegate:nil
                              cancelButtonTitle:@"Aceptar"
                              otherButtonTitles:nil] show];
        }
        
        
    }
}

-(IBAction)ShowListaIncidencias:(id)sender{
    /*//create the alertview
    setIncidencia = [[UIAlertView alloc] initWithTitle:@"Incidencia"
                                              message:nil
                                             delegate:self
                                    cancelButtonTitle:@"Aceptar"
                                    otherButtonTitles:nil, nil];
    setIncidencia.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    txt_incidencia = [setIncidencia textFieldAtIndex:0];
    //change the textfields inputView to the date picker
    txt_incidencia.inputView = pk_incidencia;
    
    [setIncidencia show];*/
    
    tbl_incidencias.hidden = NO;
    
}


-(NSInteger)ContarUnidades:(NSString*)NombreArregloAContar{
    
    NSInteger retorno = 0;
    
    for (int i = 0; i<[ArregloFLotasSearch count]; i++) {
        if ([NombreArregloAContar isEqualToString:[[ArregloFLotasSearch objectAtIndex:i] objectAtIndex:0]]) {
            retorno++;
        }
    }
    
    return retorno;
}

-(IBAction)ActualizarPosicion:(id)sender{
    if (reachable) {
        contenedor_animacion.hidden = NO;
        cancelar_actualizacion = NO;
        contenedor_cancelar.hidden = NO;
        metodo_ = @"SendCommand";
        NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"usName", @"usPassword", @"identificador_unidad", @"comando", @"velocidad", nil];
        NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:GlobalUsu, Globalpass, IP_unidad, @"gps_now", limite_velocidad,nil];
        [soapTool callSoapServiceWithParameters__functionName:@"SendCommand" tags:tags vars:vars wsdlURL:url_web_service];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Loc8"
                                    message:@"No existe conexión a internet"
                                   delegate:nil
                          cancelButtonTitle:@"Aceptar"
                          otherButtonTitles:nil] show];
    }
}
-(IBAction)SolicitarRevision:(id)sender{
    [self ShowIncidencias:self];
}
-(IBAction)Compartir:(id)sender{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    UIActivityViewController* activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[capturedScreen]
                                      applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:^{}];
}

-(IBAction)Cancelar_Actualizacion_unidad:(id)sender{
    
}

#pragma mark - UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString* retorno = @"";
    if (tableView == tbl_unidades) {
        retorno = [NSString stringWithFormat:@"%@", NombreFlotaUnidades];
    }
    
    return retorno;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger retorno = 0;
    if (tableView == tbl_menu)
        retorno = [array_menu count];
    else if (tableView == tbl_flotas)
        retorno = [ArrayNombreFlotasSearch count];
    else if (tableView == tbl_unidades)
        retorno = [ArrayUnidadestem count];
    else if (tableView == tbl_incidencias)
        retorno = [descripcion_incidencias count];
    return retorno;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell  = nil;
    
    if (tableView == tbl_flotas) {
        cell  = [tableView dequeueReusableCellWithIdentifier:@"celda"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"celda"];
        }
        
        cell.textLabel.text = [ArrayNombreFlotasSearch objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu Unidades", (unsigned long) [self ContarUnidades:[ArrayNombreFlotasSearch objectAtIndex:indexPath.row]]];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
        cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
            cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.detailTextLabel.numberOfLines = 2;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(10, cell.frame.size.height - 2, self.view.frame.size.width - 10, 1)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(10, cell.frame.size.height - 2, self.view.frame.size.width - 10, 1)];
        
        separatorLineView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]; // set color as you want.
        [cell.contentView addSubview:separatorLineView];
    }
    
    
    else if (tableView == tbl_menu) {
        
        static NSString *simpleTableIdentifier = @"TableCell";
        TableCellResumen *cell_;
        
        cell_ = (TableCellResumen *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell_ == nil)
        {
            NSString* NibName = @"TableCellResumen";
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NibName owner:self options:nil];
            cell_ = [nib objectAtIndex:0];
            if ([dispositivo isEqualToString:@"iPhone6"])
                cell_ = [nib objectAtIndex:1];
            else if ([dispositivo isEqualToString:@"iPhone6plus"])
                cell_ = [nib objectAtIndex:2];
            else if ([dispositivo isEqualToString:@"iPad"])
                cell_ = [nib objectAtIndex:3];
        }
        cell_.lbl_menu.text = [array_menu objectAtIndex:indexPath.row];
        cell_.img_menu.image = [UIImage imageNamed:[array_menu_imagenes objectAtIndex:indexPath.row]];
        cell_.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = cell_;
    }
    
    else if (tableView == tbl_unidades) {
        
        static NSString *simpleTableIdentifier = @"TableCell";
        TableCellResumen *cell_;
        
        cell_ = (TableCellResumen *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell_ == nil)
        {
            NSString* NibName = @"TableCellResumen";
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NibName owner:self options:nil];
            cell_ = [nib objectAtIndex:4];
            if ([dispositivo isEqualToString:@"iPhone6"])
                cell_ = [nib objectAtIndex:5];
            else if ([dispositivo isEqualToString:@"iPhone6plus"])
                cell_ = [nib objectAtIndex:6];
            else if ([dispositivo isEqualToString:@"iPad"])
                cell_ = [nib objectAtIndex:7];
        }

        cell_.img_motor.image = [UIImage imageNamed:@"motor_off.png"];
        NSMutableArray * datos = [[NSMutableArray alloc]init];
        datos = [ArrayUnidadestem objectAtIndex:indexPath.row];
        NSString* velocidad = [datos objectAtIndex:7];
        NSString* i_angulo = [[datos objectAtIndex:6] stringByReplacingOccurrencesOfString:@".png" withString:@""];
        if ([[datos objectAtIndex:9] isEqualToString:@"SIN REPORTAR"]) {
            cell_.img_motor.image = [UIImage imageNamed:@"motor_sin"];
            i_angulo = [NSString stringWithFormat:@"%@_sin", i_angulo];
            cell_.img_angulo.image = [UIImage imageNamed:i_angulo];
            cell_.lbl_evento.textColor = [UIColor colorWithRed:119.0/255.0 green:120.0/255.0 blue:119.0/255.0 alpha:1];
            cell_.lbl_fecha.textColor = [UIColor colorWithRed:119.0/255.0 green:120.0/255.0 blue:119.0/255.0 alpha:1];
            velocidad = [NSString stringWithFormat:@"%@  km/h", velocidad];
        }else{
            NSString* i_motor = [datos objectAtIndex:13];
            cell_.lbl_evento.textColor = [UIColor colorWithRed:0.0/255.0 green:139.0/255.0 blue:57.0/255.0 alpha:1];
            cell_.lbl_fecha.textColor = [UIColor colorWithRed:0.0/255.0 green:139.0/255.0 blue:57.0/255.0 alpha:1];
            NSNumber* velocidad_ = [NSNumber numberWithFloat:[velocidad floatValue]];
            NSNumber* limite_velocidad_ = [NSNumber numberWithFloat:[limite_velocidad floatValue]];
            if ([velocidad_ doubleValue]>  [limite_velocidad_ doubleValue]) {
                velocidad = [NSString stringWithFormat:@"EXCESO DE VELOCIDAD %@  km/h", velocidad];
                cell_.lbl_velocidad.textColor = [UIColor redColor];
            }else{
                velocidad = [NSString stringWithFormat:@"%@  km/h", velocidad];
                cell_.lbl_velocidad.textColor = [UIColor colorWithRed:0.0/255.0 green:139.0/255.0 blue:57.0/255.0 alpha:1];
            }
            if ([i_motor isEqualToString:@"ON"]){
                cell_.img_motor.image = [UIImage imageNamed:@"motor_on.png"];
                
                cell_.img_angulo.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_on", i_angulo]];
            }
            else if ([i_motor isEqualToString:@"OFF"]){
                cell_.img_motor.image = [UIImage imageNamed:@"motor_off.png"];
                cell_.img_angulo.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_off", i_angulo]];
            }
        }

        cell_.lbl_eco.text = [datos objectAtIndex:1];
        cell_.lbl_evento.text = [datos objectAtIndex:9];
        cell_.lbl_fecha.text = [datos objectAtIndex:8];
        cell_.lbl_direccion.text = [datos objectAtIndex:12];
        cell_.lbl_velocidad.text = velocidad;
        cell_.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = cell_;
    }
    else if (tableView == tbl_incidencias){
        cell  = [tableView dequeueReusableCellWithIdentifier:@"celda"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celda"];
        }
        
        cell.textLabel.text = [descripcion_incidencias objectAtIndex:indexPath.row];
         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
              cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0];
            
        }
        else{
            
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17.0];
            
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle =  UITableViewCellSelectionStyleGray;
 /*       UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(10, cell.frame.size.height - 2, self.view.frame.size.width - 10, 1)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(10, cell.frame.size.height - 2, self.view.frame.size.width - 10, 1)];
        
        separatorLineView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]; // set color as you want.
        [cell.contentView addSubview:separatorLineView];*/
    }
    
    return cell;
    
}

//Change the Height of the Cell [Default is 44]:
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    float retorno = 30;
    if (tableView==tbl_unidades)
        retorno = 100;
    if (tableView==tbl_flotas)
        retorno = 50;

    return retorno;
}

#pragma mark - UITableViewDataSource
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==tbl_menu) {
        if (indexPath.row == 3) {
            NSString* view_name = @"Login";
            if (![dispositivo isEqualToString:@""]) {
                view_name = [NSString stringWithFormat:@"%@_%@", view_name,dispositivo];
            }
            
            Login *view = [[Login alloc] initWithNibName:view_name bundle:nil];
            view.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:view animated:YES completion:nil];
        }
    }
    else if (tableView == tbl_flotas){
        ArrayUnidades = [[NSMutableArray alloc] init];
        ArrayUnidadestem = [[NSMutableArray alloc] init];
        NombreFlotaUnidades = [ArrayNombreFlotasSearch objectAtIndex:indexPath.row];
        for (int i = 0; i<[ArregloFLotasSearch count]; i++) {
            if ([NombreFlotaUnidades isEqualToString:[[ArregloFLotasSearch objectAtIndex:i] objectAtIndex:0]]) {
                [ArrayUnidades addObject:[ArregloFLotasSearch objectAtIndex:i]];
            }
        }
        if ([[NombreFlotaUnidades stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]isEqualToString:@""]) {
            NombreFlotaUnidades = @"       ";
        }
        ArrayUnidadestem = [ArrayUnidades copy];
        [tbl_unidades reloadData];
        
        
        self->searchBar_Unidades.text = @"";
        [self->searchBar_flotas resignFirstResponder];
        [self ShowTableUnidades:self];
    }else if (tableView == tbl_unidades){
        
        datos_unidad = [[NSMutableArray alloc]init];
        datos_unidad = [ArrayUnidadestem objectAtIndex:indexPath.row];
        [self CargarMapa];
        [self ShowMapa:self];
    }else if (tableView == tbl_incidencias){
        
        incidencia = [descripcion_incidencias objectAtIndex:indexPath.row];
        incidencia = [incidencia stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        txt_incidencia_seleccionada.text = [NSString stringWithFormat:@"  %@", incidencia];
        tbl_incidencias.hidden = YES;
        
    }
    
    
    
    return indexPath;
}

-(void)CargarMapa{
    
    IP_unidad = [datos_unidad objectAtIndex:3];
    IP_unidad = [IP_unidad stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    lbl_nombre_unidad.text = [datos_unidad objectAtIndex:1];
    detalle_unidad = [datos_unidad objectAtIndex:1];
    
    NSString* velocidad = [datos_unidad objectAtIndex:7];
    if ([[datos_unidad objectAtIndex:9] isEqualToString:@"SIN REPORTAR"]) {
        contenedor_descripcion_unidad.lbl_evento.textColor = [UIColor colorWithRed:119.0/255.0 green:120.0/255.0 blue:119.0/255.0 alpha:1];
        contenedor_descripcion_unidad.lbl_fecha.textColor = [UIColor colorWithRed:119.0/255.0 green:120.0/255.0 blue:119.0/255.0 alpha:1];
        velocidad = [NSString stringWithFormat:@"%@  km/h", velocidad];
    }else{
        contenedor_descripcion_unidad.lbl_evento.textColor = [UIColor colorWithRed:0.0/255.0 green:139.0/255.0 blue:57.0/255.0 alpha:1];
        contenedor_descripcion_unidad.lbl_fecha.textColor = [UIColor colorWithRed:0.0/255.0 green:139.0/255.0 blue:57.0/255.0 alpha:1];
        NSNumber* velocidad_ = [NSNumber numberWithFloat:[velocidad floatValue]];
        NSNumber* limite_velocidad_ = [NSNumber numberWithFloat:[limite_velocidad floatValue]];
        if ([velocidad_ doubleValue]>  [limite_velocidad_ doubleValue]) {
            velocidad = [NSString stringWithFormat:@"EXCESO DE VELOCIDAD %@  km/h", velocidad];
            contenedor_descripcion_unidad.lbl_velocidad.textColor = [UIColor redColor];
        }else{
            velocidad = [NSString stringWithFormat:@"%@  km/h", velocidad];
            contenedor_descripcion_unidad.lbl_velocidad.textColor = [UIColor colorWithRed:0.0/255.0 green:139.0/255.0 blue:57.0/255.0 alpha:1];
            
        }
    }
    
    contenedor_descripcion_unidad.lbl_eco.text = [datos_unidad objectAtIndex:1];
    contenedor_descripcion_unidad.lbl_evento.text = [datos_unidad objectAtIndex:9];
    contenedor_descripcion_unidad.lbl_fecha.text = [datos_unidad objectAtIndex:8];
    contenedor_descripcion_unidad.lbl_direccion.text = [datos_unidad objectAtIndex:12];
    contenedor_descripcion_unidad.lbl_velocidad.text = velocidad;
    
    [mapView_ clear];
    
    
    marker_unidad = [[GMSMarker alloc] init];
    marker_unidad.position = CLLocationCoordinate2DMake([[datos_unidad objectAtIndex:4] doubleValue], [[datos_unidad objectAtIndex:5] doubleValue]);
    marker_unidad.icon = [UIImage imageNamed:@"marker_auto"];
    marker_unidad.map = mapView_;
    
    GMSCameraPosition *sydney = [GMSCameraPosition cameraWithLatitude:[[datos_unidad objectAtIndex:4] doubleValue]
                                                            longitude:[[datos_unidad objectAtIndex:5] doubleValue]
                                                                 zoom:5];
    [mapView_ setCamera:sydney];
    
    [panoView_ moveNearCoordinate:CLLocationCoordinate2DMake([[datos_unidad objectAtIndex:4] doubleValue], [[datos_unidad objectAtIndex:5] doubleValue])];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if (searchBar==searchBar_flotas)
        [self->searchBar_flotas setShowsCancelButton:YES animated:YES];
    if (searchBar==searchBar_Unidades)
        [self->searchBar_Unidades setShowsCancelButton:YES animated:YES];
    
}


-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if (searchBar==searchBar_flotas)
        [self->searchBar_flotas setShowsCancelButton:NO animated:YES];
    if (searchBar==searchBar_Unidades)
        [self->searchBar_Unidades setShowsCancelButton:NO animated:YES];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar==searchBar_flotas) {
        NSString* texto = self->searchBar_flotas.text;
        if([searchText isEqualToString:@""] || searchText==nil) {
            ArrayNombreFlotasSearch = [ArrayNombreFlotas copy];
            ArregloFLotasSearch = [ArregloFLotas copy];
            texto_busqueda = @"";
            // [self.searchBar resignFirstResponder];
        }
        else {
            ArrayNombreFlotasSearch = [[NSMutableArray alloc]init];
            ArregloFLotasSearch = [[NSMutableArray alloc]init];
            for (int i = 0; i<[ArregloFLotas count]; i++) {
                NSMutableArray* temporal = [[NSMutableArray alloc]init];
                temporal = [ArregloFLotas objectAtIndex:i];
                NSRange r = [[temporal objectAtIndex:1] rangeOfString: texto options:NSCaseInsensitiveSearch];
                NSRange r1 = [[temporal objectAtIndex:12] rangeOfString: texto options:NSCaseInsensitiveSearch];
                BOOL entra_busqueda = NO;
                
                if ([busqueda isEqualToString:@"Ecónomico, Dirección"]) {
                    if (r.length>0 || r1.length>0) {
                        entra_busqueda = YES;
                    }
                }
                else if ([busqueda isEqualToString:@"Ecónomico"]){
                    if (r.length>0) {
                        entra_busqueda = YES;
                    }
                    
                }
                else if ([busqueda isEqualToString:@"Dirección"]){
                    if (r1.length>0) {
                        entra_busqueda = YES;
                    }
                }
                
                
                if (entra_busqueda == YES) {
                    NSInteger iIndex_grupo = -1;
                    NSString* stringenIndex = [[temporal objectAtIndex:0]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    iIndex_grupo = [ArrayNombreFlotasSearch indexOfObject:stringenIndex];
                    //si el grupo no exsite lo creo
                    if (iIndex_grupo == NSNotFound) {
                        [ArrayNombreFlotasSearch addObject:[[temporal objectAtIndex:0]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
                        iIndex_grupo=[ArregloFLotasSearch count]-1;
                    }
                    [ArregloFLotasSearch addObject:temporal];
                    
                }
                texto_busqueda = self->searchBar_flotas.text;
            }
            
        }
        
        [tbl_flotas reloadData];
    }
    if (searchBar==searchBar_Unidades) {
        NSString* texto = self->searchBar_Unidades.text;
        if([searchText isEqualToString:@""] || searchText==nil) {
            ArrayUnidadestem = [ArrayUnidades copy];
            texto_busqueda_unidad = @"";
            // [self.searchBar resignFirstResponder];
        }
        else {
            ArrayUnidadestem = [[NSMutableArray alloc] init];
            for (int i = 0; i<[ArrayUnidades count]; i++) {
                NSMutableArray* temporal = [[NSMutableArray alloc]init];
                temporal = [ArrayUnidades objectAtIndex:i];
                NSRange r = [[temporal objectAtIndex:1] rangeOfString: texto options:NSCaseInsensitiveSearch];
                NSRange r1 = [[temporal objectAtIndex:12] rangeOfString: texto options:NSCaseInsensitiveSearch];
                BOOL entra_busqueda = NO;
                
                if ([busqueda isEqualToString:@"Ecónomico, Dirección"]) {
                    if (r.length>0 || r1.length>0) {
                        entra_busqueda = YES;
                    }
                }
                else if ([busqueda isEqualToString:@"Ecónomico"]){
                    if (r.length>0) {
                        entra_busqueda = YES;
                    }
                    
                }
                else if ([busqueda isEqualToString:@"Dirección"]){
                    if (r1.length>0) {
                        entra_busqueda = YES;
                    }
                }
                
                
                if (entra_busqueda == YES) {
                    [ArrayUnidadestem addObject:temporal];
                }
                texto_busqueda_unidad = self->searchBar_Unidades.text;
            }
        }
        
        [tbl_unidades reloadData];
    }
}



-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self->searchBar_Unidades.text = @"";
    texto_busqueda_unidad = @"";
    ArrayUnidadestem = [ArrayUnidades copy];
    [tbl_unidades reloadData];
    [self->searchBar_Unidades resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    ArrayUnidadestem = [[NSMutableArray alloc] init];
    for (int i = 0; i<[ArrayUnidades count]; i++) {
        NSMutableArray* temporal = [[NSMutableArray alloc]init];
        temporal = [ArrayUnidades objectAtIndex:i];
        NSRange r = [[temporal objectAtIndex:1] rangeOfString: texto_busqueda_unidad options:NSCaseInsensitiveSearch];
        NSRange r1 = [[temporal objectAtIndex:12] rangeOfString: texto_busqueda_unidad options:NSCaseInsensitiveSearch];
        BOOL entra_busqueda = NO;
        
        if ([busqueda isEqualToString:@"Ecónomico, Dirección"]) {
            if (r.length>0 || r1.length>0) {
                entra_busqueda = YES;
            }
        }
        else if ([busqueda isEqualToString:@"Ecónomico"]){
            if (r.length>0) {
                entra_busqueda = YES;
            }
            
        }
        else if ([busqueda isEqualToString:@"Dirección"]){
            if (r1.length>0) {
                entra_busqueda = YES;
            }
        }
        
        
        if (entra_busqueda == YES) {
            [ArrayUnidadestem addObject:temporal];
        }
        texto_busqueda_unidad = self->searchBar_Unidades.text;
    }
    [tbl_flotas reloadData];
    
    [self->searchBar_Unidades resignFirstResponder];
}


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    
    if (ShowMenu) {
        [self ShowMenu:self];
    }
    
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return descripcion_incidencias.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    incidencia = [descripcion_incidencias objectAtIndex:row];
    incidencia = [incidencia stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]];
    incidencia = [incidencia stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return incidencia;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    incidencia = [descripcion_incidencias objectAtIndex:row];
    incidencia = [incidencia stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]];
    incidencia = [incidencia stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    txt_incidencia.text = incidencia;
    txt_incidencia_seleccionada.text = incidencia;
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil) {
        
        CGRect frame;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            frame = CGRectMake(0.0, 0.0, 299, 30);
        }
        else{
            frame = CGRectMake(0.0, 0.0, 650, 60);
        }
        
        //label size
        
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        //here you can play with fonts
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [pickerLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0]];
        }
        else{
            [pickerLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:17.0]];
        }
        
    }
    //picker view array is the datasource
    NSString *trimmedString = [[descripcion_incidencias objectAtIndex:row] stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    trimmedString = [[descripcion_incidencias objectAtIndex:row] stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [pickerLabel setText:trimmedString];
    return pickerLabel;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Proporcione más información sobre su incidencia"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Proporcione más información sobre su incidencia";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
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
