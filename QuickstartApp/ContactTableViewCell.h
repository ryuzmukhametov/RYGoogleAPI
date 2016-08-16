//
//  ContactTableViewCell.h
//  QuickstartApp
//
//  Created by ryuzmukhametov on 16/08/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end
