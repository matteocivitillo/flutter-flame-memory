'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "23bbf33742be27fa8496e0a1ccaaa24d",
"assets/AssetManifest.bin.json": "81044a1694466490118da3ea59c1948e",
"assets/AssetManifest.json": "38e06703803f26c25e8d847ebe096ebc",
"assets/assets/images/10_of_clubs.png": "c29b28f3eceb7284d141163e3bd37736",
"assets/assets/images/10_of_diamonds.png": "4324d71291ce16ef4161df8cf852298e",
"assets/assets/images/10_of_hearts.png": "2e6327a66fbf8d05d379d87d56251a1e",
"assets/assets/images/10_of_spades.png": "2401fe3648865f6bc3c01a538c512d7c",
"assets/assets/images/2_of_clubs.png": "c83a7af4125e22d9733f6514295f3d4c",
"assets/assets/images/2_of_diamonds.png": "0b5b5249b22ada06106be8b73938be9e",
"assets/assets/images/2_of_hearts.png": "f97ad85b1e89af6a88c70205cdea06f6",
"assets/assets/images/2_of_spades.png": "2354275da56e304199f694388a8aaae6",
"assets/assets/images/3_of_clubs.png": "23a7a6ac76db02bbde27988e49ac5fca",
"assets/assets/images/3_of_diamonds.png": "b529e1c14fef2ffc07c3c4eac94c31f4",
"assets/assets/images/3_of_hearts.png": "1c16fe1052c3a4d1715ee1288209ebe9",
"assets/assets/images/3_of_spades.png": "ad02dc95b434842c3465a7a4dbaca615",
"assets/assets/images/4_of_clubs.png": "02deab4916f717f0b9478fad476ec40f",
"assets/assets/images/4_of_diamonds.png": "58bd0a6383829cbce3747c245c0b204c",
"assets/assets/images/4_of_hearts.png": "5ad913da63724447b7c94d1fb2d293a6",
"assets/assets/images/4_of_spades.png": "df185c634b2fee0418bd613524938832",
"assets/assets/images/5_of_clubs.png": "3781bf44a82cad8ef837e6ba281427c9",
"assets/assets/images/5_of_diamonds.png": "e27b4b0aadc6a28953f53cfd573e9e2d",
"assets/assets/images/5_of_hearts.png": "8f6a2068fd6f32c372ea8dab0cde6f40",
"assets/assets/images/5_of_spades.png": "aa8a072015826f2e582a59e9606e0cd3",
"assets/assets/images/6_of_clubs.png": "9c2fdf6a8916a2b3daea26a7974eed28",
"assets/assets/images/6_of_diamonds.png": "ee5053d458469b151ef1f4503b5ab12f",
"assets/assets/images/6_of_hearts.png": "9cd2258c8c8c175ead46f94800741891",
"assets/assets/images/6_of_spades.png": "5d221b2a958bb6b66b4e57de437c0906",
"assets/assets/images/7_of_clubs.png": "112be1dfa65edf2cabf9122b2c49eb22",
"assets/assets/images/7_of_diamonds.png": "df3e8e93d277f2b73d2c5ddf348c065c",
"assets/assets/images/7_of_hearts.png": "a9afa10fcea89a4227bb4b81f49a35e8",
"assets/assets/images/7_of_spades.png": "c0f5e5f9013f1d24eccd395ab9312766",
"assets/assets/images/8_of_clubs.png": "6ed0b85e676230d360186c3469b08cdf",
"assets/assets/images/8_of_diamonds.png": "8afee604213ca296067245ce18458af2",
"assets/assets/images/8_of_hearts.png": "e6c01b136dca0b2c3c03a115d4ab21e1",
"assets/assets/images/8_of_spades.png": "747667555c7c5d6799ca3545463372b0",
"assets/assets/images/9_of_clubs.png": "784ea7703fcff1e10745e014d98a24aa",
"assets/assets/images/9_of_diamonds.png": "86608eb9bf92b21b9e33a1ffa4c46ccc",
"assets/assets/images/9_of_hearts.png": "cdb8fda5b30f3973b1ec7f200c24a18f",
"assets/assets/images/9_of_spades.png": "e5b29fdec7e761281073496181d31ab9",
"assets/assets/images/ace_of_clubs.png": "07d1c180bead76a0b8cf8e488dfc2755",
"assets/assets/images/ace_of_diamonds.png": "60b16fdaed475d30edab3bc92f4bd3c9",
"assets/assets/images/ace_of_hearts.png": "41453bfa387b05e68828f2b0159c19d9",
"assets/assets/images/ace_of_spades.png": "ce4f163fc9fddc4e9f173d74b2970cc2",
"assets/assets/images/ace_of_spades2.png": "3c00788af85d7ac4fcfeb155464ba71c",
"assets/assets/images/back_red.png": "7ec8586aabf84e84ca90181a0874c2d5",
"assets/assets/images/black_joker.png": "21cc92db51d5fb7888b97517c51c2d2a",
"assets/assets/images/jack_of_clubs.png": "1861c1e4a50028cb1dfce55e531ff292",
"assets/assets/images/jack_of_clubs2.png": "d96ecf4f3c246b8c781f82d1bb2bd1dc",
"assets/assets/images/jack_of_diamonds.png": "ac2092c166d2e7cc53f04db33296c851",
"assets/assets/images/jack_of_diamonds2.png": "c936f66eb6ca786d62a2c49876367017",
"assets/assets/images/jack_of_hearts.png": "260cdba6401178e69eee797ee4e31247",
"assets/assets/images/jack_of_hearts2.png": "9be659a7f009932fe8f49a213c22e439",
"assets/assets/images/jack_of_spades.png": "92aff04497b99fe80d5d036a41da6529",
"assets/assets/images/jack_of_spades2.png": "d77ce402c3977e303abeed8ec5bb35a5",
"assets/assets/images/king_of_clubs.png": "2ad9bff3c6f99adf135499b905017921",
"assets/assets/images/king_of_clubs2.png": "f0dc748d3d36f265ab670c8ce0332e3d",
"assets/assets/images/king_of_diamonds.png": "1a5882a6ed0fb4a79a1f5c4877e432f6",
"assets/assets/images/king_of_diamonds2.png": "9588f72f2c9d6898c9af3b20bcde7c2f",
"assets/assets/images/king_of_hearts.png": "37b5b9d756e453abf7c673709c24894c",
"assets/assets/images/king_of_hearts2.png": "e8d050e1412d4866d34f9a41b0c48238",
"assets/assets/images/king_of_spades.png": "9b18a729ba5bda5ca4ef62fc6fdb4f62",
"assets/assets/images/king_of_spades2.png": "aebc913c5eb0ecd7859218636929c8ae",
"assets/assets/images/queen_of_clubs.png": "9e84dd75995fe4a3b8871bab4cbb3898",
"assets/assets/images/queen_of_clubs2.png": "fd943099b2abeb6cf01bebb4dc66cbbe",
"assets/assets/images/queen_of_diamonds.png": "d5647c19f6390075fc76d403aa266e0d",
"assets/assets/images/queen_of_diamonds2.png": "f91b8d276604290828523a097fd4af26",
"assets/assets/images/queen_of_hearts.png": "cf8946464fc57b3d20bf806522d0e799",
"assets/assets/images/queen_of_hearts2.png": "8065dc2a89d1be1e9908343fb99d82cc",
"assets/assets/images/queen_of_spades.png": "6d100fc31db0f6e10df79f2891aaf8f2",
"assets/assets/images/queen_of_spades2.png": "445df3cf193554d44a50f43d4597c324",
"assets/assets/images/red_joker.png": "032874afea49aa79307937f4270c5811",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "96ac9613ca1cd923c6d9bbe29376d812",
"assets/NOTICES": "dfd2b06a2c6de0aefa59d1ca8003e1e3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "730e3087525fbdcb7b0e159a9265e591",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f1ac27d4f931c47afb89a76701cd2e91",
"/": "f1ac27d4f931c47afb89a76701cd2e91",
"main.dart.js": "8f0bd8e08c2f8e7a0c9c9a864a1149b2",
"manifest.json": "bf24c84c3bf99672a631c4f84464e793",
"version.json": "d39062771aa05a4731023e1aab8f8db2"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
