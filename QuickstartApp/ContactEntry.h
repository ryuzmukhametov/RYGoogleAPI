//
//  ContactEntry.h
//  QuickstartApp
//
//  Created by ryuzmukhametov on 16/08/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactEntry : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *imageURL;
@end
