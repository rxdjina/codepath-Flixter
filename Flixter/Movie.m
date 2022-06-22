//
//  Movie.m
//  Pods
//
//  Created by Rodjina Pierre Louis on 6/21/22.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    
    self.title = dictionary[@"title"];
    self.synopsis = dictionary[@"overview"];
    self.poster = dictionary[@"poster_path"];
    self.background = dictionary[@"backdrop_path"];
    
    return self;
}

//+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries {
//    
//}

@end
