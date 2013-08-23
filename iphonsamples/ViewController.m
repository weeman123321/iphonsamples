//
//  ViewController.m
//  iphonsamples
//
//  Created by Optimind on 8/5/13.
//  Copyright (c) 2013 Optimind. All rights reserved.
//

#import "ViewController.h"
#import "navViewController.h"
#import <CoreImage/CoreImage.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "popViewController.h"

@interface ViewController (){

    IBOutlet UIButton *buton1;
    IBOutlet UIButton *buton2;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIImageView *imageView;
    IBOutlet UISlider *slider;
    IBOutlet UILabel *label;
    IBOutlet UIView *secondView;
    
    CIContext *context;
    CIFilter *filter;
    CIImage *beginImage;

}

@end

@implementation ViewController
-(IBAction)onCLick:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    navViewController *myVC = (navViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Storyboard"];
    [self presentViewController:myVC animated:YES completion:nil];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",buttonIndex);
    NSLog(@"%@",[actionSheet buttonTitleAtIndex:buttonIndex]);
}
-(IBAction)onsecondView:(id)sender{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"creatqwe" owner:self options:nil];
    secondView=[array objectAtIndex:0];
    NSLog(@"qweqwe");
    [self.view addSubview:secondView];
    label.text=@"second vqweqweqweqiew here";
    NSLog(@"%d",self.view.tag);


//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"TITLE" delegate:self cancelButtonTitle:@"CANCEL" destructiveButtonTitle:@"destructive" otherButtonTitles:@"otherButton",@"watevaa", nil];
//    [actionSheet showFromBarButtonItem:sender animated:YES];
    
//    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"something"] applicationActivities:nil];
//    [self presentViewController:activityViewController animated:YES completion:nil];
//    popViewController *pop = [[popViewController alloc]initWithNibName:@"popViewController" bundle:nil];
//    [self presentViewController:pop animated:YES completion:nil];

}
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *gotImage =
    [info objectForKey:UIImagePickerControllerOriginalImage];
    beginImage = [CIImage imageWithCGImage:gotImage.CGImage];
    [filter setValue:beginImage forKey:kCIInputImageKey];
    [self amountSliderValueChanged:slider];
    
    
}

- (IBAction)savePhoto:(id)sender {
    // 1
    CIImage *saveToSave = [filter outputImage];
    // 2
    CIContext *softwareContext = [CIContext
                                  contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)} ];
    // 3
    CGImageRef cgImg = [softwareContext createCGImage:saveToSave
                                             fromRect:[saveToSave extent]];
    // 4
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cgImg
                                 metadata:[saveToSave properties]
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              // 5
                              CGImageRelease(cgImg);
                          }];
    
}

- (void)imagePickerControllerDidCancel:
(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"imagePickerControllerDidCancel");
}
-(IBAction)actionEnter:(id)sender{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
}
- (IBAction)loadPhoto:(id)sender {
    UIImagePickerController *pickerC =
    [[UIImagePickerController alloc] init];
    pickerC.delegate = self;
    [self presentViewController:pickerC animated:YES completion:nil];
}
- (IBAction)amountSliderValueChanged:(UISlider *)slider {
    float slideValue = slider.value;
    
    [filter setValue:@(slideValue)
              forKey:@"inputIntensity"];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [context createCGImage:outputImage
                                     fromRect:[outputImage extent]];
    
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    imageView.image = newImage;
    
    CGImageRelease(cgimg);
}
- (void)viewDidLoad
{
    NSArray *a = @[@"qwe",@"asd",@"zxc"];
    NSLog(@"%@",a);
	scrollView.center=self.view.center;
    scrollView.hidden=YES;
    // 1
    NSString *filePath =
    [[NSBundle mainBundle] pathForResource:@"Anya" ofType:@"jpg"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    
    beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    context = [CIContext contextWithOptions:nil];
    
    
    
    filter = [CIFilter filterWithName:@"CISepiaTone"
                                  keysAndValues: kCIInputImageKey, beginImage,
                        @"inputIntensity", @0.8, nil];
    CIImage *outputImage = [filter outputImage];
    
    // 2
    CGImageRef cgimg =
    [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    // 3
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    imageView.backgroundColor=[UIColor grayColor];
    imageView.center=self.view.center;
    imageView.image = newImage;
    CGImageRelease(cgimg);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
