//
//  DetailsViewController.h
//  Flixter
//
//  Created by Rodjina Pierre Louis on 6/17/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundPosterImage;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@property (nonatomic, strong) NSDictionary *detailDict;


@end

NS_ASSUME_NONNULL_END
