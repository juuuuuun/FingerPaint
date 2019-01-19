//
//  DrawView.m
//  FingerPaint
//
//  Created by Jun Oh on 2019-01-18.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

#import "DrawView.h"
@interface DrawView ()

@property (nonatomic) NSMutableArray<NSMutableArray<NSValue *>*>* allPoints;
@property (nonatomic) NSMutableArray<UIColor*>* lineColors;
@property (nonatomic) int lineNumber;

@end


@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _allPoints = [[NSMutableArray alloc] init];
        _lineColors = [[NSMutableArray alloc] init];
        _lineNumber = 0;
        _inputColor = [UIColor blackColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint startingPoint = [touch previousLocationInView:self];
    NSValue* startValue = [NSValue valueWithCGPoint:startingPoint];
    
    NSMutableArray<NSValue *>* line = [[NSMutableArray alloc] initWithObjects: startValue, nil];
    [self.allPoints addObject:line];
    [self.lineColors addObject:self.inputColor];
    self.lineNumber++;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint nextPoint = [touch locationInView:self]; // Current touch location
    NSValue* nextValue = [NSValue valueWithCGPoint:nextPoint];
    [self.allPoints[self.lineNumber-1] addObject:nextValue];
    
    [self setNeedsDisplay];
}

#pragma mark - Drawing

// Called whenever a portion of this view needs to be redrawn
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5.0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    for(int i = 0; i < self.allPoints.count; i++) {
        CGContextBeginPath(context);
        CGContextSetStrokeColorWithColor(context, self.lineColors[i].CGColor);
        for(int j = 0; j < self.allPoints[i].count; j++) {
            if(CGRectContainsPoint(rect, self.allPoints[i][j].CGPointValue)) {
                if(j == 0) {
                    CGContextMoveToPoint(context, self.allPoints[i][j].CGPointValue.x, self.allPoints[i][j].CGPointValue.y);
                } else {
                    CGContextAddLineToPoint(context, self.allPoints[i][j].CGPointValue.x, self.allPoints[i][j].CGPointValue.y);
                    CGContextStrokePath(context);
                    CGContextMoveToPoint(context, self.allPoints[i][j].CGPointValue.x, self.allPoints[i][j].CGPointValue.y);
                }
            }
        }
        CGContextClosePath(context);
    }
    

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
