

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface AlbumContentsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
{
    UITableView *testtable;
    NSMutableArray *img_url_array, *uiimage_array, *select_deselect;
}
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;

@end

#define kImageViewTag 1 // the image view inside the collection view cell prototype is tagged with "1"
//- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"photoCell";
//    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//    // load the asset for this cell
//    ALAsset *asset = self.assets[indexPath.row];
//    CGImageRef thumbnailImageRef = [asset thumbnail];
//    UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
//    // apply the image to the cell
//    UIImageView *imageView = (UIImageView *)[cell viewWithTag:kImageViewTag];
//    imageView.image = thumbnail;
//    return cell;
//}
