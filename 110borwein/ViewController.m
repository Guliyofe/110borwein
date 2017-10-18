//
//  ViewController.m
//  110borwein
//
//  Created by Guillaume BLONDEAU on 09/04/2014.
//  Copyright (c) 2014 Guillaume BLONDEAU. All rights reserved.
//

#import "ViewController.h"
#include <stdlib.h>
#include <time.h>
#include <math.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize textbox;
@synthesize textbox_a;
@synthesize textbox_b;
@synthesize textbox_sub;
@synthesize nr;
@synthesize nt;
@synthesize ns;
@synthesize ir;
@synthesize dr;
@synthesize it;
@synthesize dt;
@synthesize is;
@synthesize ds;
@synthesize timexe;

double a = 0;
double b = 5000;
double sub = 10000;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapRecognizer];
    
}

-(void)tap:(UIGestureRecognizer *)gr
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

double          my_f(int n, double x)
{
    double        k = 0;
    double        res = 1;

    k = 0;
    while (k <= n)
    {
        if ((x / ((2 * k) + 1)) != 0)
            res = res * (sin(x / ((2 * k) + 1)) / (x / ((2 * k) + 1)));
        k = k + 1;
    }
    return (res);
}

double             my_rectangles(int n)
{
    double        i = 0;
    double        integral = 0;
    double        h = (b - a) / sub;

    while (i < b)
    {
        integral = integral + my_f(n, a + i * h);
        i++;
    }
    integral = integral * h;
    return (integral);
}

double             my_trapezes(int n)
{
    double        f_a = my_f(n, a);
    double        f_b = my_f(n, b);
    double        i = 1;
    double        integral = 0;
    double        h = (b - a) / sub;
    double        h2 = (b - a) / (2 * sub);
    
    while (i < b)
    {
        integral = integral + my_f(n, a + i * h);
        i++;
    }
    integral = h2 * (f_a + f_b + integral * 2);
    return (integral);
}

double             my_simpson(int n)
{
    double        i = 0;
    double        f_a = my_f(n, a);
    double        f_b = my_f(n, b);
    double        integral = 0;
    double        integral_1 = 0;
    double        fin = 0;
    double        h = (b - a) / sub;
    double        h6 = (b - a) / (6 * sub);
    
    while (i < b)
    {
        integral = integral + my_f(n, a + (i * h) + (h / 2));
        i++;
    }
    i = 1;
    while (i < b)
    {
        integral_1 = integral_1 + my_f(n, a + i * h);
        i++;
    }
    fin = h6 * (f_a + f_b + (integral_1 * 2) + (integral * 4));

    return (fin);
}

- (IBAction)textbox:(id)sender {

}

- (IBAction)textbox_b:(id)sender {
    b = [textbox_b.text doubleValue];
}

- (IBAction)textbox_a:(id)sender {
    a = [textbox_a.text doubleValue];
}

- (IBAction)textbox_sub:(id)sender {
    sub = [textbox_sub.text doubleValue];
}

- (IBAction)button:(id)sender {
    
    NSInteger n = [textbox.text integerValue];
    
    nr.text = textbox.text;
    nt.text = textbox.text;
    ns.text = textbox.text;
    
    
    clock_t        start = clock();
    double         intrec = my_rectangles(n);
    double         inttra = my_trapezes(n);
    double         intsim = my_simpson(n);
    clock_t        end = clock();
    double         total = (end - start) / (double)CLOCKS_PER_SEC;
    
    NSString *strrec = [NSString stringWithFormat:@"%.10f", intrec];
    NSString *strtra = [NSString stringWithFormat:@"%.10f", inttra];
    NSString *strsim = [NSString stringWithFormat:@"%.10f", intsim];
    NSString *diffrec = [NSString stringWithFormat:@"%.10f", (M_PI / 2) - intrec];
    NSString *difftra = [NSString stringWithFormat:@"%.10f", (M_PI / 2) - inttra];
    NSString *diffsim = [NSString stringWithFormat:@"%.10f", (M_PI / 2) - intsim];
    NSString *timexec = [NSString stringWithFormat:@"%.5f s", total];
    
    ir.text = strrec;
    it.text = strtra;
    is.text = strsim;
    dr.text = diffrec;
    dt.text = difftra;
    ds.text = diffsim;
 
    timexe.text = timexec;
}

@end