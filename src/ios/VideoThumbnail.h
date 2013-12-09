//
//  VideoThumbnail.h
//
//
//  Created by plidstone@gmail.com
//
//

#import <Cordova/CDV.h>
#import <Cordova/CDVJSON.h>
#import <AVFoundation/AVFoundation.h>
#import "MediaPlayer/MPMoviePlayerController.h"

@interface VideoThumbnail : CDVPlugin {
    MPMoviePlayerController *player;
    NSString *movie;
}

@property(nonatomic) NSString *videoPath;
@property(nonatomic) NSString *callbackId;

- (void) getThumbnail:(CDVInvokedUrlCommand*)command;

@end