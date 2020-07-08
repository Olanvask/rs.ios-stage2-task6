//
//  TabBarControllerViewController.m
//  RSSchool_T6
//
//  Created by Oleg Vasiluk on 6/26/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "TabBarControllerViewController.h"
#import "InfoTableViewController.h"
#import "GalleryViewController.h"
#import "UIColor+task6.h"
#import "HomeViewController.h"
@interface TabBarControllerViewController ()

@end

@implementation TabBarControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor task6Black];
    self.view.backgroundColor = [UIColor task6White];
    InfoTableViewController *infoTableViewController = [[InfoTableViewController alloc]init];
    infoTableViewController.view.backgroundColor = [UIColor task6White];
 //   infoTableViewController.title = @"Info";
    UITabBarItem *infoTableVCTabItem = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"info_unselected"] selectedImage:[UIImage imageNamed:@"info_selected"]];
    infoTableViewController.tabBarItem = infoTableVCTabItem;
    
    UINavigationController *infoNavigationController;
    infoNavigationController = [[UINavigationController alloc]initWithRootViewController:infoTableViewController];
//    self.firstVC.navigationBar.barTintColor = [UIColor appYellowColor];
    
    
    GalleryViewController *galleryViewController = [[GalleryViewController alloc]init];
    galleryViewController.title = @"Gallery";
    galleryViewController.view.backgroundColor = [UIColor task6White];
    UITabBarItem *galleryTabItem = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"gallery_unselected"] selectedImage:[UIImage imageNamed:@"gallery_selected"]];
    galleryViewController.tabBarItem = galleryTabItem;
    UINavigationController *galleryNavigationController = [[UINavigationController alloc]initWithRootViewController:galleryViewController];
  //  galleryViewController.navigationBar.barTintColor = [UIColor task6Yellow];
    
    
    HomeViewController *homeViewController = [[HomeViewController alloc]init];
    homeViewController.view.backgroundColor = [UIColor task6White];
    homeViewController.title = @"RSSchool Task 6";
    
    UITabBarItem *homeTab = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"home_unselected"] selectedImage:[UIImage imageNamed:@"home_selected"]];;
    homeViewController.tabBarItem = homeTab;
   UINavigationController *homeNavigationController =  [[UINavigationController alloc] initWithRootViewController:homeViewController];
    homeNavigationController.navigationBar.barTintColor = [UIColor task6Yellow];
    self.viewControllers = @[infoNavigationController, galleryViewController, homeNavigationController];
    
    self.selectedIndex = 1;
}


@end
