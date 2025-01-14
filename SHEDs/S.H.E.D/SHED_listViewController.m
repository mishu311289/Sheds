//
//  SHED_listViewController.m
//  S.H.E.D
//
//  Created by Krishna_Mac on 12/3/13.
//  Copyright (c) 2013 Krishna_Mac. All rights reserved.
//

#import "SHED_listViewController.h"
#import "SHED.h"
#import "shed_data.h"
#import "habitstatisticsViewController.h"
#import "homescreenViewController.h"
#import <QuartzCore/QuartzCore.h> 
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>
#import "FMDatabaseAdditions.h"
#define kOFFSET_FOR_KEYBOARD 160.0

@interface SHED_listViewController ()
{
    FBSession *session;
}
@end

@implementation SHED_listViewController
@synthesize databasePath,shed_list,IDlbl, tickbtn, crossbtn,habitstats_list,list_table,followeddate,size,footer,header,sub_header,titlelbl,gratitudetxt,gratitudelbl,shed,habit,queryString,flag,gratitudeoc,postbtn,gratTitle,shedlist,coronological,alphabetical,sortingString,appDelegate,date_array,str,value,backlbl,indexList,data3,totaldaysSelected,shedname;

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
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.navigator.navigationBarHidden = YES;
    
    session=[[FBSession alloc]init];
    header.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"header-bg.png"]];
    sub_header.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"sub-header.png"]];
    footer.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"footer.png"]];
    
    
    
    list_table.delegate = self;
    list_table.dataSource = self;
    
    shed_list = [[NSMutableArray alloc] init];
    //AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    
    if (flag == 0) {
        titlelbl.text = @"Today's SHEDs";
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            list_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, 298)];
            [titlelbl setFont: [UIFont fontWithName:@"Helvetica Neue" size:28]];

            //this is iphone 5 xib
        }
        else if([[UIScreen mainScreen] bounds].size.height == 480) {
            list_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, 218)];
            [titlelbl setFont: [UIFont fontWithName:@"Helvetica Neue" size:28]];

            // this is iphone 4 xib
        }
        else{
            list_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, 768, 515)];
            [titlelbl setFont: [UIFont fontWithName:@"Helvetica Neue" size:65]];
            // this is ipad xib


        }
    }
    else if (flag == 1){
            titlelbl.text = @"Current SHEDs";
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            list_table = [[UITableView alloc] initWithFrame:CGRectMake(0,100, 320, 415)];
            [titlelbl setFont: [UIFont fontWithName:@"Helvetica Neue" size:28]];

            
            //this is iphone 5 xib
        }
        else if([[UIScreen mainScreen] bounds].size.height == 480) {
            list_table = [[UITableView alloc] initWithFrame:CGRectMake(0,100, 320, 315)];
            [titlelbl setFont: [UIFont fontWithName:@"Helvetica Neue" size:28]];

            
            // this is iphone 4 xib
        }
        else{
            list_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, 768, 640)];
            [titlelbl setFont: [UIFont fontWithName:@"Helvetica Neue" size:65]];

            // this is ipad xib

        }
            // if you have other controls that should be resized/moved to accommodate
            // the resized tableview, do that here, too
        
    }
    
    
    list_table.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    list_table.delegate = self;
    list_table.dataSource = self;
    list_table.separatorColor = [UIColor clearColor];
    [self.view addSubview:list_table];
    postbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        gratitudetxt = [[UITextView alloc] initWithFrame:CGRectMake(5, 425, 310, 45)];
        postbtn.frame = CGRectMake(190, 476, 125, 30);
        gratTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 397, 320, 28)];
        backlbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 397, 320, 115)];
        [gratTitle setFont:[UIFont fontWithName:@"Lucida Sans" size:17]];

        //this is iphone 5 xib
    }
    else if([[UIScreen mainScreen] bounds].size.height == 480) {
        gratitudetxt = [[UITextView alloc] initWithFrame:CGRectMake(5, 343, 310, 45)];
        postbtn.frame = CGRectMake(190, 393, 125, 30);
        gratTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 317, 320, 27)];
        backlbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 317, 320, 70)];
        [gratTitle setFont:[UIFont fontWithName:@"Lucida Sans" size:17]];

        // this is iphone 4 xib
    }
    else{
        gratitudetxt = [[UITextView alloc] initWithFrame:CGRectMake(15, 783, 730, 60)];
        postbtn.frame = CGRectMake(533, 853, 207, 45);
        gratTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 740, 758, 35)];
        backlbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 740, 758, 165)];
        [gratTitle setFont:[UIFont fontWithName:@"Lucida Sans" size:30]];
        // this is ipad xib

    }

    backlbl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backlbl];
    
    gratitudetxt.textAlignment = NSTextAlignmentLeft;
    [gratitudetxt setDelegate:self];
    [[gratitudetxt layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[gratitudetxt layer] setBorderWidth:2.0];
    [[gratitudetxt layer] setCornerRadius:5];
    [gratitudetxt setFont: [UIFont fontWithName:@"Helvetica Neue" size:17]];
    [self.view addSubview:gratitudetxt];

    [postbtn addTarget:self action:@selector(postgratitude:) forControlEvents:UIControlEventTouchUpInside];
    [postbtn setBackgroundImage:[UIImage imageNamed:@"postGratitude-icon.png"]forState:UIControlStateNormal];
    [self.view addSubview:postbtn];
    
    gratTitle.backgroundColor = [UIColor whiteColor];
    gratTitle.text = @" Today I am grateful for....";

    [self.view addSubview:gratTitle] ;
    
    
    if (flag == 1){
        
        postbtn.hidden = YES;
        gratitudetxt.hidden = YES;
        gratTitle.hidden =YES;
        backlbl.hidden = YES;
        // if you have other controls that should be resized/moved to accommodate
        // the resized tableview, do that here, too
        
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date2 =[dateFormatter dateFromString:appDelegate.todaysDate];
    
    NSDateFormatter *dateformatter1 = [[NSDateFormatter alloc]init];
    [dateformatter1 setDateFormat:@"EEEE"];
    
    NSString *str3 = [dateformatter1 stringFromDate:date2];
    NSString *str4 = [str3 stringByAppendingString:@"%"];
    NSLog(@"%%%@", str4);
//    gratitudelbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, 15)];
//    [gratitudelbl setFont:[UIFont fontWithName:@"Lucida Sans" size:10]];
//    //gratitudelbl.text =  @"Please type here.....";
//    [gratitudetxt addSubview:gratitudelbl];
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Fetchin the Thoughts from the table ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    NSString *masteredStr = [[NSString alloc] initWithFormat:@"NO"];
    if (flag == 1) {
        queryString = [NSString stringWithFormat:@"Select * FROM SHED where isMastered = \"%@\"",masteredStr];
    }
    else if (flag == 0)
    {
        queryString = [NSString stringWithFormat:@"Select * FROM SHED where isMastered = \'%@\' and alarm_days LIKE \'%%%@\'",masteredStr, str4];
    }
    
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"shed_db.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    NSLog(@"query %@", queryString);
    NSLog(@"path : %@", dbPath);
    [database open];
    NSLog(@"query %@", queryString);
    FMResultSet *results = [database executeQuery:queryString];
    
    while([results next]) {
        shed	= [[SHED alloc] init];
        shed.shed_id = [results stringForColumn:@"shed_id"];
        shed.name = [results stringForColumn:@"name"];
        shed.description = [results stringForColumn:@"description"];
        shed.alarm_time = [results stringForColumn:@"alarm_time"];
        shed.alarm_status = [results stringForColumn:@"alarm_status"];
        shed.start_date = [results stringForColumn:@"start_date"];
        shed.alarm_days = [results stringForColumn:@"alarm_days"];
        shed.isBeingFollowedToday = NO;
        
        NSLog(@"alarm Days ::%@", shed.alarm_days);
        
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date2 = [formatter dateFromString:appDelegate.todaysDate];
        NSString* todaysdate = [formatter stringFromDate:date2];
        NSLog(@"My Date %@", todaysdate);
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSDate *startDate = [format dateFromString:shed.start_date];
        
        NSString *dateQuery = [NSString stringWithFormat:@"Select followed_date from Shed_Data where id = \"%d\"",[shed.shed_id intValue]];
        
        FMResultSet *dateSet = [database executeQuery:dateQuery];
        followeddate = [[NSMutableArray alloc]init];
        while([dateSet next]) {
            NSString *tempStr = [dateSet stringForColumn:@"followed_date"];
            [followeddate addObject:tempStr];
            
            if([todaysdate isEqualToString:tempStr])
                shed.isBeingFollowedToday = YES;
            
        }
        shed.datesArray = followeddate;
        shed.applieddays = [followeddate count];
        
       
        
        NSDate *endDate = [format dateFromString:todaysdate];
        
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *totaldays = [gregorianCalendar components:NSDayCalendarUnit
                                                           fromDate:startDate
                                                             toDate:endDate
                                                            options:0];
        totaldaysSelected = [totaldays day];
        
        //if(shed.totaldays==0)
            totaldaysSelected +=1;
        int TotalDaysCounted = 0;
        
        NSString *daysString = [NSString stringWithFormat:@"%@",shed.alarm_days];
        NSLog(@"Days To add %@", daysString);
        
        NSArray *daysstr = [shed.alarm_days componentsSeparatedByString:@","];
        
        NSLog(@"Selected Days Name: %@", daysstr);
        
        
        data3 = [[NSMutableArray alloc]init];
        
        int i;
        for (i = 0; i < [daysstr count]; i++) {
            NSString* myArrayElement = [daysstr objectAtIndex:i];
            int index = [self getindex:myArrayElement];
            
            int occurence = [self cal:totaldaysSelected :startDate :index];
            TotalDaysCounted += occurence;
        }
        
        shed.totaldays = TotalDaysCounted;
        
        if(shed.totaldays==0)
            shed.percentage = 0;
        else

            shed.percentage = ((float)shed.applieddays/(float)shed.totaldays)*100;
        
        if(shed.totaldays == 1 && shed.applieddays == 0)
            shed.percentage = 50;
        
        NSLog(@"Applied Days of the shed %d",shed.applieddays);
        NSLog(@"Total days of the shed %d",shed.totaldays);
        NSLog(@"percetage of the shed %f",shed.percentage);
 
        [shed_list addObject:shed];
        
        
    }
    if([sortingString isEqualToString:@"Cronological"])
    {
        [coronological setBackgroundImage:[UIImage imageNamed:@"tab-1.png"] forState:UIControlStateNormal];
    NSSortDescriptor *firstNameSort = [NSSortDescriptor sortDescriptorWithKey:@"start_date"
                                                                    ascending:YES
                                                                     selector:@selector(localizedStandardCompare:)];
     shedlist = [self.shed_list sortedArrayUsingDescriptors:@[firstNameSort]];
    NSLog(@"Sorted by first name: %@", shedlist);
    }
    else if([sortingString isEqualToString:@"Alphabetical"]){
        [alphabetical setBackgroundImage:[UIImage imageNamed:@"tab-1.png"] forState:UIControlStateNormal];
        NSSortDescriptor *firstNameSort = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                        ascending:YES
                                                                         selector:@selector(localizedStandardCompare:)];
        shedlist = [self.shed_list sortedArrayUsingDescriptors:@[firstNameSort]];
        NSLog(@"Sorted by first name: %@", shedlist);
    }
    [database close];
    //[self scheduleNotificationForDate];
//    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init] ;
//    [formatter1 setDateFormat:@"yyyy-MM-dd"];
//    
//    NSDate *date7 =[formatter1 dateFromString:appDelegate.todaysDate];
//    NSString* todaydate = [formatter1 stringFromDate:date7];
//    value = [NSUserDefaults standardUserDefaults];
//    str = [value objectForKey:@"Date"];
//    if ([str isEqualToString: todaydate])
//    {
//        [postbtn setBackgroundImage:[UIImage imageNamed:@"postGratitude-icon grey.png"]forState:UIControlStateNormal];
//         postbtn.userInteractionEnabled = NO;
//    }
//    else
//    {
//        //postbtn.userInteractionEnabled = NO;
//    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [shedlist count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480)){

        return 55.0;
    }else{
        return 87.0;
    }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index row %ld", (long)indexPath.row);
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480)){
        shedname = [[UILabel alloc] initWithFrame:CGRectMake(55, 4, 180, 50)];
        [shedname setFont:[UIFont fontWithName:@"Lucida Sans" size:15]];
        shedname.lineBreakMode = NSLineBreakByWordWrapping;

    }
    else{
        
        if (flag==0)
        {
             shedname = [[UILabel alloc] initWithFrame:CGRectMake(105,2,460, 80)];
        }
        else if (flag==1)
        {
             shedname = [[UILabel alloc] initWithFrame:CGRectMake(105, 2,570, 80)];
        }
       
        [shedname setFont:[UIFont fontWithName:@"Lucida Sans" size:30]];
    }
    
    
        shedname.numberOfLines = 2;
        shedname.textAlignment = NSTextAlignmentLeft;
        [cell addSubview:shedname] ;
    
    
    shed = [shedlist objectAtIndex:indexPath.row];
   shedname.text = shed.name;
 //   cell.textLabel.text=shed.name;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *gratimgup;
    UIImageView *img ;
    tickbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    crossbtn = [UIButton buttonWithType:UIButtonTypeCustom];

    if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480)){
        [cell.textLabel setFont:[UIFont fontWithName:@"Lucida Sans" size:20]];
        img = [[UIImageView alloc] initWithFrame:CGRectMake(13, 10, 34, 34)];
        gratimgup = [[UIImageView alloc] initWithFrame:CGRectMake(305, 18, 8, 15)];
        tickbtn.frame = CGRectMake(240, 11, 28, 28);
        crossbtn.frame = CGRectMake(270, 11, 28, 28);

        //this is iphone 5 xib
    }
    else{
        [cell.textLabel setFont:[UIFont fontWithName:@"Lucida Sans" size:30]];
        img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 65, 65)];
        gratimgup = [[UIImageView alloc] initWithFrame:CGRectMake(723, 30, 16, 27)];
        tickbtn.frame = CGRectMake(590, 15, 56, 50);
        crossbtn.frame = CGRectMake(650, 15, 56, 50);
        //this is ipad xib
    }

    gratimgup.image = [UIImage imageNamed:@"arrow.png"];
    gratimgup.hidden = NO;
    [cell.contentView addSubview:gratimgup];
    
    tickbtn.tag = 200+indexPath.row;
    [tickbtn addTarget:self action:@selector(addshed:) forControlEvents:UIControlEventTouchUpInside];
    
    crossbtn.tag = 400+indexPath.row;
    [crossbtn addTarget:self action:@selector(removeshed:) forControlEvents:UIControlEventTouchUpInside];
    
    if(shed.isBeingFollowedToday){
        [tickbtn setBackgroundImage:[UIImage imageNamed:@"ok_green.png"]forState:UIControlStateNormal];
        [crossbtn setBackgroundImage:[UIImage imageNamed:@"delete-gray.png"]forState:UIControlStateNormal];
    }
    else
    {
        [tickbtn setBackgroundImage:[UIImage imageNamed:@"ok_gray.png"]forState:UIControlStateNormal];
        [crossbtn setBackgroundImage:[UIImage imageNamed:@"delete-red.png"]forState:UIControlStateNormal];
    }
    
    
    

   // UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(13, 10, 34, 34)];
    NSLog(@"Percentage of SHED %f", shed.percentage);

    if (shed.percentage <= 49) {
        img.image = [UIImage imageNamed:@"sad-smiley.png"];
        [cell addSubview:img];
    }
    else if (shed.percentage > 49 && shed.percentage <=80)
    {
        img.image = [UIImage imageNamed:@"neutral-smiley.png"];
        [cell addSubview:img];
    }
    else if (shed.percentage > 80 )
    {
        img.image = [UIImage imageNamed:@"happy-smiley.png"];
        [cell addSubview:img];
    }
    
    
    
    cell.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"list-bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    if (flag == 0) {
    [cell.contentView addSubview:tickbtn];
    NSLog(@"tickbtn tag %ld",(long)tickbtn.tag);
   
    [cell.contentView addSubview:crossbtn];
    NSLog(@"tickbtn tag %ld",(long)crossbtn.tag);
    }
    else if(flag == 1) {
        
    }
    return cell;
}
-(IBAction)addshed:(UIControl *)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag-200 inSection:0];
    NSLog(@"indexrow %ld", (long)indexPath.row);
    
    UITableViewCell *cell = (UITableViewCell*)[list_table cellForRowAtIndexPath:indexPath];
    UIButton *check1 = (UIButton*)[cell.contentView viewWithTag:indexPath.row+200];
    UIButton *check2 = (UIButton*)[cell.contentView viewWithTag:indexPath.row+400];
    UIImageView *btnimg1 = [[UIImageView alloc] initWithImage:check1.currentBackgroundImage];
    //UIImageView *btnimg2 = [[UIImageView alloc] initWithImage:check2.currentBackgroundImage];
    NSLog(@"SHED LIST subviews: %@", btnimg1.image);
    // Shed_data *sheddata	= [[Shed_data alloc] init];
    if (btnimg1.image == [UIImage imageNamed:@"ok_gray.png"]) {
        //btnimg.image = [UIImage imageNamed:@"ok_gray.png"];
        [check1 setBackgroundImage:[UIImage imageNamed:@"ok_green.png"]forState:UIControlStateNormal];
        [check2 setBackgroundImage:[UIImage imageNamed:@"delete-gray.png"]forState:UIControlStateNormal];
        
        [self addsheddata:sender];
        
        NSLog(@"tickbtn tag %ld",(long)check1.tag);
    }
    else if (btnimg1.image == [UIImage imageNamed:@"ok_green.png"])
    {
        [check2 setEnabled:NO];
        NSLog(@"it is green");
    }
    [self viewDidLoad];
}
-(IBAction)removeshed:(UIControl*)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag-400 inSection:0];
    NSLog(@"remove indexrow %ld", (long)indexPath.row);
    
    
    UITableViewCell *cell = (UITableViewCell*)[list_table cellForRowAtIndexPath:indexPath];
    UIButton *check1 = (UIButton*)[cell.contentView viewWithTag:indexPath.row+200];
    UIButton *check2 = (UIButton*)[cell.contentView viewWithTag:indexPath.row+400];
