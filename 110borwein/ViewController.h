//
//  ViewController.h
//  110borwein
//
//  Created by Guillaume BLONDEAU on 09/04/2014.
//  Copyright (c) 2014 Guillaume BLONDEAU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textbox;
@property (weak, nonatomic) IBOutlet UITextField *textbox_a;
@property (weak, nonatomic) IBOutlet UITextField *textbox_b;
@property (weak, nonatomic) IBOutlet UITextField *textbox_sub;

- (IBAction)textbox:(id)sender;
- (IBAction)textbox_b:(id)sender;
- (IBAction)textbox_a:(id)sender;
- (IBAction)textbox_sub:(id)sender;
- (IBAction)button:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *nr;
@property (weak, nonatomic) IBOutlet UILabel *nt;
@property (weak, nonatomic) IBOutlet UILabel *ns;

@property (weak, nonatomic) IBOutlet UILabel *ir;
@property (weak, nonatomic) IBOutlet UILabel *dr;

@property (weak, nonatomic) IBOutlet UILabel *it;
@property (weak, nonatomic) IBOutlet UILabel *dt;

@property (weak, nonatomic) IBOutlet UILabel *is;
@property (weak, nonatomic) IBOutlet UILabel *ds;

@property (weak, nonatomic) IBOutlet UILabel *timexe;

@end
