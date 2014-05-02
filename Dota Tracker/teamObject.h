//
//  teamObject.h
//  Dota Tracker
//
//  Created by Mike on 4/30/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface teamObject : NSObject {
    NSString *name;
    NSString *imageSelected;
    NSString *imageNotSelected;
    NSInteger *selected;
    NSInteger *region;
    NSInteger *regionRank;
}

@property (nonatomic, retain) NSString *name;;
@property (nonatomic, retain) NSString *imageSelected;
@property (nonatomic, retain) NSString *imageNotSelected;
@property (nonatomic, assign) NSInteger *selected;
@property (nonatomic, assign) NSInteger *region;
@property (nonatomic, assign) NSInteger *regionRank;

-(id)initWithName:(NSString *)n imageSelected:(NSString *)is imageNotSelected:(NSString *)ins selected:(NSInteger *)s region:(NSInteger *)r regionRank:(NSInteger *)rr;

@end
