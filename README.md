### bee_plugin ###

## Perl and AngularJS example ##

**Work in progress**

This is an example repo for setting up the BEE email editor plugin (https://beefree.io/) that uses Perl5 with a Dancer
web framework and AngularJS.

## Overview ##

- Request a ```client_id``` and ```client_secret``` from https://beefree.io/ and add it to ```environments/bee.yml```. Use
https://auth.getbee.io/apiauth as the ```base_url```.

- The BEE plugin is delivered via CDN, so you must authorize your app with beefree via OAuth2. To receieve a token, make a
```POST``` request to https://auth.getbee.io/apiauth with the parameters:

    - ```grant_type    => password```
    - ```client_id     => $YOUR_CLEINT_ID```
    - ```client_secret => $YOUR_CLIENT_SECRET```
  
  You will receive a JSON structure back as the token. In this example, the request is made on the server side for security
  reasons.
  
- You will load the plugin into your HTML with this ```src``` tag: 

  ```html
     <script src="https://app-rsrc.getbee.io/plugin/BeePlugin.js"></script>
  ```
  
  Provide a ```div``` with ```id="bee-plugin-container"``` for the plugin to live in.
  
  Both of these elements are wrapped in another ```div```, which initializes the Angular controller:
  
    ```html
    <div class="bee-plugin-main-container" ng-controller="BeePluginController" ng-init="initBeePlugin()">
        <script src="https://app-rsrc.getbee.io/plugin/BeePlugin.js"></script>
        <div id="bee-plugin-container"></div>
    </div>
    ```
    
- Lanch the web server with ```plackup```:

```bash
      $ plackup bin/app.pl
```

  Which will bind to: ```http://0.0.0.0:5000```
      

And that's it! More configuration features can be found on https://beefree.io/
