//
//  ViewController.h
//  QuickstartApp
//
//  Created by ryuzmukhametov on 16/08/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GTMOAuth2ViewControllerTouch.h"


@interface ViewController : UIViewController
- (IBAction)loginAction:(id)sender;
- (IBAction)loadContactsAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end