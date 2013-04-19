//
//  FirstViewController.m
//  News
//
//  Created by xiao nan on 13-3-27.
//  Copyright (c) 2013年 xiao nan. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
{
    NSDictionary *rootDic;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://123.126.55.185/api/1.0/news"]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    rootDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];

    UIImage * backgroundImage = [UIImage imageNamed:@"tabBar_Background.png"];
    
    CGRect rect = self.tabBarController.tabBar.bounds;
    
    UIGraphicsBeginImageContext(rect.size);
    [backgroundImage drawInRect:rect];
    
    
    UIImage *selectedImage = [UIImage imageNamed:@"tabBar_News_Selected.png"];
    UIImage *unselectedImage = [UIImage imageNamed:@"tabBar_News_Unselected.png"];
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    [tabBar setBackgroundImage:UIGraphicsGetImageFromCurrentImageContext()];
    
    UITabBarItem *item1 = [tabBar.items objectAtIndex:0];
    [item1 setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
    
    UIImage *selectedImage2 = [UIImage imageNamed:@"tabBar_More_Selected.png.png"];
    UIImage *unselectedImage2 = [UIImage imageNamed:@"tabBar_More_Unselected.png.png"];
    UITabBarItem *item2= [tabBar.items objectAtIndex:1];
    [item2 setFinishedSelectedImage:selectedImage2 withFinishedUnselectedImage:unselectedImage2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rootDic count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"simpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSInteger row = [indexPath row];
//    NSDictionary *dic = [rootDic objectAtIndex:row];
    NSMutableString *indexstr = [[NSMutableString alloc] init];
    [indexstr appendFormat:@"%d", row+1];
    cell.textLabel.text = [rootDic objectForKey:indexstr];
    return cell;
}

@end
