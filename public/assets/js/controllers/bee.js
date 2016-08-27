var beeApp = angular.module('beePlugin', []);
beeApp.controller('BeePluginController', ['$scope', '$http', '$window', function($scope, $http, $window) {
    
    $scope.initBeePlugin = function() {

        var templateConfigs = {
            onSend: function(htmlFile) {
                __onSend(htmlFile, 'youremail@address.com', 'Custom Subject', $http);
            },
            onSave: function(jsonFile, htmlFile) {
                __onSave($http, jsonFile, htmlFile);
            },
            onSaveAsTemplate: function(jsonFile) {
                __onSaveAsTemplate($http, jsonFile);
            },
            onAutoSave: function (jsonFile) {
               __onSaveAsTemplate($http, jsonFile);
            },
            preventClose: true
        };

        return $http.get('/bee/token').then(function(resp) {
            var token = resp.data;

            $http.get(
                "/bee/client_config"
            ).then(function(resp) {
                var config = angular.extend(resp.data, templateConfigs);

                $window.BeePlugin.create(token, config, function(beePluginInstance) {
                    var beeInstance = beePluginInstance;
                    $http.get(
                        "https://rsrc.getbee.io/api/templates/m-bee"
                    ).success(function(template) {
                        beeInstance.start(template);
                    });
                });
            });
        });
    };

}]);

function __getTemplate(httpAgent, templateName) {
    var template = {};

    var templateData = {
        template_name: templateName
    };

    httpAgent.get(
        '/bee/get_template',
        templateData
    ).then(function(resp) {
        template = resp.data;
    });

    return template;
};

function __onSend(htmlFile, emailAddress, subject, httpAgent) {
   var testEmailData = {
       body: htmlFile,
       to: emailAddress,
       subject: subject
   };

   httpAgent.post(
       '/bee/test_email',
       testEmailData
   ).then(function(resp) {
       console.log(resp);
   });
};

function __onSave(httpAgent, jsonFile, htmlFile) {
    var data = {
        json_file: jsonFile,
        html_form: htmlFile
    };

    return httpAgent.post(
        '/bee/save_email', data
    ).success(function(resp) {
        console.log(resp);
    });
};

function __onSaveAsTemplate(httpAgent, jsonFile) {
    var data = {
        json_file: jsonFile
    };

    return httpAgent.post(
        '/bee/save_template', data
    ).success(function(resp) {
        console.log(resp);
    });
};

function __clientConfig(httpAgent) {
    var client_config = {};

    httpAgent.get(
        "/bee/client_config"
    ).then(function(resp) {
        client_config = resp.data;
    });

    return client_config;
};
