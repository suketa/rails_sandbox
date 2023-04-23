importScripts('https://storage.googleapis.com/workbox-cdn/releases/6.4.1/workbox-sw.js');
function onInstall(event) {
  console.log('[Service Worker]', 'Installing!', event);
}

function onActivate(event) {
  console.log('[Service Worker]', 'Activating!', event);
}

function onFetch(event) {
  console.log('[Service Worker]', 'Fetching!', event);
}

self.addEventListener('install', onInstall);
self.addEventListener('activate', onActivate);
self.addEventListener('fetch', onFetch);

const {CacheFirst, NetworkFirst} = workbox.strategies;
const {registerRoute} = workbox.routing;

registerRoute(
  ({url}) => url.pathname.startsWith('/home'),
  new CacheFirst({
    cacheName: 'documents',
  })
)

registerRoute(
  ({request, url}) => request.destination === 'document' || request.destination === "",
  new NetworkFirst({
    cacheName: 'documents',
  })
)

registerRoute(
  ({request}) => request.destination === 'script' || request.destination === 'style',
  new CacheFirst({
    cacheName: 'assets-styles-and-scripts',
  })
)

registerRoute(
  ({request}) => request.destination === 'image',
  new CacheFirst({
    cacheName: 'assets-images',
  })
)
