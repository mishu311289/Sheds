//
//  homescreenViewController.m
//  S.H.E.D
//
//  Created by Krishna_Mac on 11/20/13.
//  Copyright (c) 2013 Krishna_Mac. All rights reserved.
//

#import "homescreenViewController.h"
#import "createahabitViewController.h"
#import "SHED_listViewController.h"
#import "AppDelegate.h"
#import "FMDatabaseAdditions.h"
#import "gratitude_listingViewController.h"
#import "Instructions_listViewController.h"
#import "mastered_shedViewController.h"
#import "setting_shedViewController.h"
#import "SHED.h"

@interface homescreenViewController ()

@end

@implementation homescreenViewController
@synthesize home_title,home_background,home_footer,sub_header,footer,title,addshedbtn,currentshedbtn,masteredshedbtn,gratitudebtn,instructionbtn,settingbtn,idstr,todaysShed;
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
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.navigator.navigationBarHidden = YES;
    appDelegate.navigator.navigationBar.tintColor = [UIColor clearColor];

    if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480)) {
        [title setFont: [UIFont fontWithName:@"Helvetica Neue" size:28]];
        [addshedbtn.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:20]];
        [currentshedbtn.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:20]];
        [masteredshedbtn.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:20]];
        [gratitudebtn.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:20]];
        [instructionbtn.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:20]];
        [settingbtn.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:20]];
        [todaysShed.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:20]];
    }
     else
    {
        [title setFont: [UIFont fontWithName:@"Helvetica Neue" size:85]];
        [addshedbtn.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:40]];
        [currentshedbtn.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:40]];
        [masteredshedbtn.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:40]];
        [gratitudebtn.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:40]];
        [instructionbtn.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:40]];
        [settingbtn.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:40]];
        [todaysShed.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:40]];
    }
    

    
   
//    home_title.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"header-bg.png"]];
//    sub_header.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"sub-header.png"]];
//    footer.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"footer.png"]];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createahabit:(id)sender {
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"shed_db.sqlite"];
   // NSString *masteredStr = [[NSString alloc] initWithFormat:@"NO"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    
    [database open];
    int count = [database intForQuery:@"SELECT COUNT(shed_id) FROM SHED where isMastered ='NO'"];
    NSLog(@"path : %d", count);
    
    if (count == 6) {
        UIAlertView *savealert = [[UIAlertView alloc] initWithTitle:@"SHEDs"  message:@"Limit Reached " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [savealert show];
    }
    else{
        createahabitViewController *createhabit;
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            createhabit = [[createahabitViewController alloc]initWithNibName:@"createahabitViewController" bundle:nil];
            //this is iphone 5 xib
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480) {
            createhabit = [[createahabitViewController alloc]initWithNibName:@"createahabitViewController_iphone4" bundle:nil];
            // this is iphone 4 xib
        }  else
        {
            createhabit = [[createahabitViewController alloc]initWithNibName:@"createahabitViewController_ipad" bundle:nil];
            // this is ipad xib
        }

        
    createhabit.flag = 1;
    [self.navigationController pushViewController:createhabit animated:YES];
    }
}

- (IBAction)deleteahabit:(id)sender {
    SHED_listViewController *shedlist;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        shedlist = [[SHED_listViewController alloc] initWithNibName:@"SHED_listViewController" bundle:nil];
        //this is iphone 5 xib
    }
    else if ([[UIScreen mainScreen] bounds].size.height == 480) {
         shedlist = [[SHED_listViewController alloc] initWithNibName:@"SHED_listViewController_iphone4" bundle:nil];
        // this is iphone 4 xib
    }
    else
    {
        shedlist = [[SHED_listViewController alloc] initWithNibName:@"SHED_listViewController_ipad" bundle:nil];
        // this is ipad xib
    }
    
    shedlist.sortingString = [NSString stringWithFormat:@"Cronological"];
    shedlist.flag = 1;
    [self.navigationController pushViewController:shedlist animated:YES];
}

