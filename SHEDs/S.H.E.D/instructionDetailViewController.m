//
//  instructionDetailViewController.m
//  S.H.E.D
//
//  Created by Krishna_Mac_3 on 09/01/14.
//  Copyright (c) 2014 Krishna_Mac. All rights reserved.
//

#import "instructionDetailViewController.h"
#import "Instructions_listViewController.h"
#import "instruction_objectclass.h"
#import "AppDelegate.h"

@interface instructionDetailViewController ()

@end

@implementation instructionDetailViewController
@synthesize instructionDetailTxtView,instDetailLabl,insObjClass;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    instDetailLabl.text=insObjClass;
    if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480)){
        [instDetailLabl setFont: [UIFont fontWithName:@"Helvetica Neue" size:25]];
        instructionDetailTxtView.font =[UIFont fontWithName:@"Lucida Sans" size:18];
    }
    else{
        [instDetailLabl setFont: [UIFont fontWithName:@"Helvetica Neue" size:45]];
        instructionDetailTxtView.font =[UIFont fontWithName:@"Lucida Sans" size:35];
    }

    instructionDetailTxtView.textAlignment = NSTextAlignmentLeft;
    instruction_objectclass*iObjectClas=[[instruction_objectclass alloc]init];
    NSString *queryString = [NSString stringWithFormat:@"Select instruction_detail FROM instruction where instruction_list =\"%@\"",insObjClass];
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"shed_db.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    NSLog(@"query %@", queryString);
    [database open];
    FMResultSet *results = [database executeQuery:queryString];
    NSLog(@"results %@",results);
    
    
    while([results next]) {
        iObjectClas	= [[instruction_objectclass alloc] init];
        iObjectClas.instruction_detail = [results stringForColumn:@"instruction_detail"];
    }
    NSLog(@"list.. %@",iObjectClas.instruction_detail);
    instructionDetailTxtView.text=iObjectClas.instruction_detail;

    [database close];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)BckToList:(id)sender {
    Instructions_listViewController *instList ;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        instList = [[Instructions_listViewController alloc] initWithNibName:@"Instructions_listViewController" bundle:nil];
        //this is iphone 5 xib
    } else if ([[UIScreen mainScreen] bounds].size.height == 480) {

        instList = [[Instructions_listViewController alloc] initWithNibName:@"Instructions_listViewController_iphone4" bundle:nil];
        // this is iphone 4 xib
    }else {
        instList = [[Instructions_listViewController alloc] initWithNibName:@"Instructions_listViewController_ipad" bundle:nil];
        // this is ipad xib
    }
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    [self.navigationController pushViewController:instList animated:NO];

}

- (IBAction)PostToFacebook:(id)sender {
    AppDelegate *appDelegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.facebookConnect=YES;
    [appDelegate facebookIntegration];
}
@end