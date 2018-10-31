#! /bin/bash

# Save the Solarized CSS to disk
curl https://cdn.jsdelivr.net/gh/chattahippie/slack-night-mode@fcafbca8be2a720410c6b3988f280fa09ef8fca0/css/raw/variants/solarized-dark.css -o /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/custom-css.css

# Modify ssb-interop.js
cat << 'EOF' >> /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js
// First make sure the wrapper app is loaded
document.addEventListener("DOMContentLoaded", function () {

  const readFilePromise = (filePath, encoding) => {
    const fs = require('fs');
    const promise = new Promise((res, rej) => {
      fs.readFile(filePath, encoding, (err, data) => {
        if (err) rej(err);
        else res(data);
      })
    })
    return promise;
  }

  // Then get its webviews
  let webviews = document.querySelectorAll(".TeamView webview");

  // Fetch our CSS in parallel ahead of time
  const cssPath = `/Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/custom-css.css`;

  let cssPromise = readFilePromise(cssPath, 'utf-8');

  // Insert a style tag into the wrapper view
  cssPromise.then(css => {
    let s = document.createElement('style');
    s.type = 'text/css';
    s.innerHTML = css;
    document.head.appendChild(s);
  });

  // Wait for each webview to load
  webviews.forEach(webview => {
    webview.addEventListener('ipc-message', message => {
      if (message.channel == 'didFinishLoading')
        // Finally add the CSS into the webview
        cssPromise.then(css => {
          let script = `
                    let s = document.createElement('style');
                    s.type = 'text/css';
                    s.id = 'slack-custom-css';
                    s.innerHTML = \`${css + customCustomCSS}\`;
                    document.head.appendChild(s);
                    `
          webview.executeJavaScript(script);
        })
    });
  });
});
EOF
echo If Slack.app is already running, go to it and refresh with CMD-R
