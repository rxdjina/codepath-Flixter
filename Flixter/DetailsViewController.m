//
//  DetailsViewController.m
//  Flixter
//
//  Created by Rodjina Pierre Louis on 6/17/22.
//

#import "DetailsViewController.h"
#import "MovieViewController.h"
#import "UIImageView+AFNetworking.h" // Can add helper methods

@interface DetailsViewController () <UIScrollViewDelegate>
//@property (nonatomic, strong) DetailsViewController *detailDict;
@property (strong, nonatomic) IBOutlet UITableView *scrollView;


@end

@implementation DetailsViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    for (NSDictionary *detail in self.detailDict) {
//        NSLog(@"%@", detail[@"title"]);
//    }
    
    self.titleLabel.text = self.detailDict[@"title"];
    self.synopsisLabel.text = self.detailDict[@"overview"];

    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500/";

    NSString *posterURLString = self.detailDict[@"poster_path"];
    NSString *backgroundURLString = self.detailDict[@"backdrop_path"];

    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSString *fullBackgroundURLString = [baseURLString stringByAppendingString:backgroundURLString];

    // NSURL similar to string, just validates URL valid
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    NSURL *backgroundURL = [NSURL URLWithString:fullBackgroundURLString];

    [self.posterImage setImageWithURL:posterURL];
    [self.backgroundPosterImage setImageWithURL:backgroundURL];
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
