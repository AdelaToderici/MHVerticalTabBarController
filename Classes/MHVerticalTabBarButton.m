//
//  MHVerticalTabBarButton.m
//  MHVerticalTabBarController
//
//  Created by Marshall Huss on 1/3/13.
//  Copyright (c) 2013 mwhuss. All rights reserved.
//

#import "MHVerticalTabBarButton.h"

static const NSInteger kImageViewSize = 30;

@implementation MHVerticalTabBarButton

- (id)initWithTabBarItem:(UITabBarItem *)tabBarItem {
    if (tabBarItem.image) {
        self = [self initWithTitle:tabBarItem.title
                             image:[tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                     selectedImage:[tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    }
    else {
        self = [self initWithTitle:tabBarItem.title image:tabBarItem.finishedUnselectedImage selectedImage:tabBarItem.finishedSelectedImage];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    self = [super init];
    if (self) {
        [self commonInit];
        _titleLabel.text = title;
        _imageView.image = image;
        _imageView.highlightedImage = selectedImage;
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
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);

    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;

    _titleOffset = CGSizeZero;
    _imageOffset = CGSizeZero;
}

- (void)setSelected:(BOOL)selected {
    _imageView.highlighted = selected;
}

- (void)setLabelAttributes:(NSDictionary *)labelAttributes {
    _labelAttributes = labelAttributes;
    if (self.titleLabel.text) {
        self.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:_labelAttributes];
    }
}

- (void)setImageOffset:(CGSize)imageOffset {
    _imageOffset = imageOffset;
    [self setNeedsLayout];
}

- (void)setTitleOffset:(CGSize)titleOffset {
    _titleOffset = titleOffset;
    [self setNeedsLayout];
}

- (void)setLabelFrame:(CGRect)labelFrame {
    _titleLabel.frame = labelFrame;
    [self setNeedsLayout];
}

- (void)layoutSubviews {

    if ([_titleLabel.attributedText length] > 0) {

        if (CGSizeEqualToSize(_imageOffset, CGSizeZero)) {
            _imageView.frame = CGRectMake((self.bounds.size.width/2 - (kImageViewSize/2)), 15, kImageViewSize, kImageViewSize);
        }
        else {
            _imageView.frame = CGRectOffset(self.bounds, self.imageOffset.width, self.imageOffset.height);
        }

        if (CGSizeEqualToSize(_titleOffset, CGSizeZero)) {
            _titleLabel.frame = CGRectOffset(self.bounds, 0, _imageView.image.size.height * 4);
        }
        else {
            _titleLabel.frame = CGRectOffset(self.bounds, self.titleOffset.width, self.titleOffset.height);
        }
    }
    else {
        _imageView.frame = self.bounds;
    }

    [self reSizeLabel:_titleLabel];

    [self addSubview:_imageView];
    [self addSubview:_titleLabel];
}

- (void)reSizeLabel:(UILabel *)label {
    NSString *aLabelTextString = [label text];
    UIFont *aLabelFont = [label font];
    CGFloat aLabelSizeWidth = label.frame.size.width;

    CGSize sizeCalculated = [aLabelTextString boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                                           options:NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{NSFontAttributeName : aLabelFont}
                                                           context:nil].size;

    CGRect newFrame = label.frame;
    newFrame.size.height = sizeCalculated.height;
    label.frame = newFrame;
}


@end
