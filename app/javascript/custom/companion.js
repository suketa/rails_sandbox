if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', {scope: "/"})
    .then(() => navigator.serviceWorker.ready)
    .then((registration) => {
      if ("SyncManager" in window) {
        registration.sync.register("sync");
      } else {
        window.alert("This browser doesn't support background sync.")
      }
    }).then(() => {
      console.log("[Companion]", "Service Worker Registered");
    });
}
