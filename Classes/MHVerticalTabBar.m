//
//  MHVerticalTabBar.m
//  MHVerticalTabBarController
//
//  Created by Marshall Huss on 1/3/13.
//  Copyright (c) 2013 mwhuss. All rights reserved.
//

#import "MHVerticalTabBar.h"
#import "MHVerticalTabBarButton.h"


@implementation MHVerticalTabBar

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _animationDuration = 0.2;

    self.backgroundColor = [UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0];

    _labelAttributes = @{
                         NSForegroundColorAttributeName : [UIColor colorWithRed:78/255.0 green:80/255.0 blue:87/255.0 alpha:1.0],
                         NSFontAttributeName : [UIFont boldSystemFontOfSize:14.5]
                         };
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);

    [self.tabBarButtons enumerateObjectsUsingBlock:^(MHVerticalTabBarButton *button, NSUInteger idx, BOOL *stop) {
        button.frame = CGRectMake(0, (height/self.tabBarButtons.count) * idx, width, (height/self.tabBarButtons.count));
    }];
}

- (void)setLabelAttributes:(NSDictionary *)labelAttributes {
    _labelAttributes = labelAttributes;
    [_tabBarButtons enumerateObjectsUsingBlock:^(MHVerticalTabBarButton *button, NSUInteger idx, BOOL *stop) {
        button.labelAttributes = _labelAttributes;
    }];
}

- (void)setItems:(NSArray *)items {
    _items = items;

    CGFloat width = CGRectGetWidth(self.bounds);

    [self.tabBarButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];

    self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), width * [items count]);

    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:[items count]];
    [items enumerateObjectsUsingBlock:^(UITabBarItem *tabBarItem, NSUInteger idx, BOOL *stop) {

        MHVerticalTabBarButton *button = [[MHVerticalTabBarButton alloc] initWithTitle:tabBarItem.title
                                                                                 image:tabBarItem.image
                                                                         selectedImage:tabBarItem.selectedImage];

        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.labelAttributes = self.labelAttributes;

        [self addSubview:button];
        [buttons addObject:button];
    }];

    self.tabBarButtons = buttons;
    [self setNeedsLayout];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self setSelectedButtonTitleAtIndex:selectedIndex animated:NO];
}

- (void)setSelectedButtonTitleAtIndex:(NSUInteger)selectedIndex animated:(BOOL)animated {
    if (selectedIndex > [self.tabBarButtons count]) return;

    _selectedIndex = selectedIndex;

    NSTimeInterval duration = animated ? _animationDuration : 0.0;

    [UIView animateWithDuration:duration animations:^{
        [self.tabBarButtons enumerateObjectsUsingBlock:^(MHVerticalTabBarButton *button, NSUInteger idx, BOOL *stop) {
            button.selected = NO;
            button.labelAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:78/255.0 green:80/255.0 blue:87/255.0 alpha:1.0],
                                       NSFontAttributeName:[UIFont boldSystemFontOfSize:14.5]};
        }];

        MHVerticalTabBarButton *button = self.tabBarButtons[_selectedIndex];
        button.selected = YES;
        button.labelAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                   NSFontAttributeName : [UIFont boldSystemFontOfSize:14.5]};

        _selectedBackgroundView.center = button.center;
    }];
}

- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage {
    [self.selectedBackgroundView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.selectedBackgroundView.backgroundColor = [UIColor clearColor];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:selectedBackgroundImage];
    imageView.frame = CGRectMake(0, 0, selectedBackgroundImage.size.width, selectedBackgroundImage.size.height);
    [self.selectedBackgroundView addSubview:imageView];
}

- (void)buttonPressed:(MHVerticalTabBarButton *)button {
    NSUInteger index = [self.tabBarButtons indexOfObject:button];
    [self setSelectedButtonTitleAtIndex:index animated:YES];

    if ([self.tabBarDelegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        [self.tabBarDelegate tabBar:self didSelectItem:self.items[_selectedIndex]];
    }
}

@end
