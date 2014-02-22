var BEERS = {};

BEERS.show = function() {
    var table = $("#beertable");

    $.each(BEERS.list, function(index, beer) {
        table.append('<tr><td>' + beer['name'] + '</td></tr>')
    });
};

BEERS.reverse = function() {
    BEERS.list.reverse();
};

$(document).ready(function () {



    $.getJSON('beers.json', function (beers) {
        BEERS.list = beers
        BEERS.show();
    });

    $("#reverse").click(function (e) {
        BEERS.reverse();
        BEERS.show();
        e.preventDefault();
    });
});