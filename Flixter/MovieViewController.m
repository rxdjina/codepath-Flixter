//
//  MovieViewController.m
//  Flixter
//
//  Created by Rodjina Pierre Louis on 6/16/22.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h" // Can add helper methods
#import "DetailsViewController.h"
#import "AFNetworkReachabilityManager.h"
#import "Movie.h"

@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *movies;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIAlertController *alertControl;
@property (strong, nonatomic) UIAlertAction *alertAction;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        [self.view.window.rootViewController presentViewController:self.alertControl animated:YES completion:nil];
        NSLog(@"Connected to Internet");
    }
    
    [self.activityIndicator startAnimating];
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged]; // addTaarget for older functions
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    
//    self.alertControl = [[UIAlertController alloc] init];
    self.alertControl = [UIAlertController alertControllerWithTitle:@"Test Title" message:@"Test message." preferredStyle:UIAlertControllerStyleAlert];
    self.alertAction = [UIAlertAction actionWithTitle:@"Test" style:UIAlertActionStyleDefault handler:nil];
    [self.alertControl addAction:self.alertAction];
//    [self.view.window.rootViewController presentViewController:_alertControl animated:YES completion:nil];
    
    // Could also install "Network Link Conditioner" from Apple to simulate different networks
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a641289c14048bed9ca44a727a7fd595"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
//               NSLog(@"%@", [error localizedDescription]);
//               [self.view.window.rootViewController presentViewController:_alertControl animated:YES completion:nil];
//               [self.alertControl presentViewController:self.alertControl animated:YES completion:nil];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
//               NSLog(@"%@", dataDictionary);
               
               // Fetches data and places them into dictionary
               self.movies = dataDictionary[@"results"];
//               for (NSDictionary *movie in self.movies) {
//                   NSLog(@"%@", movie[@"title"]);
//               }
               
//               NSArray *dictionaries = dataDictionary[@"results"];
//               for (NSDictionary *dictionary in dictionaries) {
//                   Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
////                   NSLog(@"%@", movie);
//
//                   [self.movies addObject:movie];
//                   NSLog(@"%@", self.movies);
//
//               }
               // Reload data (loads to fast)
               [self.tableView reloadData];
//               [self.activityIndicator stopAnimating];
           }
            [self.refreshControl endRefreshing]; // Ends refreshing regardless of status
            [self.activityIndicator stopAnimating];
       }];
//    [self.activityIndicator stopAnimating];
    [task resume];
}

// Number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

// Cells and Cell customization
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.row];
//    Movie *movie = [[self.movies objectAtIndex:indexPath.row] integerValue];
    
    // Create custom cell class -> Attach cell elements to custom class
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    
    // Adding Images with Cocoapods
    // Run -> Open podfile and add "pod 'AFNetworking'" -> run 'pod install' -> Close .xcodeproj, ONLY work from .xcworkspace
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500/";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];

    // NSURL similar to string, just validates URL valid
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];

    // Clears out previous image (usually shows when scrolling fast or slow connection)
    cell.posterImage.image = nil;
    [cell.posterImage setImageWithURL:posterURL];

    return cell;
}

// Another way of passing data through segues
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSDictionary *dataToPass = self.movies[indexPath.row];
//    DetailsViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
//    detailVC.detailDict = dataToPass;
//    [self.navigationController pushViewController:detailVC animated:true];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"buttonSegue"]) {
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *dataToPass = self.movies[myIndexPath.row];
        DetailsViewController *detailVC = [segue destinationViewController];
        detailVC.detailDict = dataToPass;
    }
}

@end

