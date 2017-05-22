var fs = require("fs");
var http = require("http");
var email = require("emailjs");
var git = require("simple-git");

// This is where your email config goes.
var config = JSON.parse(fs.readFileSync("/etc/piadvanced/piholetweaks/piholeemail/config.json"));
var server = email.server.connect({
        user: config.user,
        password: config.password,
        host: config.host,
        ssl: config.ssl
});

// Get the current date
function today() {
     var date = new Date();
     var year = date.getFullYear();
     var month = date.getMonth() + 1;
     month = (month < 10 ? "0" : "") + month;
     var day = date.getDate();
     day = (day < 10 ? "0" : "") + day;
     return day + "/" + month + "/" + year;
 }

// HTTP GET external IP
http.get({'host': 'api.ipify.org', 'port': 80, 'path': '/'}, function(resp) {
  resp.on('data', function(ip) {
    console.log("My public IP address is: " + ip);
  });


http.get('https://api.ipify.org', (res) => {
     res.setEncoding('utf8');
     res.on('data', function (body) {
         var obj = JSON.parse(body);
         var summary = "Your external IP address changed on " + today() + "(D/M/Y). " +ip;

        // send the message itself
         server.send({
             text: summary,
             from: "Pi Bot <" + config.user  + ">",
             to: config.toname + " <" + config.toaddr + ">",
             subject: "Pi Bot ("+ today() +")"
         }, function (err, message) { console.log("Errors: " + err); });

     });
});
