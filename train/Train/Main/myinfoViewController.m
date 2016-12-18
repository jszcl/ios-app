//
//  myinfoViewController.m
//  Train
//
//  Created by zhu changle on 16/11/11.
//  Copyright © 2016年 Jiny. All rights reserved.
//

#import "myinfoViewController.h"

@interface myinfoViewController ()<UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray * _ageArray;
}
@property (weak, nonatomic) IBOutlet UIImageView *imagech;
@property (weak, nonatomic) IBOutlet UIPickerView *agepicker;
@property (weak, nonatomic) IBOutlet UILabel *agelabel;
@property (weak, nonatomic) IBOutlet UITextField *textfill;
@property (nonatomic,strong) NSString *ageselected;
@property (nonatomic,strong) UIImage *avatarImage;
@end

@implementation myinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.agepicker =  [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 320, 216)];
    self.agepicker.dataSource = self;
    self.agepicker.delegate = self;
    [self.view addSubview:self.agepicker];

    _ageArray = [NSArray arrayWithObjects:@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",nil];}
    //image
//    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapAvatarImageViewAction)];
//    
//    self.imagech.image = [UIImage imageNamed:@"logo"];
//     
//     
//     
//  }
//- (void) imagePickerController : (UIImagePickerController * picker did)

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
   
    
    return _ageArray.count;
}
- (NSString *)agepicker: (UIPickerView *)agepicker titleForRow :(NSInteger) row forComponent: (NSInteger) component{
    NSString *str=[_ageArray objectAtIndex:row];
    self.agelabel.text = str;
    return str;
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回teams中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用teams中的第几个元素
    
    return [_ageArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.agelabel.text = [_ageArray objectAtIndex:row];
    [[NSUserDefaults standardUserDefaults] setObject:self.agelabel.text forKey:@"Age"];
    [[NSUserDefaults standardUserDefaults] synchronize ];
    
}
- (void)datePickAction {
    self.agepicker.hidden = NO;
}
- (IBAction)clickCancelAction:(id)sender {
    self.agepicker.hidden = YES;
}
- (IBAction)clickConfirmAction:(id)sender {
    //[self clickAge];
  
    
        self.agepicker.hidden = YES;
}


- (IBAction)textfill:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.textfill.text forKey:@"Name"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

//- (IBAction)endu:(id)sender {
//     [self.textfill resignFirstResponder];
//}
//- (IBAction)endup:(id)sender {
//    [self.textfill resignFirstResponder];
//    
//    
//}
//
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   [self.view endEditing:YES];}
//}
- (IBAction)savestuff:(id)sender {
   [self pushDetailWithIdentifier:@"MeViewController"];
}
- (void)pushDetailWithIdentifier:(NSString *)identifier{
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:viewController animated:YES];
}
//- (IBAction)clickCancelAction:(id)sender {
//    self.agepicker.hidden = YES;
//}
//
//- (IBAction)clickConfirmAction:(id)sender {
//    [self clickDateRequest];
//    [self.dateButton setTitle:[self trunTimeStampWithDate:self.datePicker.date]
//                     forState:UIControlStateNormal];
//    self.dateView.hidden = YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
