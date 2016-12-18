//
//  MessageCell.m
//  HelloTrain
//
//  Created by 金烨 on 16/10/25.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell ()
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdLabel;

@end

@implementation MessageCell

- (void)configureUIWithDic:(NSDictionary *)dic{
    self.commentLabel.text = dic[@"comment"];
    self.sourceLabel.text = dic[@"source"];
    self.createdLabel.text = [self timeStampTurnWithTimeStamp:[dic[@"createdDate"] integerValue]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

//时间戳转时间
- (NSString *)timeStampTurnWithTimeStamp:(NSInteger)timeStamp{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    return [formatter stringFromDate:date];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