- (IBAction)gratitude:(id)sender {
    gratitude_listingViewController *gratvc;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        gratvc = [[gratitude_listingViewController alloc] initWithNibName:@"gratitude_listingViewController" bundle:Nil];      //this is iphone 5 xib
    }
    else if ([[UIScreen mainScreen] bounds].size.height == 480) {
        gratvc = [[gratitude_listingViewController alloc] initWithNibName:@"gratitude_listingViewController_iphone4" bundle:Nil];            // this is iphone 4 xib
    }
    else
    {
        gratvc = [[gratitude_listingViewController alloc] initWithNibName:@"gratitude_listingViewController_ipad" bundle:Nil];            // this is ipad xib
    }

    [self.navigationController pushViewController:gratvc animated:YES];
}

- (IBAction)masteredhabit:(id)sender {
    //SHED *shed = [[SHED alloc] init];
    NSLog(@"SHED_Name %@",idstr);
    mastered_shedViewController *masteredvc;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        masteredvc = [[mastered_shedViewController alloc] initWithNibName:@"mastered_shedViewController" bundle:Nil];
        //this is iphone 5 xib
    }
    else  if ([[UIScreen mainScreen] bounds].size.height == 480) {
        masteredvc = [[mastered_shedViewController alloc] initWithNibName:@"mastered_shedViewController_iphone4" bundle:Nil];
        // this is iphone 4 xib
    }
    else{
        masteredvc = [[mastered_shedViewController alloc] initWithNibName:@"mastered_shedViewController_ipad" bundle:Nil];
        // this is ipad xib
    }

    masteredvc.strid = idstr;
    [self.navigationController pushViewController:masteredvc animated:YES];
}

- (IBAction)settings:(id)sender {
    setting_shedViewController *settingvc;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        settingvc = [[setting_shedViewController alloc] initWithNibName:@"setting_shedViewController" bundle:Nil];
        //this is iphone 5 xib
    }
    else if ([[UIScreen mainScreen] bounds].size.height == 480) {
   settingvc = [[setting_shedViewController alloc] initWithNibName:@"setting_shedViewController_iphone4" bundle:Nil];
        // this is iphone 4 xib
    } else
    {
        settingvc = [[setting_shedViewController alloc] initWithNibName:@"setting_shedViewController_ipad" bundle:Nil];
        // this is ipad xib
    }
    [self.navigationController pushViewController:settingvc animated:YES];

}

- (IBAction)delete:(id)sender {
}
#pragma mark -
#pragma mark Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}
- (IBAction)instruction:(id)sender {
    Instructions_listViewController *instructionvc;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        instructionvc = [[Instructions_listViewController alloc] initWithNibName:@"Instructions_listViewController" bundle:Nil];
        //this is iphone 5 xib
    }
    else if ([[UIScreen mainScreen] bounds].size.height == 480) {
        instructionvc = [[Instructions_listViewController alloc] initWithNibName:@"Instructions_listViewController_iphone4" bundle:Nil];        // this is iphone 4 xib
    }
    else
    {
        instructionvc = [[Instructions_listViewController alloc] initWithNibName:@"Instructions_listViewController_ipad" bundle:Nil];
        // this is ipad xib
    }
    [self.navigationController pushViewController:instructionvc animated:YES];
}

- (IBAction)todays_shed:(id)sender {
    SHED_listViewController *shedlist;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        shedlist = [[SHED_listViewController alloc] initWithNibName:@"SHED_listViewController" bundle:nil];
        //this is iphone 5 xib
    }
    else if ([[UIScreen mainScreen] bounds].size.height == 480) {
        shedlist = [[SHED_listViewController alloc] initWithNibName:@"SHED_listViewController_iphone4" bundle:nil];
        // this is iphone 4 xib
    }
    else
    {
        shedlist = [[SHED_listViewController alloc] initWithNibName:@"SHED_listViewController_ipad" bundle:nil];
            // this is ipad xib
    }
    
    shedlist.sortingString = [NSString stringWithFormat:@"Cronological"];
    shedlist.flag = 0;
    [self.navigationController pushViewController:shedlist animated:YES];
}

@end
