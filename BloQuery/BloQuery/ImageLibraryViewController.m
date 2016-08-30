//
//  ImageLibraryViewController.m
//  BloQuery
//
//  Created by MELANIE MCGANNEY on 8/25/16.
//  Copyright © 2016 Bloc. All rights reserved.
//


#import "ImageLibraryViewController.h"
#import "UserProfileViewController.h"
#import <Photos/Photos.h>
#import "BLCDataSource.h"
#import "Cloudinary/Cloudinary.h"

@import Firebase;
@import FirebaseDatabase;

@interface ImageLibraryViewController () <CLUploaderDelegate>

@property (nonatomic, strong) PHFetchResult *result;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation ImageLibraryViewController

- (void) uploaderSuccess:(NSDictionary*)result context:(id)context {
    NSString* publicId = [result valueForKey:@"public_id"];
    NSLog(@"Upload success. Public ID=%@, Full result=%@", publicId, result);
}

- (void) uploaderError:(NSString*)result code:(int) code context:(id)context {
    NSLog(@"Upload error: %@, %d", result, code);
}

- (void) uploaderProgress:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite context:(id)context {
    NSLog(@"Upload progress: %d/%d (+%d)", totalBytesWritten, totalBytesExpectedToWrite, bytesWritten);
}

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
    
    //set correct image on profile view
    static NSInteger imageViewTag = 54321;
    UIImageView *imgView = (UIImageView*)[[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:imageViewTag];
    UIImage *img = imgView.image;
    [[BLCDataSource sharedInstance] setUserImage:img];
   
    
    //push that image to cloudinary
    PHAsset *asset = nil;
    
    if (self.result[indexPath.row] != nil && self.result.count > 0) {
        asset = self.result[indexPath.row];
        NSLog(@"asset %@", asset);
        //get image file path here?
        
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
             
             NSURL *path = [info objectForKey:@"PHImageFileURLKey"];
             //NSString *pathString = path.absoluteString;
             NSString *pathString = [path path];
             NSLog(@"pathstring %@", pathString);
            CLCloudinary *cloudinary = [[CLCloudinary alloc] initWithUrl: @"cloudinary://529452493569691:bF9rOpKrNtwqKgq7EZXfTAtI3mY@mellyeg96"];
             CLUploader *uploader = [[CLUploader alloc] init:cloudinary delegate:self];
             NSString *imageFilePath = pathString;
             NSLog(@"imageFilePath %@", imageFilePath );
             [uploader upload:imageFilePath options:@{}];
         }
     }];
   
    
   
   
   

    
    //get the url of this image from Cloudinary and store it in firebase
    //use this variable to populate smilely faces
    
    FIRUser *userAuth = [FIRAuth auth].currentUser;
    //NSLog(@"user %@", userAuth.uid );
    NSString *key = @"http://res.cloudinary.com/mellyeg96/image/upload/v1471355788/sample.jpg";
    //second variable will be the url from cloudinary
    if (userAuth != nil) {
        // User is signed in.
       self.ref = [[FIRDatabase database] reference];
        NSDictionary *childUpdates = @{[NSString stringWithFormat:@"/userData/%@/profile_picture/", userAuth.uid]:key};
                                        
         [_ref updateChildValues:childUpdates];
        
    } else {
        // No user is signed in.
    }

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