//  UIImageView *btnimg1 = [[UIImageView alloc] initWithImage:check1.currentBackgroundImage];
    UIImageView *btnimg2 = [[UIImageView alloc] initWithImage:check2.currentBackgroundImage];
    //NSLog(@"SHED LIST REMOVE subviews: %@", btnimg1.image);
    // Shed_data *sheddata	= [[Shed_data alloc] init];
    if (btnimg2.image == [UIImage imageNamed:@"delete-gray.png"]) {
        //btnimg.image = [UIImage imageNamed:@"ok_gray.png"];
        [check1 setBackgroundImage:[UIImage imageNamed:@"ok_gray.png"]forState:UIControlStateNormal];
        [check2 setBackgroundImage:[UIImage imageNamed:@"delete-red.png"]forState:UIControlStateNormal];
        
        [self removesheddata:sender];
        
        NSLog(@"tickbtn tag %ld",(long)check2.tag);
    }
    else if (btnimg2.image == [UIImage imageNamed:@"delete-red.png"])
    {
        [check2 setEnabled:NO];
        NSLog(@"it is red");
    }
    [self viewDidLoad];
}

-(void)addsheddata:(UIControl *)sender{
    
    //[tickbtn setBackgroundImage:[UIImage imageNamed:@"ok_gray.png"]forState:UIControlStateNormal];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag-200 inSection:0];
    // UITableViewCell *cell = (UITableViewCell*)[list_table cellForRowAtIndexPath:indexPath];
    
    shed =[shedlist objectAtIndex:indexPath.row];
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
     NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"shed_db.sqlite"];
    //SHEDLIST *info = [shed_list objectAtIndex:path.row];
    // NSLog(@"DATE %@", info.SHED_ID);
    NSLog(@"SHED DATA in SHED_LIST %@", shed.shed_id);
    NSString *ShedID = [[NSString alloc] initWithFormat:shed.shed_id];
    NSLog(@"SHED ID %@", ShedID );
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *queryString = [NSString stringWithFormat:@"select id,followed_date, current_run from Shed_Data Group By id Having followed_date = Max(followed_date) And id = \"%@\"",ShedID];
    FMResultSet *results = [database executeQuery:queryString];
    NSLog(@"FOLLOWED DATE %@", results);
    [self calRuns];
    

    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag == 1)
        {
            for(UILocalNotification *notify in [[UIApplication sharedApplication] scheduledLocalNotifications])
            {
                if ([notify.alertBody isEqualToString:shed.name]) {
                    NSLog(@"the notification this is canceld is %@", notify.alertBody);
                    
                    [[UIApplication sharedApplication] cancelLocalNotification:notify] ; // delete the notification from the system
                }
            }
            
            NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDir = [docPaths objectAtIndex:0];
            NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"shed_db.sqlite"];
            NSString *isMastered = [[NSString alloc] initWithFormat:@"YES"];
            FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
            [database open];
            NSString *insertSQL = [NSString stringWithFormat:@"UPDATE SHED SET isMastered = \"%@\" , masteredDate = \"%@\" where shed_id = \"%@\"", isMastered ,appDelegate.todaysDate, shed.shed_id];
            [database executeUpdate:insertSQL];
            [database close];
            
            [self viewDidLoad];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congrats!!!" message:@"Your SHED has been transferred to Mastered SHEDs successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    
    else if (buttonIndex == 0 && alertView.tag == 2){
     //   gratitudetxt.text=@"";
        [self.gratitudetxt resignFirstResponder];
    }
}

