//
//  ImageLoader.m
//  QuickstartApp
//
//  Created by ryuzmukhametov on 16/08/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import "ImageLoader.h"



@implementation ImageLoader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cache = [[NSCache alloc] init];
    }
    return self;
}

- (UIImage*)fetchImageURL:(NSString*)imageURL {
    if (imageURL.length == 0) {
        return nil;
    }
    NSObject *image = [self.cache objectForKey:imageURL];
    if ([image isEqual:[NSNull null]]) {
        return nil;
    }
    if ([image isKindOfClass:[UIImage class]]) {
        return (UIImage*)image;
    }
    
    [self.cache setObject:[NSNull null] forKey:imageURL];
    
    NSURL *url = [NSURL URLWithString:imageURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    __weak typeof(self) welf = self;
    [self.auth authorizeRequest:request
              completionHandler:^(NSError *error) {
                  [welf processLoadedImage:(NSMutableURLRequest*)request imageURL:imageURL error:error];
              }];
    return nil;
}

- (void)processLoadedImage:(NSMutableURLRequest*)request imageURL:(NSString*)imageURL error:(NSError*)error {
    
    if (error) {
        NSLog(@"error %@", error.localizedDescription);
    } else {
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLResponse *response = nil;
            NSError *loadImageError;
            NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&loadImageError];
            
            UIImage *image = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (image != nil) {
                    [self.cache setObject:image forKey:imageURL];
                    [self.delegate didLoadImage];
                }
            });
        });
        
        
        
    }
}

@end
