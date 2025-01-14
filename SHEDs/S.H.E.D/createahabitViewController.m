
//  createahabitViewController.m
//  S.H.E.D
//
//  Created by Krishna_Mac on 11/21/13.
//  Copyright (c) 2013 Krishna_Mac. All rights reserved.
//

#import "createahabitViewController.h"
#import "homescreenViewController.h"
#import "SHED.h"

@interface createahabitViewController ()

@end

@implementation createahabitViewController
@synthesize celltitles,habitstableview,toggleswitch,pickdate,timelbl,dscptxt,habitname,tableview,daystable,daysarray,timetitlelbl, checkedIndexPath,popoverController,df,SHEDlist,databasePath,header,sub_header, footer,actionsheet,model,daysString,checkmark,savebtn,titlelbl,habitnamestr,alarmstatusarray,alarmdaysstr,flag,shedobj,insertSQL,isMasteredstr,result,str,appDelegate,HabittextfeildView,habittextview,donebutton,tempStr,pickrViewIpad,datePickerIpad,pickrTittle;
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
//    habitnamestr = [NSString stringWithFormat:@""];
//    timelblstr= [NSString stringWithFormat:@"5:00"];
//    daysstr = [NSString stringWithFormat:@""];
   
    //[habitname setText:[NSString stringWithFormat:@"PrefilledValue"]];
    
    SHEDlist = [[SHED_listViewController alloc] init];
    appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.navigator.navigationBarHidden = YES;
    appDelegate.navigator.navigationBar.tintColor = [UIColor clearColor];
    
    tempStr = @"";
    
    if (flag == 1) {
        titlelbl.text = @"Add SHEDs";
    }
    else if (flag == 2){
        titlelbl.text = @"Edit SHEDs";
    }
    if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480)) {
        [titlelbl setFont: [UIFont fontWithName:@"Helvetica Neue" size:28]];

    }
    else{
        [titlelbl setFont: [UIFont fontWithName:@"Helvetica Neue" size:65]];

    }
    habitstableview.delegate = self;
    habitstableview.dataSource = self;
    timelbl.hidden = YES;
    //savebtn setBackgroundImage:[UIImage imageNamed:@"save-icon.png"] forState:
    celltitles =[[NSMutableArray alloc] initWithObjects:@"Name",@"",@"Days Applied",@"Select All",@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
    daysarray = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(savedata:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    [self.habitstableview reloadData];
//    
//    NSArray *dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsDir = [dirPath objectAtIndex:0];
//    databasePath = [[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"S.H.E.D_DB"]];
//   
//    NSFileManager *filemgr = [NSFileManager defaultManager];
//    if ([ filemgr fileExistsAtPath: databasePath] == YES) {
//         NSLog(@"path value on createhabit view load : %@", databasePath);
//        const char *dbpath = [databasePath UTF8String];
//        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
//        {
//            char *errMsg;
//            const char *sql_stmt ="CREATE TABLE IF NOT EXISTS SHEDSLIST (SHED_ID INTEGER PRIMARY KEY AUTOINCREMENT ,SHED_Name TEXT ,SHED_Description TEXT, SHED_TIME DATETIME ,SHED_Date DATETIME)";
//        
//        if (sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
//        {
//            NSLog(@"Failed to create table");
//        }
//        else
//        {
//            NSLog(@" created table");
//        }
//        sqlite3_close(contactDB);
//    } else {
//        
//        
//    }
//    }

//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                          action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view from its nib.
}
//-(void)dismissKeyboard {
//    [habitname resignFirstResponder];
//}
- (void)savedata:(id)sender
{
    for(UILocalNotification *notify in [[UIApplication sharedApplication] scheduledLocalNotifications])
    {
        if ([notify.alertBody isEqualToString:self.habitname.currentTitle]) {
            NSLog(@"the notification this is canceld is %@", notify.alertBody);
            
            [[UIApplication sharedApplication] cancelLocalNotification:notify] ;
            // delete the notification from the system
            
        }
        
    }

    //NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"GTM"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    //[dateFormat setTimeZone:timeZone];
    
    //NSString *dateStr = [dateFormat stringFromDate:date2];
     result = [[daysarray valueForKey:@"description"] componentsJoinedByString:@","];

   // NSDate *date = [dateFormat dateFromString:timelbl.text];
    NSLog(@"Todays Date ::::::::::::::: %@",appDelegate.todaysDate);
    

    daysString = [daysarray componentsJoinedByString:@","];
    NSLog(@"Days String :%@",daysString );
    if ([tempStr isEqualToString:@""] || [daysString  isEqual: @""])
    {
        if ([tempStr isEqualToString:@""]) {
            UIAlertView *savealert = [[UIAlertView alloc] initWithTitle:@"SHEDs"  message:@"Please enter SHEDs Description." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [savealert show];
        }
        else if ([daysString  isEqual: @""]){
            UIAlertView *savealert = [[UIAlertView alloc] initWithTitle:@"SHEDs"  message:@"Kindly Select at least one day." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [savealert show];
        }
        
    }
    else
    {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"shed_db.sqlite"];
        isMasteredstr = [[NSString alloc] initWithFormat:@"NO"];
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        UIAlertView *savealert;
        if (flag == 1) {
        insertSQL = [NSString stringWithFormat:@"INSERT INTO SHED ( name,alarm_time,start_date , alarm_status, alarm_days, isMastered) VALUES (\"%@\", \"%@\", \"%@\",\"%hhd\",\"%@\",'%@')",tempStr, self.timelbl.text,appDelegate.todaysDate,self.toggleswitch.on, self.daysString,self.isMasteredstr];
            savealert = [[UIAlertView alloc] initWithTitle:@" Congratulations!!!"  message:@"Your SHED has been created successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        }
        else if (flag == 2)
        {
         insertSQL = [NSString stringWithFormat:@"UPDATE SHED SET name = \"%@\" ,alarm_time = \"%@\" , alarm_status = \"%d\", alarm_days = \"%@\" where shed_id = \"%@\"",tempStr, self.timelbl.text,self.toggleswitch.on, self.daysString, shedobj.shed_id];
            savealert = [[UIAlertView alloc] initWithTitle:@" Congratulations!!!"  message:@"Your SHED has been updated successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        }
        [database executeUpdate:insertSQL];
        
        savealert.tag = 1;
     
        [savealert show];
        
        [database close];
        
    }
    
    if(toggleswitch.on)
    {
        NSLog(@"RESULTS :: %@",self.habitname.currentTitle);
        NSString *str22 = [NSString stringWithFormat:@"%@",self.habitname.currentTitle];
        [self scheduleNotificationForDate:result:self.timelbl.text:str22];
    }
    else
    {
        for(UILocalNotification *notify in [[UIApplication sharedApplication] scheduledLocalNotifications])
        {
            if ([notify.alertBody isEqualToString:self.habitname.currentTitle])
            {
                NSLog(@"the notification this is canceld is %@", notify.alertBody);
                [[UIApplication sharedApplication] cancelLocalNotification:notify] ;
                // delete the notification from the system
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag == 1)
    {
        self.habitname.titleLabel.text = @"";
        self.dscptxt.text = @"";
        homescreenViewController *home;
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            home = [[homescreenViewController alloc] initWithNibName:@"homescreenViewController" bundle:nil];        //this is iphone 5 xib
        }
        else if([[UIScreen mainScreen] bounds].size.height == 480) {
            home = [[homescreenViewController alloc] initWithNibName:@"homescreenViewController_iphone4" bundle:nil];        // this is iphone 4 xib
        }
        else
        {
            home = [[homescreenViewController alloc] initWithNibName:@"homescreenViewController_ipad" bundle:nil];        // this is ipad xib

        }
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [self.navigationController.view.layer addAnimation:transition
                                                    forKey:kCATransition];
        
        [self.navigationController pushViewController:home animated:NO];
    }
    else if (buttonIndex == 0 && alertView.tag == 2)
    {
        [self savedata:nil];
       // Add another action here
    }
    else if (buttonIndex == 1 && alertView.tag == 2)
    {
        homescreenViewController *home;
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            home = [[homescreenViewController alloc] initWithNibName:@"homescreenViewController" bundle:nil];        //this is iphone 5 xib
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480) {

            home = [[homescreenViewController alloc] initWithNibName:@"homescreenViewController_iphone4" bundle:nil];        // this is iphone 4 xib
        }
       
        else
        {
            home = [[homescreenViewController alloc] initWithNibName:@"homescreenViewController_ipad" bundle:nil];
        }
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [self.navigationController.view.layer addAnimation:transition
                                                    forKey:kCATransition];
        
        [self.navigationController pushViewController:home animated:NO];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0)
    {
        return [celltitles count];
    }
    else
    {
        return 7;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        
        cell.textLabel.text = [celltitles objectAtIndex:indexPath.row];
    
        if (indexPath.row == 0)
        {
            NSLog(@"FLAG NALUE %d",flag);
            if ([[UIScreen mainScreen] bounds].size.height == 568) {
                habitname = [[UIButton alloc]initWithFrame:CGRectMake(100, 0, 200, 50)];
                timelbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 240, 50)];
                timetitlelbl = [[UILabel alloc] initWithFrame:CGRectMake(-20, 0, 115, 50)];
                toggleswitch = [[UISwitch alloc] initWithFrame:CGRectMake(250, 10, 50, 60)];
                [timetitlelbl setFont:[UIFont fontWithName:@"Lucida Sans" size:20]];
                cell.textLabel.font = [UIFont fontWithName:@"Lucida Sans" size:20];
                //this is iphone 5 xib
                
            }
            else  if ([[UIScreen mainScreen] bounds].size.height == 480) {
                habitname = [[UIButton alloc]initWithFrame:CGRectMake(100, 0, 200, 40)];
                timelbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 240, 40)];
                timetitlelbl = [[UILabel alloc] initWithFrame:CGRectMake(-20, -1, 115, 40)];
                toggleswitch = [[UISwitch alloc] initWithFrame:CGRectMake(250, 0, 50, 30)];
                [timetitlelbl setFont:[UIFont fontWithName:@"Lucida Sans" size:20]];
                cell.textLabel.font = [UIFont fontWithName:@"Lucida Sans" size:20];

                // this is iphone 4 xib
            }
            else{
                habitname = [[UIButton alloc]initWithFrame:CGRectMake(150, 17, 580, 40)];
                timelbl = [[UILabel alloc] initWithFrame:CGRectMake(500, 8, 240, 50)];
                timetitlelbl = [[UILabel alloc] initWithFrame:CGRectMake(-5, 10, 115, 50)];
                toggleswitch = [[UISwitch alloc] initWithFrame:CGRectMake(690, 15, 70, 50)];
                [timetitlelbl setFont:[UIFont fontWithName:@"Lucida Sans" size:30]];
                [habitname.titleLabel setFont: [UIFont fontWithName:@"Lucida Sans" size:25]];
                cell.textLabel.font = [UIFont fontWithName:@"Lucida Sans" size:30];

                // this is ipad xib

            }
            habitname.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

            [habitname setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [habitname addTarget:self
                          action:@selector(myAction:)
               forControlEvents:UIControlEventTouchUpInside];
            if (flag == 1){
                tempStr = @"";
            [habitname setTitle:@"SHEDs Description" forState:UIControlStateNormal];
            
            }
            else if (flag == 2){
                tempStr = [NSString stringWithFormat:@"%@",shedobj.name];
                
                               NSString *edithabitName;
                
                if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480)){
                    NSString *str1 = [NSString stringWithFormat:@"%@",shedobj.name];
                    NSRange stringRange = {0, MIN([str1 length], 20)};
                    
                    // adjust the range to include dependent chars
                    stringRange = [str1 rangeOfComposedCharacterSequencesForRange:stringRange];
                    
                    // Now you can create the short string
                    NSString *shortString = [str1 substringWithRange:stringRange];

                    if (str1.length <= 20) {
                        edithabitName = [NSString stringWithFormat:@"%@",shortString];
                    }else{
                        edithabitName = [NSString stringWithFormat:@"%@...",shortString];
                    }
                }
                else{
                    NSString *str1 = [NSString stringWithFormat:@"%@",shedobj.name];
                    edithabitName = [NSString stringWithFormat:@"%@...",str1];

                    NSRange stringRange = {0, MIN([str1 length], 35)};
                    
                    // adjust the range to include dependent chars
                    stringRange = [str1 rangeOfComposedCharacterSequencesForRange:stringRange];
                    
                    // Now you can create the short string
                    NSString *shortString = [str1 substringWithRange:stringRange];
                    if (str1.length <= 35) {
                        edithabitName = [NSString stringWithFormat:@"%@",shortString];

                    }
                    else{
                        edithabitName = [NSString stringWithFormat:@"%@...",shortString];

                    }
                }
                
                
                
                [habitname setTitle:edithabitName forState:UIControlStateNormal];
                
                [habitname.titleLabel setTextAlignment: NSTextAlignmentRight];

            NSLog(@"Alarm NAME :-------------- %@",shedobj.name);
            }
            
            
            //habitname = [[UITextField alloc] init];
            
            
            
            
            //cell.textLabel.font = [UIFont fontWithName:@"Lucida Sans" size:20];
            cell.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"list-bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
            [cell addSubview:habitname];
        }
                else if (indexPath.row == 1)
        {
            
            if (flag == 1){
            timelbl.text = @"05:00";
            }
            else if (flag == 2){
            [timelbl setText:shedobj.alarm_time];
                NSLog(@"Alarm Time :-------------- %@",shedobj.alarm_time);
                
            }
            UIFont* boldFont;
            if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480)) {
                 boldFont = [UIFont boldSystemFontOfSize:20];
                cell.textLabel.font = [UIFont fontWithName:@"Lucida Sans" size:20];

            }
            else{
                boldFont = [UIFont boldSystemFontOfSize:30];
                cell.textLabel.font = [UIFont fontWithName:@"Lucida Sans" size:30];

            }
            [timelbl setFont:boldFont];
            timelbl.textColor = [UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1];
            timelbl.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:timelbl];
        
            timetitlelbl.text = @"Alert";
            timetitlelbl.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:timetitlelbl];

            if (flag == 1) {
                toggleswitch.on = NO;
            }
            else if (flag == 2){
                if ([shedobj.alarm_status isEqualToString:@"1"]){
                    toggleswitch.on = YES;
                }
                else{
                    toggleswitch.on= NO;
                }
                NSLog(@"Alarm Status :-------------- %@",shedobj.alarm_status);
                
                NSLog(@"Alarm Days :-------------- %@",alarmstatusarray);
                //NSLog(@"Alarm days :-------------- %@",daysstr);
            }
                
            
             [cell addSubview:toggleswitch];
            cell.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"list-bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
            
            
            
        }
        else if (indexPath.row == 2)
        {
            
            cell.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"list-bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
            if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480)) {

            [cell.textLabel setFont:[UIFont fontWithName:@"Lucida Sans" size:20]];
            }
            else{
                [cell.textLabel setFont:[UIFont fontWithName:@"Lucida Sans" size:30]];
 
            }
        }
    else if (indexPath.row > 2 && indexPath.row <11)
    {
    if(flag == 1)
    {
        //[cell.textLabel setFont:[UIFont boldSystemFontOfSize:16]];
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            checkmark = [[UIImageView alloc] initWithFrame:CGRectMake(280, 10, 20, 20)];
            cell.textLabel.font = [UIFont fontWithName:@"Lucida Sans" size:16];

            //this is iphone 5 xib
            
        }
        else  if ([[UIScreen mainScreen] bounds].size.height == 480) {
            checkmark = [[UIImageView alloc] initWithFrame:CGRectMake(280, 5, 20, 20)];
            cell.textLabel.font = [UIFont fontWithName:@"Lucida Sans" size:16];

            // this is iphone 4 xib
        }
        else{
            checkmark = [[UIImageView alloc] initWithFrame:CGRectMake(700, 13, 39, 40)];
            cell.textLabel.font = [UIFont fontWithName:@"Lucida Sans" size:26];

        }

        checkmark.image = [UIImage imageNamed:@"checkbox.png"];
        [checkmark setTag:indexPath.row];
        NSLog(@"INDEX PATH:::: %ld",(long)indexPath.row);
        cell.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"days-bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
        [cell.contentView addSubview:checkmark];
    }
    else if (flag == 2)
    {
        
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            checkmark = [[UIImageView alloc] initWithFrame:CGRectMake(280, 10, 20, 20)];
            
            //this is iphone 5 xib
            
        } else  if ([[UIScreen mainScreen] bounds].size.height == 480) {
            checkmark = [[UIImageView alloc] initWithFrame:CGRectMake(280, 5, 20, 20)];
            
            // this is iphone 4 xib
        }
        else{
            checkmark = [[UIImageView alloc] initWithFrame:CGRectMake(700, 13, 39, 40)];
  
        }
        checkmark.image = [UIImage imageNamed:@"checkbox.png"];
        [checkmark setTag:indexPath.row];
        cell.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"days-bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
        [cell.contentView addSubview:checkmark];
        NSString *compairString= [NSString stringWithFormat:@"%@",cell.textLabel.text];
        alarmdaysstr = shedobj.alarm_days;
        alarmstatusarray = [alarmdaysstr componentsSeparatedByString:@","];
        NSLog(@"Selected Days Name: %@", alarmstatusarray);
        for (int i = 0; i < [alarmstatusarray count]; i++) {
            NSString *daysName = [alarmstatusarray objectAtIndex:i];
            if ([daysName isEqualToString:compairString] ) {
               checkmark.image = [UIImage imageNamed:@"checkbox-active.png"];
                NSLog(@"Day checked");
                [daysarray addObject:daysName];
            }
            
    }
        if (indexPath.row == 3) {
            if ([alarmstatusarray count]== 7) {
                checkmark.image = [UIImage imageNamed:@"checkbox-active.png"];
            }
        }
    }
        
    }

    
    
    [habitname.titleLabel setTextAlignment: NSTextAlignmentRight];

    return cell;
}
-(IBAction)myAction:(id)sender
{
    pickrViewIpad.hidden=YES;
    savebtn.userInteractionEnabled =NO;
    [[HabittextfeildView layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[HabittextfeildView layer] setBorderWidth:1.0];
    [[HabittextfeildView layer] setCornerRadius:5];
      HabittextfeildView.hidden = NO;
    
    [[habittextview layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[habittextview layer] setBorderWidth:1.0];
    [[habittextview layer] setCornerRadius:5];
    
    [habittextview becomeFirstResponder];
    [habittextview setDelegate:self];
    
    if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480))
    {
        [habittextview setFont:[UIFont fontWithName:@"Lucida Sans" size:20]];
    }
    else
    {
        [habittextview setFont:[UIFont fontWithName:@"Lucida Sans" size:30]];
    }
    [[donebutton layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[donebutton layer] setBorderWidth:1.0];
    [[donebutton layer] setCornerRadius:5];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != 0) {
        [habitname resignFirstResponder];
        [habittextview resignFirstResponder];
    }
        if (indexPath.row == 1)
        {
            if (toggleswitch.on)
            {
                NSString *timestring = [[NSString alloc] initWithFormat:timelbl.text];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"HH:mm"];
                [dateFormat setTimeZone:[NSTimeZone systemTimeZone]];
                //NSString *dateStr = [dateFormat stringFromDate:date2];
                NSDate *date1 = [dateFormat dateFromString:timestring];
                NSLog(@"THE TIME IS FROM THE LABEL: %@",timestring);
//                NSDate *yourDate = [[NSDate alloc] init];
//                yourDate = [timeFormat dateFromString:titlelbl.text];
                NSLog(@"YOUR DATE: %@", date1);
                
                if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480)) {
                      [self showPicker:date1];
                }
                else{
                    
                    self.pickrViewIpad.hidden = NO;
                    HabittextfeildView.hidden=YES;
                    datePickerIpad.datePickerMode = UIDatePickerModeTime;
                    [datePickerIpad addTarget:self action:@selector(changeDateInLabel:) forControlEvents:UIControlEventValueChanged];
                    [datePickerIpad setDate:date1 animated: YES];
                }
              
                
                if (self.datePickerIsShowing)
                {
                    //[self datepickershown];
                    //[self hideDatePickerCell];
                    [habitname resignFirstResponder];
                }
                else
                {
                    [habitname resignFirstResponder];
                    [self.timelbl resignFirstResponder];
                    [self showDatePickerCell];
                }
            }
            else
            {
            timelbl.textColor = [UIColor grayColor];
            }
        }
    else if (indexPath.row == 3)
    {
        self.pickrViewIpad.hidden=YES;
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
        UIImageView *check = (UIImageView*)[cell.contentView viewWithTag:3];
        if (check.image == [UIImage imageNamed:@"checkbox-active.png"])
        {
            check.image = [UIImage imageNamed:@"checkbox.png"];
            NSLog(@"HELLO");
            for (int i = 4; i < 11; i++) {
                NSLog(@"I am Selectin the row %d", i);
                NSIndexPath *path1 = [NSIndexPath indexPathForRow:i inSection:0];
                UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:path1];
                UIImageView *check1 = (UIImageView*)[cell1.contentView viewWithTag:i];
                check1.image = [UIImage imageNamed:@"checkbox.png"];
                [daysarray removeObject:cell1.text];
            }

        }
        else if (check.image == [UIImage imageNamed:@"checkbox.png"])
        {
            daysarray =[[NSMutableArray alloc] init];
            check.image = [UIImage imageNamed:@"checkbox-active.png"];
            NSLog(@"BYE");
            for (int i = 4; i < 11; i++) {
             NSLog(@"I am Selectin the row %d", i);
            NSIndexPath *path1 = [NSIndexPath indexPathForRow:i inSection:0];
            UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:path1];
            UIImageView *check1 = (UIImageView*)[cell1.contentView viewWithTag:i];
            check1.image = [UIImage imageNamed:@"checkbox-active.png"];
            [daysarray addObject:cell1.text];
        }
                 //[self.tableview deselectRowAtIndexPath:indexPath animated:YES];
               NSLog(@"Array of days: %@", daysarray);
        }


    }
    else if (indexPath.row > 3 )
    {
       NSLog(@"I am Selectin the row %ld", (long)indexPath.row);
        self.pickrViewIpad.hidden=YES;

        NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];
        UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:path];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIImageView *check = (UIImageView*)[cell.contentView viewWithTag:indexPath.row];
        UIImageView *check1 = (UIImageView*)[cell1.contentView viewWithTag:3];
        
        NSLog(@"subviews %@", check.image);
            if (check.image == [UIImage imageNamed:@"checkbox-active.png"])
            {
                check1.image =[UIImage imageNamed:@"checkbox.png"];
                check.image = [UIImage imageNamed:@"checkbox.png"];
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
                UITableViewCell *cell = (UITableViewCell*)[habitstableview cellForRowAtIndexPath:indexpath];
                [daysarray removeObject:cell.text];
                
            }
            else if (check.image == [UIImage imageNamed:@"checkbox.png"])
            {
                NSLog(@"I am Checking the row");
                NSLog(@"Day Removed: %@", cell.text);
                check.image = [UIImage imageNamed:@"checkbox-active.png"];
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
                UITableViewCell *cell = (UITableViewCell*)[habitstableview cellForRowAtIndexPath:indexpath];
                [daysarray addObject:cell.text];
                if ([daysarray count] == 7) {
                    check1.image =[UIImage imageNamed:@"checkbox-active.png"];
                }
               }
         }
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Array of days: %@", daysarray);
   // }
}

