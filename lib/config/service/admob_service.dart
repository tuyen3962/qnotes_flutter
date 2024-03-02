import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qnotes_flutter/config/constant/admob_helper.dart';

class AdmobService {
  final AdmobHelper _helper;

  AdmobService({required AdmobHelper admobHelper}) : _helper = admobHelper {
    _initGoogleMobileAds();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  ///Banner admob
  BannerAd? _bannerAd = null;

  void loadBanner() {
    BannerAd(
      adUnitId: _helper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) => _bannerAd = ad as BannerAd,
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
  }

  Widget loadBannerWidget() => SizedBox(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );

  ///
  InterstitialAd? _interstitialAd = null;

  void loadInterstitialAd({VoidCallback? onAdmobDismiss}) {
    InterstitialAd.load(
      adUnitId: _helper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) => onAdmobDismiss?.call());

          _interstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  // TODO: Add _rewardedAd
  RewardedAd? _rewardedAd = null;

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: _helper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _rewardedAd = null;
              loadRewardedAd();
            },
          );

          _rewardedAd = ad;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  void disposeBannerAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _bannerAd?.dispose();
    _bannerAd = null;
    _rewardedAd?.dispose();
    _rewardedAd = null;
  }
}
