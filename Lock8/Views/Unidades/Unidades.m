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

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


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
    GMSMarker *marker_posicion;
    GMSMarker* marker_unidad;
    CLLocationCoordinate2D position_unidad;
    NSMutableArray* datos_unidad;
    BOOL Show_Mapa;
    CLLocation *mi_ubicacion;
    SYSoapTool *soapTool;
    NSString* metodo_;
    BOOL cancelar_actualizacion;
    NSString* IP_unidad;
}

@end

@implementation Unidades

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ShowMenu = NO;
    Show_Table_Unidades = NO;
    cancelar_actualizacion = NO;
    Show_Mapa = NO;
    texto_busqueda = @"";
    texto_busqueda_unidad = @"";
    soapTool = [[SYSoapTool alloc]init];
    soapTool.delegate = self;
    
    
    width_ = 270;
    font_size = 25.0f;
    contenedor_vista = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contenedor_vista.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contenedor_vista];
    
    contenedor_menu = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width - 50, self.view.frame.size.height)];
    contenedor_menu.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contenedor_menu];
    CGRect rect_btn_menu  = CGRectMake( 0, 20, 40, 40);
    

   if ([dispositivo isEqualToString:@"iPhone5"]) {
        size_celda_menu = 40;
       // rect_tbl_menu                = CGRectMake(0, 160, 270, 245);
    }
    else if ([dispositivo isEqualToString:@"iPhone6"]){
        size_celda_menu = 44;
        width_ = 325;
        font_size = 28.0f;
        rect_btn_menu  = CGRectMake(0, 20, 50, 50);
    }else if ([dispositivo isEqualToString:@"iPhone6plus"]){
        size_celda_menu = 44;
        width_ = 364;
        font_size = 28.0f;
        rect_btn_menu  = CGRectMake(0, 20, 50, 50);
    }else if ([dispositivo isEqualToString:@"iPad"]){
        size_celda_menu = 51;
        width_ = 716;
        font_size = 30.0f;
        rect_btn_menu  = CGRectMake(0, 20, 70, 70);
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
    contenedor_botones.backgroundColor = [UIColor colorWithRed:133.0/255.0 green:22.0/255.0 blue:24.0/255.0 alpha:0.8];
    [contenedor_mapa addSubview:contenedor_botones];
    
    for (int i = 0; i <3; i++) {
        UIImageView* img_;
        UIButton* btn_;
        CGFloat orig_x =  ((contenedor_botones.frame.size.width / 3) /2) - ((600 / (300 / contenedor_botones.frame.size.height)) / 2);
        switch (i) {
            case 0:{
                 img_ = [[UIImageView alloc] initWithFrame:CGRectMake(orig_x, 0, 600 / (300 / contenedor_botones.frame.size.height), contenedor_botones.frame.size.height)];
                img_.image = [UIImage imageNamed:@"actualizar"];
                btn_ = [[UIButton alloc] initWithFrame:img_.frame];
                [btn_ addTarget:self action:@selector(ActualizarPosicion:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 1:{
                img_ = [[UIImageView alloc] initWithFrame:CGRectMake(orig_x + (600 / (300 / contenedor_botones.frame.size.height)) , 0, 600 / (300 / contenedor_botones.frame.size.height), contenedor_botones.frame.size.height)];
                img_.image = [UIImage imageNamed:@"revision"];
                btn_ = [[UIButton alloc] initWithFrame:img_.frame];
                [btn_ addTarget:self action:@selector(SolicitarRevision:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 2:{
                img_ = [[UIImageView alloc] initWithFrame:CGRectMake(orig_x + (600 / (300 / contenedor_botones.frame.size.height)) + (600 / (300 / contenedor_botones.frame.size.height))  , 0, 600 / (300 / contenedor_botones.frame.size.height), contenedor_botones.frame.size.height)];
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
    contenedor_descripcion_unidad.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.3];
    [contenedor_mapa addSubview:contenedor_descripcion_unidad];
    
/*    lbl_eco = [uila]
    lbl_fecha;
    lbl_evento;
    lbl_velocidad;
    lbl_direccion;*/
    
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    #ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
    }
#endif
    [locationManager startUpdatingLocation];
    
    
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
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
    
    UIButton* btn_cancelar = [[UIButton alloc] initWithFrame:CGRectMake(0, 35, contenedor_cancelar.frame.size.width, 25)];
    [btn_cancelar setTitle:@"Cancelar" forState:UIControlStateNormal];
    [btn_cancelar addTarget:self action:@selector(Cancelar_Actualizacion_unidad:) forControlEvents:UIControlEventTouchUpInside];
    [btn_cancelar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    btn_cancelar.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:34.0/255.0 blue:36.0/255.0 alpha:1];
    [contenedor_cancelar addSubview:btn_cancelar];
    
    contenedor_cancelar.hidden = YES;
    
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
        //    [descripcion_incidencias addObject:currentElementString];
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
   /*     if ([descripcion_incidencias count]>0) {
            [pickerview reloadAllComponents];
            contenedor_animacion.hidden = YES;
            tengo_incidencias = YES;
            [self ShowIncidencia:self];
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"Tracking" message:@"No se pudo completar la petición intente de nuevo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil] show];
        }*/
    }
    else if ([metodo_ isEqualToString:@"Incidencia"]){
     /*   NSString* mensajeAlerta = StringMsg;
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Tracking"
                                                          message:mensajeAlerta
                                                         delegate:nil
                                                cancelButtonTitle:@"Aceptar"
                                                otherButtonTitles:nil];
        
        [message show];
        //txt incidencia = @"";
        [self ShowIncidencia:self];*/
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
    
    if (Show_Mapa) {
        [self ShowMapa:self];
    }
    else{
        if (Show_Table_Unidades) {
            [self ShowTableUnidades:self];
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
        btn_menu.hidden = YES;
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
    contenedor_animacion.hidden = NO;
    cancelar_actualizacion = NO;
    contenedor_cancelar.hidden = NO;
    metodo_ = @"SendCommand";
    NSMutableArray *tags = [[NSMutableArray alloc]initWithObjects:@"usName", @"usPassword", @"identificador_unidad", @"comando", @"velocidad", nil];
    NSMutableArray *vars = [[NSMutableArray alloc]initWithObjects:GlobalUsu, Globalpass, IP_unidad, @"gps_now", limite_velocidad,nil];
    [soapTool callSoapServiceWithParameters__functionName:@"SendCommand" tags:tags vars:vars wsdlURL:url_web_service];
}
-(IBAction)SolicitarRevision:(id)sender{
    
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
    
    return cell;
    
}

//Change the Height of the Cell [Default is 44]:
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    float retorno = 50;
    if (tableView==tbl_unidades)
        retorno = 100;

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
    }
    
    
    
    return indexPath;
}

-(void)CargarMapa{
    
    IP_unidad = [datos_unidad objectAtIndex:3];
    IP_unidad = [IP_unidad stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    lbl_nombre_unidad.text = [datos_unidad objectAtIndex:1];
    
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
    
    GMSMutablePath *path = [GMSMutablePath path];
    
    marker_unidad = [[GMSMarker alloc] init];
    marker_unidad.position = CLLocationCoordinate2DMake([[datos_unidad objectAtIndex:4] doubleValue], [[datos_unidad objectAtIndex:5] doubleValue]);
    marker_unidad.icon = [UIImage imageNamed:@"ubicacion_unidad"];
    marker_unidad.map = mapView_;
    [path addCoordinate: marker_unidad.position];
    
    NSString* latitud = [NSString stringWithFormat:@"%f", mi_ubicacion.coordinate.latitude];
    NSString* longitud = [NSString stringWithFormat:@"%f", mi_ubicacion.coordinate.longitude];
    
    marker_posicion = [[GMSMarker alloc] init];
    marker_posicion.position = CLLocationCoordinate2DMake([latitud doubleValue], [longitud doubleValue]);
    marker_posicion.icon = [UIImage imageNamed:@"mi_ubicacion"];
    marker_posicion.map = mapView_;
    [path addCoordinate: marker_posicion.position];
    GMSCoordinateBounds*  bounds = [[GMSCoordinateBounds alloc] initWithPath:path];
    [mapView_ moveCamera:[GMSCameraUpdate fitBounds:bounds withPadding:50.0]];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    mi_ubicacion = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude
                                              longitude:newLocation.coordinate.longitude];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