- (void)showDatePickerCell
{
    self.datePickerIsShowing = YES;
    [habitname resignFirstResponder];
}

- (void)hideDatePickerCell
{
    self.datePickerIsShowing = NO;
    [habitname resignFirstResponder];
}

- (void)toggleSwitch
{
    if (toggleswitch.on)
    {
        [habitname resignFirstResponder];
        [self.view endEditing:YES];
         NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        UITableViewCell *cell = (UITableViewCell*)[habitstableview cellForRowAtIndexPath:indexPath];
        
       SHED *shed	= [[SHED alloc] init];
        NSString *queryString = [NSString stringWithFormat:@"Select shed_id ,alarm_status, alarm_time FROM SHED "];
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"shed_db.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        NSLog(@"query %@", queryString);
        [database open];
        
        FMResultSet *results = [database executeQuery:queryString];
        
        while([results next])
        {
                shed.shed_id = [results stringForColumn:@"shed_id"];
                shed.alarm_status = [results stringForColumn:@"alarm_status"];
                shed.alarm_time = [results stringForColumn:@"alarm_time"];
                NSLog(@"SHED ID IS TO BE: %@", shed.shed_id);
        }
        [database close];
        
        if ([shed.alarm_status isEqualToString:@"1"]) {
            NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
            [timeFormat setDateFormat:@"HH:mm a"];
            [timeFormat setTimeZone:[NSTimeZone systemTimeZone]];

            
            NSDate *Date = [timeFormat dateFromString:shed.alarm_time];
            NSLog(@"Time is : %@", Date);
            
        }
        
        timelbl.hidden = NO;
        timelbl.textColor = [UIColor blackColor];
        //timelbl.text =[NSString stringWithFormat:@"%@",[df stringFromDate:pickdate.date]];
        cell.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"list-bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
//        timetitlelbl.backgroundColor = [UIColor clearColor];
//        timelbl.backgroundColor = [UIColor clearColor];
        [toggleswitch setOn:YES animated:YES];
    }
    else
    {
        [habitname resignFirstResponder];
        NSLog(@"Time is %@",timelbl.text);
        self.datePickerIsShowing = NO;
        timelbl.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1];
        timelbl.textColor = [UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1];
        timetitlelbl.backgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1];
        [toggleswitch setOn:NO animated:YES];
    }
}

