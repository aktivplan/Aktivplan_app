importScripts("https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js");

/*Update with yours config*/
const firebaseConfig = {
  apiKey: "AIzaSyCcuG5UqWNte0sUlyuQwsMgmQw_IiysAWQ",
  appId: "1:717638915284:android:ba968065d132e9deb41741",
  messagingSenderId: "717638915284",
  projectId: "aktivplanplus",
  authDomain: "aktivplanplus.firebaseapp.com",
  storageBucket: "aktivplanplus.appspot.com",
  measurementId: "G-NJ3CHM0BG7",
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

/*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
messaging.onBackgroundMessage(function (payload) {
  console.log("Received background message ", payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
