//
//  VideoThumbnail.m
//
//
//  Created by plidstone@gmail.com
//
//

#import "VideoThumbnail.h"
#import "MediaPlayer/MPMoviePlayerViewController.h"
#import "MediaPlayer/MPMoviePlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import <Cordova/CDV.h>
#import <Cordova/CDVJSON.h>

@implementation VideoThumbnail

- (void) getThumbnail:(CDVInvokedUrlCommand *)command {
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Select Thumbnail"
                                                      message:@"Select the frame for your video thumbnail and click done"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    
    NSMutableDictionary* options = (NSMutableDictionary*)[command argumentAtIndex:0];
    
    self.callbackId = command.callbackId;
    self.videoPath = [options objectForKey:@"videopath"];
    
    NSString *orient = @"NO";
    NSRange range = [movie rangeOfString:@"http"];
    if(range.length > 0) {
        if ([@"YES" isEqualToString:orient]) {
            player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:movie] ];
        } else {
            player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:movie] ];
        }
        
    } else {
        NSArray *fileNameArr = [movie componentsSeparatedByString:@"."];
        NSString *prefix = [fileNameArr objectAtIndex:0];
        NSString *suffix = [fileNameArr objectAtIndex:1];
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:prefix ofType:suffix];
        NSURL *fileURL = [NSURL fileURLWithPath:self.videoPath];

        player = [[MPMoviePlayerController alloc] initWithContentURL:fileURL ];
        [self.viewController dismissModalViewControllerAnimated:YES];
        player.controlStyle = MPMovieControlStyleEmbedded;
        player.shouldAutoplay = NO;
        [self.viewController.view addSubview:player.view];
        [player setFullscreen:YES animated:YES];
        
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MovieDidFinish:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    [self.viewController presentMoviePlayerViewControllerAnimated:player];
    
}

- (void)MovieDidFinish:(NSNotification *)notification {
    /*NSURL *url = [NSURL fileURLWithPath:self.videoPath];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    NSError *error = NULL;
    CMTime time = CMTimeMake(1, 10);
    CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
    UIImage *FrameImage= [[UIImage alloc] initWithCGImage:refImg];*/
    //NSLog(@"error==%@, Refimage==%@", error, refImg);
    
    UIImage *thumbnail = [player thumbnailImageAtTime:[player currentPlaybackTime] timeOption:MPMovieTimeOptionNearestKeyFrame];
    
    NSData *imageData = UIImageJPEGRepresentation(thumbnail, 1.0);
    
    CDVPluginResult* result = nil;
    
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[imageData base64EncodedString]];
    
    if (result) {
        [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    }
    
    if (result) {
        [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    }
}

@end