-(void)removesheddata:(UIControl *)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag-400 inSection:0];
    //UITableViewCell *cell = (UITableViewCell*)[list_table cellForRowAtIndexPath:indexPath];
    shed =[shedlist objectAtIndex:indexPath.row];
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"shed_db.sqlite"];
    int shedid = [shed.shed_id intValue];
    NSLog(@"shed id of deleting shed is %d",shedid);
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *deleteQuery = [NSString stringWithFormat:@"DELETE FROM Shed_Data WHERE followed_date = \"%@\" and id = \"%d\"",appDelegate.todaysDate,shedid] ;
   
    shed.isBeingFollowedToday = NO;
    shed.applieddays -=1;
    [database executeUpdate:deleteQuery];
    [database close];
    NSLog(@"SHED REMOVED");
    
    
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    habitstatisticsViewController *habitstat;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        habitstat = [[habitstatisticsViewController alloc]initWithNibName:@"habitstatisticsViewController" bundle:Nil];
        //this is iphone 5 xib
    } else if ([[UIScreen mainScreen] bounds].size.height == 480) {

        habitstat = [[habitstatisticsViewController alloc]initWithNibName:@"habitstatisticsViewController_iphone4" bundle:Nil];
        // this is iphone 4 xib
    }
    else{
        habitstat = [[habitstatisticsViewController alloc]initWithNibName:@"habitstatisticsViewController_ipad" bundle:Nil];
        // this is ipad xib

    }
    habitstat.flag = flag;
    habitstat.tabstring = sortingString;
    habitstat.shed = [shedlist objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:habitstat animated:YES];
    
}



