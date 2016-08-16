//
//  ViewController.m
//  QuickstartApp
//
//  Created by ryuzmukhametov on 16/08/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import "ViewController.h"
#import "ContactTableViewCell.h"
#import "ContactEntry.h"
#import "ContactJSONMapper.h"
#import "ImageLoader.h"

@interface ViewController()<ImageLoaderDelegate>
@property(nonatomic, strong) GTMOAuth2Authentication *auth;
@property(nonatomic, strong) NSArray *entries;
@property(nonatomic, strong) ContactJSONMapper *contactJSONMapper;
@property(nonatomic, strong) ImageLoader *imageLoader;
@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.auth = nil;
    self.contactJSONMapper = [[ContactJSONMapper alloc] init];
    
    self.imageLoader = [[ImageLoader alloc] init];
    self.imageLoader.delegate = self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ContactEntry *entry = self.entries[indexPath.row];
    cell.label.text = entry.title;
    cell.subTitle.text = entry.email;
    cell.imageView1.image = [self.imageLoader fetchImageURL:entry.imageURL];
    return cell;
}

#pragma mark - ImageLoaderDelegate
- (void)didLoadImage {
    [self.tableView reloadData];
}


#pragma mark - Process
- (void)processAuthResponseWithRequest:(NSMutableURLRequest*)request error:(NSError*)error {
    NSString *output = nil;
    if (error) {
        output = [error description];
    } else {
        NSURLResponse *response = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        
        output = [[NSString alloc] initWithData:data
                                       encoding:NSUTF8StringEncoding];
        
        id obj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        self.entries = [self.contactJSONMapper fetchContactsFromJSON:obj];
        [self.tableView reloadData];
    }
    
}




#pragma mark - Aux

- (void)fetchContacts {
    NSString *urlStr = FetchContactsURL;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    __weak typeof(self) welf = self;
    [self.auth authorizeRequest:request
              completionHandler:^(NSError *error) {
                  [welf processAuthResponseWithRequest:(NSMutableURLRequest*)request error:error];
              }];
    
}


// Creates the auth controller for authorizing access to Gmail API.
- (GTMOAuth2ViewControllerTouch *)createAuthController {
    GTMOAuth2ViewControllerTouch *authController;
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    // kGTLAuthScopeGmailReadonly
    NSArray *scopes = [NSArray arrayWithObjects: ContactsScope, nil];
    authController = [[GTMOAuth2ViewControllerTouch alloc]
                      initWithScope:[scopes componentsJoinedByString:@" "]
                      clientID:ClientID
                      clientSecret:nil
                      keychainItemName:KeychainItemName
                      delegate:self
                      finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    return authController;
}

// Handle completion of the authorization process, and update the Gmail API
// with the new credentials.
- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)authResult
                 error:(NSError *)error {
    if (error != nil) {
        [self showAlert:@"Authentication Error" message:error.localizedDescription];
        //self.service.authorizer = nil;
    }
    else {
        self.auth = authResult;
        self.imageLoader.auth = authResult;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// Helper for showing an alert
- (void)showAlert:(NSString *)title message:(NSString *)message {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
     {
         [alert dismissViewControllerAnimated:YES completion:nil];
     }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - IBActions
- (IBAction)loginAction:(id)sender {
    if (self.auth == nil || !self.auth.canAuthorize) {
        [self presentViewController:[self createAuthController] animated:YES completion:nil];
    }
}

- (IBAction)loadContactsAction:(id)sender {
    [self fetchContacts];
}
@end