//
//  Game.m
//  110borwein
//
//  Created by Guillaume BLONDEAU on 11/04/2014.
//  Copyright (c) 2014 Guillaume BLONDEAU. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

//S'occupe du score
-(void)score
{
    score_nb = score_nb + 1;
    score_label.text = [NSString stringWithFormat:@"%i", score_nb];
}

///Début du jeu
-(void)start;
{
    
    nbr_partie = [[NSUserDefaults standardUserDefaults] integerForKey:@"NbrPartieSaved"];
    
    [self what_piou];
    
    if (audioPlayer.playing == false)
    {
        [audioPlayer setCurrentTime:0];
        [audioPlayer play];
        [audioPlayer setNumberOfLoops:10];
    }
    
    start.hidden = YES;
    exit.hidden = YES;
    banner.hidden = YES;
    restart.hidden = YES;
    high_score_label_nb.hidden = YES;
    nb_partie.hidden = YES;
    exp.hidden = YES;
    fond_nb_partie.hidden = YES;
    bois_up.hidden = NO;
    bois_down.hidden = NO;
    bottom.hidden = NO;
    piou.hidden = NO;
    pause.hidden = NO;
    
    piou.center = CGPointMake(51, 215);
    
    score_nb = 0;
    score_label.text = [NSString stringWithFormat:@"%i", score_nb];
    
    piou_move = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(piou_moving) userInfo:nil repeats:YES];
    
    [self bois_placement];
    
    bois_move = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(bois_moving) userInfo:nil repeats:YES];
}

//Fin du jeu
-(void)game_over
{
    if (score_nb > high_score_nb) {
        [[NSUserDefaults standardUserDefaults] setInteger:score_nb forKey:@"HighScoreSaved"];
    }
    
    high_score_nb = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    high_score_label_nb.text = [NSString stringWithFormat:@"High Score : %i", high_score_nb];
    high_score_label_nb.hidden = NO;
    
    nbr_partie = nbr_partie + 1;
    [[NSUserDefaults standardUserDefaults] setInteger:nbr_partie forKey:@"NbrPartieSaved"];
    nb_partie.text = [NSString stringWithFormat:@"Nombre de parties jouées : %i",nbr_partie];
    nb_partie.hidden = NO;
    fond_nb_partie.hidden = NO;
    
    
    score_nb = 0;
    
    [self calc_exp];
    
    //[audioPlayer stop];
    
    [bois_move invalidate];
    [piou_move invalidate];
    piou.hidden = YES;
    bois_up.hidden = YES;
    bois_down.hidden = YES;
    bottom.hidden = YES;
    pause.hidden = YES;
    exp.hidden = NO;
    
    playing = NO;
    
    banner.hidden = NO;
    
    exit.hidden = NO;
    restart.hidden = NO;
}

//Mouvement des bois
-(void)bois_moving
{
    bois_up.center = CGPointMake(bois_up.center.x - 1,  bois_up.center.y);
    bois_down.center = CGPointMake(bois_down.center.x - 1, bois_down.center.y);
    
    if (bois_down.center.x < -28) {
        [self bois_placement];
    }
    
    if (bois_up.center.x == 31) {
        [self score];
    }
    
    [self collision];

}

//On calcule l'exp
-(void)calc_exp
{
    if (nbr_partie < 100)
    {
        exp_piou = (double)nbr_partie / 100;
    }
    if (nbr_partie > 100)
    {
        exp_piou = (double)nbr_partie / 300;
    }
    if (nbr_partie > 300)
    {
        exp_piou = (double)nbr_partie / 600;
    }
    if (nbr_partie > 600)
    {
        exp_piou = (double)nbr_partie / 1000;
    }
    if (nbr_partie > 1000)
    {
        exp_piou = 1.0;
    }
    exp.progress = exp_piou ;
}

//Check de collision
-(void)collision
{
    if (CGRectIntersectsRect(piou.frame, bois_up.frame)) {
        [self game_over];
    }
    if (CGRectIntersectsRect(piou.frame, bois_down.frame)) {
        [self game_over];
    }
    if (piou.center.y < -20) {
        [self game_over];
    }
    if (CGRectIntersectsRect(piou.frame, bottom.frame)) {
        [self game_over];
    }
}

//Placement des bois
-(void)bois_placement
{
    random_bois_up_pos = arc4random() % 350;
    random_bois_up_pos = random_bois_up_pos - 180;
    random_bois_down_pos = random_bois_up_pos + 500;
    
    bois_up.center = CGPointMake(340, random_bois_up_pos);
    bois_down.center = CGPointMake(340, random_bois_down_pos);
}

//Mouvement du pioupiou
-(void)piou_moving
{
    piou.center = CGPointMake(piou.center.x, piou.center.y - piou_flight);
    
    piou_flight = piou_flight - 5;
    
    if (piou_flight < -15) {
        piou_flight = -15;
    }

}

//On change le piou selon le niveau
-(void)what_piou
{
    if (nbr_partie < 100)
    {
        piou.image = [UIImage imageNamed:@"pioupiou.png"];
    }
    if (nbr_partie > 100)
    {
        piou.image = [UIImage imageNamed:@"pioupiou2.png"];
    }
    if (nbr_partie > 300)
    {
        piou.image = [UIImage imageNamed:@"pioupiou3.png"];
    }
    if (nbr_partie > 600)
    {
        piou.image = [UIImage imageNamed:@"pioupiou4.png"];
    }
    if (nbr_partie > 1000)
    {
        piou.image = [UIImage imageNamed:@"pioupiouX.png"];
    }
}

//Quand on touche l'écran
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    piou_flight = 23;
    
    if (playing == NO)
    {
        playing = YES;
        [self start];
    }
}

//Pause
- (IBAction)pause:(id)sender {
    [audioPlayer pause];
    [NSThread sleepForTimeInterval:1.0f];
    [audioPlayer play];
}


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
    
    //Pub
    banner.delegate = self;
    banner.hidden = NO;
    
    //Audio
    AudioSessionInitialize (NULL, NULL, NULL, (__bridge void *)self);
    
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty (kAudioSessionProperty_AudioCategory, sizeof (sessionCategory), &sessionCategory);
    
    NSData *soundFileData;
    soundFileData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"play.mp3" ofType:NULL]]];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithData:soundFileData error:NULL];
    
    if(!([audioPlayer prepareToPlay]))
        NSLog(@"La méthode prepareToPlay a renvoyé la valeur FALSE");
    
    audioPlayer.delegate = self;
    [audioPlayer setVolume:1.0f];

    
    //Initialisation des graphismes
    bois_up.hidden = YES;
    bois_down.hidden = YES;
    high_score_label_nb.hidden = YES;
    nb_partie.hidden = YES;
    fond_nb_partie.hidden = YES;
    restart.hidden = YES;
    exp.hidden = YES;
    pause.hidden = YES;
    
    score_nb = 0;
    high_score_nb = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    nbr_partie = [[NSUserDefaults standardUserDefaults] integerForKey:@"NbrPartieSaved"];
    
    [self calc_exp];
    
    [self what_piou];
    
    playing = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Pub
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
