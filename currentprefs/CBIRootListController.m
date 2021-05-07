#include "CBIRootListController.h"
#import "YSCWaterWaveView.h"
#import "UIColor+Hex.h"
// #import <objc/runtime.h>

@implementation CBIRootListController

- (instancetype)init {
    self = [super init];

    if (self) {
        self.respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(respring)];
        self.navigationItem.rightBarButtonItem = self.respringButton;
        self.navigationItem.titleView = [UIView new];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,10,10)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.text = @"Current";
        [self.navigationItem.titleView addSubview:self.titleLabel];

        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,10,10)];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/currentprefs.bundle/icon@3x.png"];
        self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
        self.iconView.alpha = 0.0;
        [self.navigationItem.titleView addSubview:self.iconView];

        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,150)];
		self.headerView.clipsToBounds = YES;
        self.headerView.backgroundColor = UIColor.whiteColor;
		// self.headerView.layer.cornerRadius = 20;
		// if (@available(iOS 13.0, *)) {
		// 	self.headerView.layer.cornerCurve = kCACornerCurveContinuous;
		// }

		YSCWaterWaveView *waterWave = [[YSCWaterWaveView alloc] initWithFrame:[self.headerView bounds] waveSpeed:0.127f startupSpeed:2.0 waveAmplitudeMultiplier:8];
		waterWave.percent = 0.50f;
		waterWave.firstWaveColor = [UIColor pf_colorWithHexString:@"36ADEC" alpha:0.4f];
		waterWave.secondWaveColor = [UIColor pf_colorWithHexString:@"36DBEC" alpha:0.3f];
        [waterWave setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		[self.headerView addSubview:waterWave];
		[waterWave startWave];

        self.headerLabel = [UILabel new];
        self.headerLabel.text = @"Current";
        self.headerLabel.textColor = [UIColor pf_colorWithHexString:@"999999" alpha:1.0f];
        [self.headerLabel setFont:[UIFont fontWithName:@"PingFangTC-Thin" size:65.0f]];
        self.headerLabel.textAlignment = NSTextAlignmentCenter;
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.headerView addSubview:self.headerLabel];

        [NSLayoutConstraint activateConstraints:@[
            [self.titleLabel.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
            [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
            [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
            [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
	        [self.iconView.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
            [self.iconView.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
            [self.iconView.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
			// [headerImageView.topAnchor constraintEqualToAnchor:self.headerView.topAnchor constant:0.0f],
            // // [headerImageView.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
            // [headerImageView.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor],
            // [headerImageView.trailingAnchor constraintEqualToAnchor:self.headerView.trailingAnchor],
            // [headerImageView.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
            [self.headerLabel.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
            [self.headerLabel.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor],
            [self.headerLabel.trailingAnchor constraintEqualToAnchor:self.headerView.trailingAnchor],
            [self.headerLabel.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
        ]];
	}
	return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat const offsetY = scrollView.contentOffset.y;

    if (offsetY > 100) {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 1.0;
            self.titleLabel.alpha = 0.0;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 0.0;
            self.titleLabel.alpha = 1.0;
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableHeaderView = self.headerView;
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)respring {
  [HBRespringController respring];
}

-(void)discord {
	NSURL *discord = [NSURL URLWithString:@"https://discord.gg/zHN7yuGqYr"];
	[[UIApplication sharedApplication] openURL:discord options:@{} completionHandler:nil];
}

-(void)paypal {
	NSURL *paypal = [NSURL URLWithString:@"https://paypal.me/chr1sdev"];
	[[UIApplication sharedApplication] openURL:paypal options:@{} completionHandler:nil];
}

-(void)sourceCode {
	NSURL *source = [NSURL URLWithString:@"https://github.com/Chr1sDev/current"];
	[[UIApplication sharedApplication] openURL:source options:@{} completionHandler:nil];
}

@end
