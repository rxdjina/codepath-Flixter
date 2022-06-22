//
//  CollectionViewController.m
//  Flixter
//
//  Created by Rodjina Pierre Louis on 6/21/22.
//

#import "CollectionViewController.h"
#import "CollectionCell.h"
#import "MovieViewController.h"
#import "UIImageView+AFNetworking.h"

@interface CollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *movieCollectionView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [super viewDi]
    
    self.movieCollectionView.dataSource = self;
    self.movieCollectionView.delegate = self;
    
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.movieCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ImageCollectionCell"];
    [self fetchMovies];

}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a641289c14048bed9ca44a727a7fd595"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"Oops, error");
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               NSLog(@"%@", dataDictionary);
               
        
               self.collectionDict = dataDictionary[@"results"];
               
               for (NSDictionary *hello in self.collectionDict) {
                   NSLog(@"%@", hello[@"poster_path"]);
               }
               NSLog(@"%ld@", self.collectionDict.count);
               [self.movieCollectionView reloadData];
           }
       }];

    [task resume];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return self.collectionDict.count;
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionDict.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionCell" forIndexPath:indexPath];
    
//    cell.backgroundColor = UIColor.blueColor;
    
    NSDictionary *movie = self.collectionDict[indexPath];
//
//    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500/";
//    NSString *posterURLString = movie[@"poster_path"];
//    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];

    NSString *fullPosterURLString = @"https://image.tmdb.org/t/p/w500/aqhLeieyTpTUKPOfZ3jzo2La0Mq.jpg";

    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];

//    self.collectionPosterImage = nil;
    [cell.collectionPosterImage setImageWithURL:posterURL];
    
    return cell;
}

//#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