- (IBAction)header_back:(id)sender {
    homescreenViewController *home;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        home = [[homescreenViewController alloc] initWithNibName:@"homescreenViewController" bundle:nil];
        //this is iphone 5 xib
    }
    else if([[UIScreen mainScreen] bounds].size.height == 480) {
        home = [[homescreenViewController alloc] initWithNibName:@"homescreenViewController_iphone4" bundle:nil];
        // this is iphone 4 xib
    }
    else{
        home = [[homescreenViewController alloc] initWithNibName:@"homescreenViewController_ipad" bundle:nil];
        // this is ipad xib
    }
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    
    home.idstr = shed.shed_id;
    [self.navigationController pushViewController:home animated:NO];
}
//#define kOFFSET_FOR_KEYBOARD 80.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    self.gratitudelbl.hidden = YES;
    if ([sender isEqual:backlbl])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (IBAction)postgratitude:(id)sender
{
    [self.gratitudetxt resignFirstResponder];
//    NSString *queryString1 = [NSString stringWithFormat:@"select * from Gratitude order by gratitude_date desc LIMIT 15"];
//    
//    NSArray *docPaths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDir1 = [docPaths1 objectAtIndex:0];
//    NSString *dbPath1 = [documentsDir1   stringByAppendingPathComponent:@"shed_db.sqlite"];
//    
//    FMDatabase *database1 = [FMDatabase databaseWithPath:dbPath1];
//    NSLog(@"query %@", queryString1);
//    NSLog(@"path : %@", dbPath1);
//    [database1 open];
//    NSLog(@"query %@", queryString1);
//    FMResultSet *results1 = [database1 executeQuery:queryString1];
//    
//    NSMutableArray *date_array=[[NSMutableArray alloc]init];
//    
//    while([results1 next]) {
//        NSLog(@"I AM HERE");
//        gratitudeoc	= [[Gratitude alloc] init];
//        gratitudeoc.gratitudedate = [results1 stringForColumn:@"gratitude_date" ];
//        NSLog(@"%@",[results1 stringForColumn:@"gratitude_date" ]);
//        [date_array addObject:gratitudeoc.gratitudedate];
//        NSLog(@"grat date :: %@", gratitudeoc.gratitudedate);
//    }
//    
//    NSLog(@"date array %@",date_array);
//    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init] ;
//    [formatter1 setDateFormat:@"yyyy-MM-dd"];
//    
//    NSDate *date2 =[formatter1 dateFromString:appDelegate.todaysDate];
//    NSString* todaydate = [formatter1 stringFromDate:date2];
//    NSLog(@"My Date %@", todaydate);
//    
//    [database1 close];
    
    int textLength = [gratitudetxt.text length];
    if(textLength<1)
    {
        UIAlertView *savealert = [[UIAlertView alloc] initWithTitle:@" SHEDs"  message:@"Please enter the gratitude's description" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [savealert show];
    }
    else
    {
        [self gratPopup];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSLog(@"user editing");
    if([text isEqualToString:@"\n"]) {
        [gratitudetxt resignFirstResponder];
        return NO;
    }
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSUserDefaults * value = [NSUserDefaults standardUserDefaults];
    NSString *myString = [value objectForKey:@"gratitudeDate"];
    
    if(myString==nil)
        myString=@"";
    
    if ([myString isEqualToString:appDelegate.todaysDate]) {
        int textLength = [gratitudetxt.text length];
        if(textLength>=0){
            [gratitudetxt resignFirstResponder];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SHEDs" message:@"You've already entered the gratitude for the day." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag =2;
            [alert show];
        }
    }
    
    return YES;
}
//-(void) scheduleNotificationForDate {
//
//           UILocalNotification *localNotif = [[UILocalNotification alloc] init];
//        
//        if (localNotif == nil)
//            return;
//        
//        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//        
//       
//        NSDateComponents *dateParts = [[NSDateComponents alloc] init];
//        [dateParts setMonth:01];
//        [dateParts setYear:2014];
//        [dateParts setDay:03];
//        [dateParts setHour:12];
//        [dateParts setMinute:55];
//        [dateParts setSecond:00];
//        
//        NSDate *sDate = [calendar dateFromComponents:dateParts];
//        
//    localNotif.fireDate = sDate;
//    localNotif.timeZone = [NSTimeZone defaultTimeZone];
//    localNotif.repeatInterval = NSWeekdayCalendarUnit;
//    localNotif.alertAction = NSLocalizedString(@"View Details", nil);
//    localNotif.alertBody = @"Add Your Gratitude";
//    localNotif.soundName =UILocalNotificationDefaultSoundName;
//
//    
//        //NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"testId" forKey:@"ID"];
//        // localNotif.userInfo = infoDict;
//        
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
//        NSLog(@"notification started");
//        
//    }


- (IBAction)posttoFacebook:(id)sender {
    appDelegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.facebookConnect=YES;
    [appDelegate facebookIntegration];
    //[appDelegate facebookIntegration];
}

- (IBAction)coronological:(id)sender {
    [coronological setBackgroundImage:[UIImage imageNamed:@"tab-1.png"] forState:UIControlStateNormal];
    [alphabetical setBackgroundImage:[UIImage imageNamed:@"tab-2.png"] forState:UIControlStateNormal];

    sortingString=[NSString stringWithFormat:@"Cronological"];
    [self viewDidLoad];

}


- (IBAction)alphabetical:(id)sender {
    [coronological setBackgroundImage:[UIImage imageNamed:@"tab-2.png"] forState:UIControlStateNormal];
    [alphabetical setBackgroundImage:[UIImage imageNamed:@"tab-1.png"] forState:UIControlStateNormal];
    sortingString=[NSString stringWithFormat:@"Alphabetical"];
    [self viewDidLoad];
}
-(void)disablePost{
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init] ;
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date7 =[formatter1 dateFromString:appDelegate.todaysDate];
    NSString* todaydate = [formatter1 stringFromDate:date7];
    if ([date_array containsObject:todaydate]){
        postbtn.userInteractionEnabled = NO;
        [postbtn setBackgroundImage:[UIImage imageNamed:@"postGratitude-icon grey.png"]forState:UIControlStateNormal];
    }
    else{
        postbtn.userInteractionEnabled = YES;
        [postbtn setBackgroundImage:[UIImage imageNamed:@"postGratitude-icon.png"]forState:UIControlStateNormal];
    }
}
-(IBAction)textViewDidBeginEditing:(UITextView *)textView{
    
  //  [self gratPopup];
}


-(void) gratPopup
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSUserDefaults * value = [NSUserDefaults standardUserDefaults];
    //   [value setObject:valueToSave forKey:@"preferedDate"];
    NSString *myString = [value objectForKey:@"gratitudeDate"];
    
    if(myString==nil)
        myString=@"";
    
    if ([myString isEqualToString:appDelegate.todaysDate]) {
        int textLength = [gratitudetxt.text length];
         //[gratitudetxt resignFirstResponder];
        
        if(textLength>0){
           
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SHEDs" message:@"You've already entered the gratitude for the day." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag =2;
        [alert show];
        }
    }
    else
    {
        [value setObject:appDelegate.todaysDate forKey:@"gratitudeDate"];
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"shed_db.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO Gratitude ( gratitude , gratitude_date) VALUES (\"%@\", \"%@\")",self.gratitudetxt.text,appDelegate.todaysDate];
        
        [database executeUpdate:insertSQL];
        UIAlertView *savealert = [[UIAlertView alloc] initWithTitle:@"Congratulations!!!"  message:@"Your gratitude for the day have been posted successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        self.gratitudetxt.text= @"";
        [savealert show];
        
        [database close];
    }

}
-(void)calRuns
{
    int current_run,index_checked,longest_run;
    shed_data *shed_Data;

    indexList = [[NSMutableArray alloc]init];
    NSLog(@"SHED Alarm Days %@",shed.alarm_days);
     NSLog(@"SHED id %@",shed.shed_id);
    NSString *currentRunQueryString = [NSString stringWithFormat:@"Select * FROM Shed_Data Group By id Having followed_date = Max(followed_date) And id = %@",shed.shed_id];
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"shed_db.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *results = [database executeQuery:currentRunQueryString];
   // NSUInteger count = [database intForQuery:@"SELECT COUNT(*) FROM Shed_Data"];
//    if(![results hasAnotherRow]) {
//        current_run = 1;
//    }else{
    int rowCount =0;
    
    while ([results next]) {
        rowCount++;
        NSArray *daysstr = [shed.alarm_days componentsSeparatedByString:@","];
        
        NSLog(@"Selected Days Name: %@", daysstr);
        
        int i;
        for (i = 0; i < [daysstr count]; i++) {
            NSString* myArrayElement = [daysstr objectAtIndex:i];
            int indexValue = [self getindex:myArrayElement];
        [indexList addObject:[NSNumber numberWithInt:indexValue]];
        }
        NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
        NSArray *descriptors=[NSArray arrayWithObject: descriptor];
        NSArray *reverseOrder=[indexList sortedArrayUsingDescriptors:descriptors];
        NSLog(@"Sorted Array %@",reverseOrder);
        shed_Data = [[shed_data alloc]init];
        shed_Data.followed_date = [results stringForColumn:@"followed_date"];
        shed_Data.current_run = [results intForColumn:@"current_run"];
       
        NSLog(@"Shed Followed Date %@",shed_Data.followed_date);
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *followed_date = [formatter dateFromString:shed_Data.followed_date];

        NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init] ;
        [formatter1 setDateFormat:@"yyyy-MM-dd"];
        NSDate *current_date = [formatter1 dateFromString:appDelegate.todaysDate];
        
        NSCalendar* calender1 = [NSCalendar currentCalendar];
        NSDateComponents* component1 = [calender1 components:NSWeekdayCalendarUnit fromDate:current_date];
        int current_dayindex = [component1 weekday];
        if (current_dayindex == 1) {
            current_dayindex = 7;
        }else{
            current_dayindex = current_dayindex -1;
        }
        
        NSCalendar* calender = [NSCalendar currentCalendar];
        NSDateComponents* component = [calender components:NSWeekdayCalendarUnit fromDate:followed_date];
        int followed_dayindex = [component weekday];
        
        if (followed_dayindex == 1) {
            followed_dayindex = 7;
        }else{
            followed_dayindex = followed_dayindex -1;
        }

        NSNumber *num=[NSNumber numberWithInteger:current_dayindex];
        NSInteger anIndex=[indexList indexOfObject:num];
        
        int value_to_be_checked=0;
        
        index_checked = anIndex - 1 ;
        if(index_checked<0){
            if([indexList count]==1){
                index_checked = 0;
            }else{
                int count = [indexList count];
                index_checked = count - 1;
            }
        }
            NSNumber *temp = [indexList objectAtIndex:index_checked];
            value_to_be_checked = [temp intValue];
        
            if (value_to_be_checked == followed_dayindex) {
                                    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                    NSDateComponents *totaldays = [gregorianCalendar components:NSDayCalendarUnit
                                                                       fromDate:followed_date
                                                                         toDate:current_date
                                                                        options:0];
                    NSLog(@"Number of days %ld", (long)[totaldays day]);
                    int days_difference = [totaldays day];
                    if (days_difference <= 7) {
                        current_run =shed_Data.current_run +1 ;
                    }else{
                        current_run = 1;
                    }
            }else{
                current_run = 1;
            }
    }
    
    if(rowCount<1){
        current_run = 1;
    }
    
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO Shed_Data ( id, followed_date,current_run ) VALUES (\"%@\", \"%@\", \"%d\")",shed.shed_id,appDelegate.todaysDate,current_run];
        
        shed.isBeingFollowedToday = YES;
        
        [database executeUpdate:insertSQL];
        NSString *currentRunQuery = [NSString stringWithFormat:@"Select current_run FROM Shed_Data Group By id Having current_run = Max(current_run) And id = \"%@\"",shed.shed_id];
        FMResultSet *results1 = [database executeQuery:currentRunQuery];
        
        longest_run = 1;
        
        while([results1 next])  {
            longest_run = [results1 intForColumn:@"current_run"];
        }
    
        NSString *updateQuery = [NSString stringWithFormat:@"Update  Shed_Data SET longest_run = %d  where followed_date = \"%@\"  And id = %@",longest_run, appDelegate.todaysDate, shed.shed_id];
        [database executeUpdate:updateQuery];
        
        shed.applieddays+=1;
        if (shed.applieddays >= 21) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Well done. You have performed the SHED for 21 days" message:@"Do you wish to transfer to Mastered SHEDs?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
            alert.tag =1;
            [alert show];
            
        }
}
-(int) getindex:(NSString*) mystring
{
    if ([mystring isEqualToString:@"Monday"]) {
        NSLog(@"Exact Multiple is Monday");
        return 1;
    }else if ([mystring isEqualToString:@"Tuesday"]) {
        NSLog(@"Exact Multiple is Tuesday");
        return 2;
    }else if ([mystring isEqualToString:@"Wednesday"]) {
        NSLog(@"Exact Multiple is Wednesday");
        return 3;
    }else if ([mystring isEqualToString:@"Thursday"]) {
        NSLog(@"Exact Multiple is Thursday");
        return 4;
    }else if ([mystring isEqualToString:@"Friday"]) {
        NSLog(@"Exact Multiple is Friday");
        return 5;
    }else if ([mystring isEqualToString:@"Saturday"]) {
        NSLog(@"Exact Multiple is Saturday");
        return 6;
    }else {
        NSLog(@"Exact Multiple is Sunday");
        return 7;
    }
}
-(int) cal:(int)totalDays :(NSDate *) startDate :(int) ds
{
    int reminder,start_Index,rem_Index;
    
    int exactMultiple = (totalDays)/7;
    reminder = (totalDays)%7;
    NSCalendar* calender = [NSCalendar currentCalendar];
    NSDateComponents* component = [calender components:NSWeekdayCalendarUnit fromDate:startDate];
    int day = [component weekday];
    day = day - 1;
    
    if(day == 0)
        day = 7;
    
    start_Index = day;
    
    if(reminder>0){
        rem_Index = start_Index + reminder - 7;
        
        if (rem_Index <= 0) {
            rem_Index = rem_Index+7;
            
            
            if(ds==7){
                if(ds < rem_Index) {
                    exactMultiple++;
                }
                
            }else{
                if (ds >= start_Index && ds < rem_Index) {
                    exactMultiple++;
                }
            }
        }else{
            if (ds >= start_Index || ds < rem_Index) {
                exactMultiple++;
            }
        }
        //
        //        if (ds < rem_Index) {
        //            exactMultiple++;
        //        }
    }

    
    NSLog(@"Exact Multiple is %d", exactMultiple);
    return exactMultiple;
    
}
-(NSString*) getDay:(int) index
{
    if (index == 1) {
        return @"Sunday";
    }else if (index == 2) {
        return @"Monday";
    }else if (index == 3) {
        return @"Tuesday";
    }else if (index == 4) {
        return @"Wednesday";
    }else if (index == 5) {
        return @"Thursday";
    }else if (index == 6) {
        return @"Friday";
    }else {
        return @"Saturday";
    }
}

@end
