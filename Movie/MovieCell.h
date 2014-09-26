//
//  MovieCell.h
//  Movie
//
//  Created by John  on 9/24/14.
//  Copyright (c) 2014 John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UIViewTableCell

@property (weak, nonatomic) IBOutlet UIImageView * posterView;
@property (weak, nonatomic) IBOutlet UILabel * movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * synopsisLabel;

@end
