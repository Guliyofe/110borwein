//
//  Game.h
//  110borwein
//
//  Created by Guillaume BLONDEAU on 11/04/2014.
//  Copyright (c) 2014 Guillaume BLONDEAU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

int piou_flight;
int random_bois_up_pos;
int random_bois_down_pos;
int score_nb;
double exp_piou;
BOOL playing;
NSInteger high_score_nb;
NSInteger nbr_partie;

@interface Game : UIViewController <ADBannerViewDelegate, AVAudioPlayerDelegate>
{
    IBOutlet ADBannerView *banner;
    
    AVAudioPlayer * audioPlayer;

    IBOutlet UIImageView *piou;
    IBOutlet UILabel *start;
    IBOutlet UIImageView *bois_up;
    IBOutlet UIImageView *bois_down;
    IBOutlet UIImageView *bottom;
    IBOutlet UILabel *score_label;
    IBOutlet UILabel *high_score_label_nb;
    IBOutlet UIButton *exit;
    IBOutlet UILabel *restart;
    IBOutlet UILabel *nb_partie;
    IBOutlet UIImageView *fond_nb_partie;
    IBOutlet UIProgressView *exp;
    IBOutlet UIButton *pause;
    
    NSTimer *piou_move;
    NSTimer *bois_move;
}

- (IBAction)pause:(id)sender;
-(void)start;
-(void)piou_moving;
-(void)bois_moving;
-(void)bois_placement;
-(void)score;
-(void)game_over;
-(void)what_piou;
-(void)collision;
-(void)calc_exp;

@end
