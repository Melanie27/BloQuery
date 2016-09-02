//
//  ImageLibraryViewController.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/25/16.
//  Copyright © 2016 Bloc. All rights reserved.
//


#import <Photos/Photos.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "ImageLibraryViewController.h"
#import "UserProfileViewController.h"
#import "BLCDataSource.h"
#import "User.h"


@import Firebase;
@import FirebaseDatabase;
@import FirebaseStorage;


@interface ImageLibraryViewController () <CLUploaderDelegate>

@property (nonatomic, strong) PHFetchResult *result;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) FIRStorage *storage;


@end

@implementation ImageLibraryViewController

-(instancetype) init {
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    
    return [super initWithCollectionViewLayout:layout];
}

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    UIImage *cancelImage = [UIImage imageNamed:@"x"];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:cancelImage style:UIBarButtonItemStyleDone target:self action:@selector(cancelPressed:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) cancelPressed:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat minWidth = 100;
    NSInteger divisor = width / minWidth;
    CGFloat cellSize = width / divisor;
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(cellSize, cellSize);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
}

//load the assets
-(void) loadAssets {
    
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    self.result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
    NSLog(@"result %@", self.result);
    
    
}

//ask if user has granted access to photo library, if not, request auth
-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self loadAssets];
                    [self.collectionView reloadData];
                });
            }
        }];
    } else if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
        [self loadAssets];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.result.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSInteger imageViewTag = 54321;
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:imageViewTag];
    
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.tag = imageViewTag;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [cell.contentView addSubview:imageView];
    }
    
    if (cell.tag != 0) {
        [[PHImageManager defaultManager] cancelImageRequest:(PHImageRequestID)cell.tag];
    }
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    PHAsset *asset = self.result[indexPath.row];
    
    cell.tag = [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:flowLayout.itemSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info) {
        UICollectionViewCell *cellToUpdate = [collectionView cellForItemAtIndexPath:indexPath];
        
        if (cellToUpdate) {
            UIImageView *imageView = (UIImageView *)[cellToUpdate.contentView viewWithTag:imageViewTag];
            imageView.image = result;
        }
    }];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     FIRUser *userAuth = [FIRAuth auth].currentUser;
     self.ref = [[FIRDatabase database] reference];
    
    PHAsset *asset = nil;
    
    if (self.result[indexPath.row] != nil && self.result.count > 0) {
        asset = self.result[indexPath.row];
    }

   
    PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc] init];
    imageRequestOptions.synchronous = YES;
    [[PHImageManager defaultManager]
     requestImageDataForAsset:asset
     options:imageRequestOptions
     resultHandler:^(NSData *imageData, NSString *dataUTI,
                     UIImageOrientation orientation,
                     NSDictionary *info)
     {
         
         if ([info objectForKey:@"PHImageFileURLKey"]) {
          
             NSURL *localURL = [info objectForKey:@"PHImageFileURLKey"];
             NSString *localURLString = [localURL path];
             NSString *key = localURLString;
             NSString *theFileName = [[key lastPathComponent] stringByDeletingPathExtension];
            
             
             //UPLOAD TO FB
             FIRStorage *storage = [FIRStorage storage];
             FIRStorageReference *storageRef = [storage referenceForURL:@"gs://bloquery-e361d.appspot.com/profilePhotos"];
             FIRStorageReference *profileRef = [storageRef child:theFileName];
             
             FIRStorageUploadTask *uploadTask = [profileRef putFile:localURL metadata:nil completion:^(FIRStorageMetadata* metadata, NSError* error) {
                 if (error != nil) {
                     // Uh-oh, an error occurred!
                     //NSLog(@"error %@", error);
                 } else {
                     // Metadata contains file metadata such as size, content-type, and download URL.
                     NSURL *downloadURL = metadata.downloadURL;
                     NSString *downloadURLString = [ downloadURL absoluteString];
                    
                      //push the selected photo to database
                     FIRDatabaseQuery *pathStringQuery = [[self.ref child:[NSString stringWithFormat:@"/userData/%@/", userAuth.uid]] queryLimitedToFirst:1000];
                     
                    [pathStringQuery
                      observeEventType:FIRDataEventTypeValue
                      withBlock:^(FIRDataSnapshot *snapshot) {
                          //TODO - not seeing the correct image
                          static NSInteger imageViewTag = 54321;
                          UIImageView *imgView = (UIImageView*)[[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:imageViewTag];
                          UIImage *img = imgView.image;
                          [[BLCDataSource sharedInstance] setUserImage:img];
                          
                          
                    }];
                     
                    NSDictionary *childUpdates = @{[NSString stringWithFormat:@"/userData/%@/profile_picture/", userAuth.uid]:downloadURLString};
                         
                    [_ref updateChildValues:childUpdates];
                         

                 }
             }];

            
             
            
                
         }
     }];
   

    [self cancelPressed:self.navigationItem.leftBarButtonItem];
    
    
    //TODO update profilePhoto and pass it back to the USER PROFILE VIEW CONTROLLER
   //PASS TO QUESTION TABLE VIEW CONTROLLER ALSO
        
   
}

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
