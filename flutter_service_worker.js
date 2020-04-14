'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "f68462e5550974af619eec75b0c13a66",
"/": "f68462e5550974af619eec75b0c13a66",
"main.dart.js": "eb12f0219fd75606e5325b52657b2cbc",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "5e7a2009e3a082289486e86a9e07bb68",
"assets/LICENSE": "2650574ecc50f1c7333b284ccd4e14a7",
"assets/AssetManifest.json": "0b643d3fa794db4f945dab31ef813ed6",
"assets/FontManifest.json": "a457f21ee91542b0fa8c4c2edac83322",
"assets/packages/flutter_markdown/assets/logo.png": "67642a0b80f3d50277c44cde8f450e50",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/assets/flutter_i18n/zh.json": "a1b5e45a4a3eea34fb275b992ceec7fe",
"assets/assets/flutter_i18n/pt.json": "de5a41639cee9c61ea0ae3effa077984",
"assets/assets/flutter_i18n/en.json": "fdf4f5e3d8727ce3501a10e77bda50d7",
"assets/assets/flutter_i18n/it.json": "a52837b8c96d9091278b13007461aadc",
"assets/assets/flutter_i18n/fr.json": "74b20f18f0be5c6ce2f9e66061a1a7f8",
"assets/assets/flutter_i18n/es.json": "04d3a7eb939f8190edfc4248308723d9",
"assets/assets/icons/capsule.svg": "2980f5319b2ed51ae4d900507441995e",
"assets/assets/icons/icon_splash.png": "f6bb950c1bceec66171594d19751e9a6",
"assets/assets/icons/patch.svg": "af6f0d5886175104e64e5f50c4783ff8",
"assets/assets/icons/icon_app.png": "64660a34497bdd0c006193b43e889961",
"assets/assets/icons/fins.svg": "7398f04c66340e82735c725f0dd2a4cf",
"assets/assets/fonts/RobotoMono-Regular.ttf": "a48ac41620cd818c5020d0f4302489ff",
"assets/assets/fonts/ProductSans-Bold.ttf": "dba0c688b8d5ee09a1e214aebd5d25e4",
"assets/assets/fonts/RobotoMono-Bold.ttf": "c0c4a33786b0278c385d0f647b57490f",
"assets/assets/fonts/ProductSans-Regular.ttf": "eae9c18cee82a8a1a52e654911f8fe83"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
