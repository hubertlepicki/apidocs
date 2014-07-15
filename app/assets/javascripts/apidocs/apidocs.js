$(function () {
    $("#nav-button").click(function () {
        $.get(this.getAttribute("href"), function (data) {
            $("#main-content").html(data);
        });
        return false;
    });
    $('#search-input').fastLiveFilter('#search-list');
});