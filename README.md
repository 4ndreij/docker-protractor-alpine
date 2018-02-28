# docker-protractor-alpine
Base image for leveraging dockerized UI automation tests using Protractor

# hint
For headless chromium setup, use in protractor configuration file:

```javascript
...
capabilities: {
    browserName: 'chrome',
    chromeOptions: {
      args: ['no-sandbox', 'headless', 'disable-gpu']
    }
  },
chromeDriver: '/usr/bin/chromedriver'
...
```