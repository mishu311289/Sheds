//
//  testViewController.h
//  AccordionTableView
//
//  Created by Krishna_Mac on 12/26/13.
//  Copyright (c) 2013 Vladimir Olexa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gratitude.h"

@interface gratitude_listingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *topItems;
    NSMutableArray *subItems;
    NSString *ParentCellIdentifier;
    NSString *ChildCellIdentifier;
    int currentExpandedIndex;
    bool isMovingDown, shouldCollapse;
    int lastSelection, currentSelection;
    int flag;
}

@property (retain,nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic) NSMutableArray *gratitude_list;
@property (strong,nonatomic) NSMutableArray *selectedRows;
@property (strong,nonatomic) UILabel *datelbl;
@property (strong,nonatomic) UILabel *gratlbl;
@property (strong,nonatomic) UIImageView *gratimgup;
@property (strong,nonatomic) UIImageView *gratimgdown;
@property (assign,nonatomic) long int  rowIndex;
@property (assign,nonatomic) long int  selectIndex;
@property (strong,nonatomic) Gratitude *myGrat;
@end