- (IBAction)changeDateInLabel:(NSDate*)date
{
    NSLog(@"I Am Changing the values");
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm"];
    [timeFormat setTimeZone:[NSTimeZone systemTimeZone]];
    
    if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480))
    {
        NSString *theTime = [timeFormat stringFromDate:pickdate.date];
        NSLog(@"TIME IS:%@",theTime);
        timelbl.text = [NSString stringWithFormat:@"%@",[timeFormat stringFromDate:pickdate.date]];
    }
    else
    {
        NSString *theTime = [timeFormat stringFromDate:datePickerIpad.date];
        NSLog(@"TIME IS:%@",theTime);
        timelbl.text = [NSString stringWithFormat:@"%@",[timeFormat stringFromDate:datePickerIpad.date]];
    }
}

- (void)showPicker:(NSDate *)date
{
    actionsheet = [[UIActionSheet alloc] initWithTitle:@"Select the Time" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"DONE" otherButtonTitles:Nil, nil];
    pickdate = [[UIDatePicker alloc] initWithFrame:[actionsheet bounds]];
    pickdate.hidden = NO;
    pickdate.datePickerMode = UIDatePickerModeTime;
    [pickdate addTarget:self action:@selector(changeDateInLabel:) forControlEvents:UIControlEventValueChanged];
    [actionsheet addSubview:pickdate];
    [actionsheet showInView:self.view];
    [actionsheet setBounds:CGRectMake(0,0,320, 500)];
    
    CGRect pickerRect = pickdate.bounds;
    pickerRect.origin.y = -90;
    pickdate.bounds = pickerRect;
    [pickdate setDate:date animated: YES];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        actionsheet = Nil;
    }
}

