//
//  UsersViewController.m
//  TipCalculator
//
//  Created by John  on 9/26/14.
//  Copyright (c) 2014 John. All rights reserved.
//

#import "UsersViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@interface UsersViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *movies;

@end

@implementation UsersViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    //self = [super initWithNibName:<#nibNameOrNil#> bundle:<#nibBundleOrNil#>];
    if (self){
        self.names = @[@"Tim", @"John", @"Mary",@"Joe",@"Sam"];
        self.title = @"Names";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=5fgjrkwkkbm3bevw8kq289gm";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request queue: [NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", object);
        self.movies = object[@"movies"];
        [self.tableView reloadData];
    }];
                                                      
                                                          
    self.tableView.rowHeight = 134;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell= [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    NSDictionary *movie = self.movies[indexPath.row];
    NSDictionary *posters = movie[@"posters"];
    NSString *posterUrl = posters[@"detailed"];
    
        
       cell.movieTitleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrl]];
       
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    NSString *name = self.names[indexPath.row];
    NSLog(@"you selected: %@", name);
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
