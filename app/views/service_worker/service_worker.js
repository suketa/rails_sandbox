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
