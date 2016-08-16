//
//  ImageLoader.h
//  QuickstartApp
//
//  Created by ryuzmukhametov on 16/08/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "GTMOAuth2ViewControllerTouch.h"

@protocol ImageLoaderDelegate
- (void)didLoadImage;
@end

@interface ImageLoader : NSObject
@property(nonatomic, weak) id<ImageLoaderDelegate> delegate;
@property(nonatomic, strong) NSCache *cache;
@property(nonatomic, weak) GTMOAuth2Authentication *auth;
- (UIImage*)fetchImageURL:(NSString*)imageURL;
@end
