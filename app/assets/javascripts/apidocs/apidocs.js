$(function () {
    $('.nav-button').click(function () {
        window.location.href = this.getAttribute("href") + '&search=' + $('#search-input').val();
        return false;
    });
    $('#search-input').fastLiveFilter('#search-list');
    $('#search-input').trigger('change');
});
