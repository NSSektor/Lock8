//
//  TableCellResumen.h
//  Tracking
//
//  Created by Angel Rivas on 22/01/14.
//  Copyright (c) 2014 tecnologizame. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCellResumen : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *img_menu;
@property (nonatomic, weak) IBOutlet UILabel     *lbl_menu;
@property (nonatomic, weak) IBOutlet UIImageView *img_angulo;
@property (nonatomic, weak) IBOutlet UIImageView *img_motor;
@property (nonatomic, weak) IBOutlet UILabel     *lbl_eco;
@property (nonatomic, weak) IBOutlet UILabel     *lbl_fecha;
@property (nonatomic, weak) IBOutlet UILabel     *lbl_evento;
@property (nonatomic, weak) IBOutlet UILabel     *lbl_velocidad;
@property (nonatomic, weak) IBOutlet UILabel     *lbl_direccion;




@end