- (IBAction)header_back:(id)sender {
    if ([habitname.titleLabel.text isEqualToString:@"SHEDs Description"]) {
        homescreenViewController *home;
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            home = [[homescreenViewController alloc] initWithNibName:@"homescreenViewController" bundle:nil];
            //this is iphone 5 xib
        } else  if ([[UIScreen mainScreen] bounds].size.height == 480) {
            home = [[homescreenViewController alloc] initWithNibName:@"homescreenViewController_iphone4" bundle:nil];
            // this is iphone 4 xib
        } else {
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
        
        [self.navigationController pushViewController:home animated:NO];
    }
    else{
    UIAlertView *savealert = [[UIAlertView alloc] initWithTitle:@" You are about to leave this Screen"  message:@"Do you want to save the SHED??" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO",nil];
    savealert.tag = 2;
    [savealert show];
    }
}
-(void) scheduleNotificationForDate: (NSString*)days: (NSString*)myDate1: (NSString*)desc{
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *curdate = [dateFormat dateFromString:appDelegate.todaysDate];

    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:curdate];
    
    NSArray *tempStr = [myDate1 componentsSeparatedByString:@":"];
    
    NSLog(@"month %ld", (long)[components month]);
    NSLog(@"year %ld", (long)[components year]);
    NSLog(@"day %ld", (long)[components day]);
    NSLog(@"hour %d", [[tempStr objectAtIndex:0] intValue]);
    NSLog(@"minute %d", [[tempStr objectAtIndex:1] intValue]);
    
    NSDateComponents *tempComp = [[NSDateComponents alloc] init];
    
    NSArray *daysstr = [days componentsSeparatedByString:@","];
    NSLog(@"Selected Days Name: %@", daysstr);
    int i;
    int weekDay = [components weekday];
    
    for (i = 0; i < [daysstr count]; i++) {
        NSDateComponents *dateParts = [[NSDateComponents alloc] init];
        
        [dateParts setHour:[[tempStr objectAtIndex:0] intValue]];
        [dateParts setMinute:[[tempStr objectAtIndex:1] intValue]];
        [dateParts setSecond:00];
        
        NSString *myArrayElement = [daysstr objectAtIndex:i];
        if ([myArrayElement isEqualToString:@"Sunday"]) {
            
            tempComp.day = 1-weekDay;
            NSDate *newdate = [calendar dateByAddingComponents:tempComp toDate:curdate options:0];
            NSDateComponents *newComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:newdate];
            [dateParts setYear:[newComp year]];
            [dateParts setMonth:[newComp month]];
            [dateParts setDay:[newComp day]];
        }
        else if ([myArrayElement isEqualToString:@"Monday"]) {
            
            tempComp.day = 2-weekDay;
            NSDate *newdate = [calendar dateByAddingComponents:tempComp toDate:curdate options:0];
            NSDateComponents *newComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:newdate];
            [dateParts setYear:[newComp year]];
            [dateParts setMonth:[newComp month]];
            [dateParts setDay:[newComp day]];
        }
        else if ([myArrayElement isEqualToString:@"Tuesday"]) {
            
            tempComp.day = 3-weekDay;
            NSDate *newdate = [calendar dateByAddingComponents:tempComp toDate:curdate options:0];
            NSDateComponents *newComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:newdate];
            [dateParts setYear:[newComp year]];
            [dateParts setMonth:[newComp month]];
            [dateParts setDay:[newComp day]];
        }
        else if ([myArrayElement isEqualToString:@"Wednesday"]) {
            tempComp.day = 4-weekDay;
            NSDate *newdate = [calendar dateByAddingComponents:tempComp toDate:curdate options:0];
            NSDateComponents *newComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:newdate];
            [dateParts setYear:[newComp year]];
            [dateParts setMonth:[newComp month]];
            [dateParts setDay:[newComp day]];
        }
        else if ([myArrayElement isEqualToString:@"Thursday"]) {
            
            tempComp.day = 5-weekDay;
            NSDate *newdate = [calendar dateByAddingComponents:tempComp toDate:curdate options:0];
            NSDateComponents *newComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:newdate];
            [dateParts setYear:[newComp year]];
            [dateParts setMonth:[newComp month]];
            [dateParts setDay:[newComp day]];
        }
        else if ([myArrayElement isEqualToString:@"Friday"]){
            
            tempComp.day = 6-weekDay;
            NSDate *newdate = [calendar dateByAddingComponents:tempComp toDate:curdate options:0];
            NSDateComponents *newComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:newdate];
            [dateParts setYear:[newComp year]];
            [dateParts setMonth:[newComp month]];
            [dateParts setDay:[newComp day]];
        }
        else if ([myArrayElement isEqualToString:@"Saturday"]) {
            
            tempComp.day = 7-weekDay;
            NSDate *newdate = [calendar dateByAddingComponents:tempComp toDate:curdate options:0];
            NSDateComponents *newComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:newdate];
            [dateParts setYear:[newComp year]];
            [dateParts setMonth:[newComp month]];
            [dateParts setDay:[newComp day]];
        }
        NSString *queryString = [NSString stringWithFormat:@"SELECT shed_id FROM SHED WHERE shed_id = (SELECT MAX(shed_id) FROM SHED)"];
        
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"shed_db.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        NSLog(@"query %@", queryString);
        NSLog(@"path : %@", dbPath);
        [database open];
        
        FMResultSet *results = [database executeQuery:queryString];
        
        while([results next]) {
            str = [results stringForColumn:@"shed_id"];
            NSLog(@"ID is :: %@",str);
        }
        NSString *tempString = [NSString stringWithFormat:@"%@%@", str, myArrayElement];
        NSLog(@"Habit Name :  %@", desc);
        NSDate *sDate = [calendar dateFromComponents:dateParts];
        
        NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:tempString, @"SHED_ID", nil];
        localNotif.userInfo = userDict;
        
        localNotif.fireDate = sDate;
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        localNotif.repeatInterval = NSWeekdayCalendarUnit;
        localNotif.alertAction = NSLocalizedString(@"View Details", nil);
        localNotif.alertBody = desc;
        localNotif.soundName =UILocalNotificationDefaultSoundName;
       
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        NSLog(@"notification started");
    }

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [habittextview resignFirstResponder];
        return NO;
    }
    return textView.text.length + (text.length - range.length) <= 60;
    return YES;
}
- (IBAction)addthetext:(id)sender {
    HabittextfeildView.hidden = YES;
     [habittextview resignFirstResponder];
   
    
        savebtn.userInteractionEnabled = YES;
    tempStr = [NSString stringWithFormat:@"%@",habittextview.text];
    
    
    if (tempStr.length == 0) {
        [habitname setTitle:@"SHEDs Description" forState:UIControlStateNormal];

    }
    else{
        
        NSString *str1 = [NSString stringWithFormat:@"%@",tempStr];
              NSString *habitName;
        if (([[UIScreen mainScreen] bounds].size.height == 568) ||([[UIScreen mainScreen] bounds].size.height == 480)){
            
            
            NSRange stringRange = {0, MIN([str1 length], 20)};
            // adjust the range to include dependent chars
            stringRange = [str1 rangeOfComposedCharacterSequencesForRange:stringRange];
            
            // Now you can create the short string
            NSString *shortString = [str1 substringWithRange:stringRange];

            if (str1.length <= 20) {
                
                habitName = [NSString stringWithFormat:@"%@",shortString];
            }else{
                habitName = [NSString stringWithFormat:@"%@...",shortString];
            }
        }
        else{
            NSRange stringRange = {0, MIN([str1 length], 35)};
            // adjust the range to include dependent chars
            stringRange = [str1 rangeOfComposedCharacterSequencesForRange:stringRange];
            
            // Now you can create the short string
            NSString *shortString = [str1 substringWithRange:stringRange];
            if (str1.length <= 35) {
                habitName = [NSString stringWithFormat:@"%@",shortString];

            }
            else{
                habitName = [NSString stringWithFormat:@"%@...",shortString];
            }
        }
        

        
        [habitname setTitle:habitName forState:UIControlStateNormal];
    }
}
//- (void) textViewDidBeginEditing:(UITextView *)textView {
//    textView.selectedRange = NSMakeRange(0, 0);
//}
- (IBAction)resignBtn:(id)sender {
    pickrViewIpad.hidden=YES;
    [self.view setUserInteractionEnabled:YES];
}
    @end
