import 'package:demoflu/demoflu.dart';
import 'package:flutter/material.dart';

class BannerPage extends DemoFluPage {
  BannerPage() {
    bannerSection(
        text: 'This is a banner created with the bannerSection method');

    bannerSection(text: 'You can add any icon.', icon: Icons.search);

    bannerSection(
        text: 'You can also change the colors.',
        background: Colors.purple[50],
        border: Colors.purple[700]);

    warningBannerSection(
        text:
            'It is also possible to create a default warning banner with the warningBannerSection method.');

    infoBannerSection(
        text:
            'There is also the default info banner with the infoBannerSection method.');

    tipBannerSection(
        text: 'And the default tip banner with the tipBannerSection method.');

    sourceCodeSection('lib/pages/banner_page.dart', title: 'Page source code');
  }
}
