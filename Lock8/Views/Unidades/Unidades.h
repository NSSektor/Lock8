//
//  Unidades.h
//  Lock8
//
//  Created by Angel Rivas on 4/17/15.
//  Copyright (c) 2015 Tecnologizame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "TableCellResumen.h"
#import "SYSoapTool.h"
#import "Reachability.h"

@interface Unidades : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,GMSMapViewDelegate,SOAPToolDelegate, NSXMLParserDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>{
    UIView* contenedor_vista;
    UIView* contenedor_menu;
    UIView* contenedor_invisible;
    UITableView* tbl_menu;
    UISearchBar* searchBar_flotas;
    UITableView* tbl_flotas;
    UIView* contenedor_tbl_unidades;
    UISearchBar* searchBar_Unidades;
    UITableView* tbl_unidades;
    UIButton* btn_atras;
    UIButton* btn_menu;
    UIView* contenedor_mapa;
    GMSMapView *mapView_;
    UILabel     *lbl_eco;
    UILabel     *lbl_fecha;
    UILabel     *lbl_evento;
    UILabel     *lbl_velocidad;
    UILabel     *lbl_direccion;
    TableCellResumen* contenedor_descripcion_unidad;
    UIView* contenedor_animacion;
    UIView* contenedor_cancelar;
    UILabel* lbl_nombre_unidad;
    UIImageView* img_titulo;
    UIView* contenedor_botones;
    UIView* contenedor_street;
    GMSPanoramaView* panoView_;
    
    UIView* contenedor_incidencia;
    UIView* contenedor_tbl_incidencia;
    UITableView* tbl_incidencia;
    UITextField* txt_incidencia_seleccionada;
    UITextView* txt_descripcion_incidencia;
    UITableView* tbl_incidencias;
    
    NSTimer *contadorTimer;
    
    
    ////xml///
    NSString* currentElement;
    NSMutableDictionary* currentElementData;
    NSMutableString* currentElementString;
    NSString *StringCode;
    NSString *StringMsg;
    
    Reachability* internetReachable;
    Reachability* hostReachable;
}

-(IBAction)ShowMenu:(id)sender;
-(IBAction)ShowTableUnidades:(id)sender;
-(IBAction)ShowMapa:(id)sender;
-(IBAction)ShowStreetView:(id)sender;
-(IBAction)ShowIncidencias:(id)sender;
-(IBAction)ShowListaIncidencias:(id)sender;
-(IBAction)Atras:(id)sender;
-(IBAction)EnviarIncidencia:(id)sender;
-(NSInteger)ContarUnidades:(NSString*)NombreArregloAContar;
-(IBAction)ActualizarPosicion:(id)sender;
-(IBAction)SolicitarRevision:(id)sender;
-(IBAction)Compartir:(id)sender;
-(IBAction)Cancelar_Actualizacion_unidad:(id)sender;
-(void)FillArray;
-(void)CargarMapa;
-(void)actualizarxtimer:(id)sender;
-(IBAction)actualizar:(id)sender;
-(void)EscribirArchivos;
-(void) checkNetworkStatus:(NSNotification *)notice;

@end
