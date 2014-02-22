$(document).ready(function () {
    $.getJSON('beers.json', function (beers) {
       var beer_list = [];

        $.each(beers, function (index, beer) {
            beer_list.push('<li>' + beer['name'] + '</li>')
        });

        $('#beers').html('<ul>' + beer_list.join('') + '</ul>')
    });
});