//
//  UserSwitchCell.m
//  Train
//
//  Created by 金烨 on 16/11/9.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "UserSwitchCell.h"

#define SWITCH_STATUS @"SWITCH_STATUS"

@interface UserSwitchCell ()
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;

@end

@implementation UserSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSString * status = [[NSUserDefaults standardUserDefaults] objectForKey:SWITCH_STATUS];
    if (status.length < 1 || [status isEqualToString:@"1"]) {
        [self.switchButton setOn:YES];
    }else{
        [self.switchButton setOn:NO];
    }
}

- (IBAction)switchChangedAction:(id)sender {
    if (self.switchButton.isOn == YES) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:SWITCH_STATUS];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:SWITCH_STATUS];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
