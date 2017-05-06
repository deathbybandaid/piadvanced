var fs = require("fs");
var http = require("http");
var email = require("emailjs");
var git = require("simple-git");

//
var options = {
  host: 'localhost',
  port: 8679,
};

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

// HTTP GET stats from localhost
http.get('http://localhost/admin/api.php', (res) => {
     res.setEncoding('utf8');
     res.on('data', function (body) {
         var obj = JSON.parse(body);
         var summary = "This is your Pi Hole summary for " + today() + "(D/M/Y).\n\nDomains being blocked: " +
         obj.domains_being_blocked + "\nDNS queries today: " + obj.dns_queries_today + "\nAds blocked today: " +
         obj.ads_blocked_today + "\nAds to total queries: " + obj.ads_percentage_today;

        // send the message itself
         server.send({
             text: summary,
             from: "Pi Hole Bot <" + config.user  + ">",
             to: config.toname + " <" + config.toaddr + ">",
             subject: "Pi Hole Summary ("+ today() +")"
         }, function (err, message) { console.log("Errors: " + err); });

     });
});

// Update from the Git repository
//git().pull("https://github.com/MilesGG/pi-hole-summary.git", "master");
