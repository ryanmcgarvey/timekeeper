$(document).ready(function() {
  $("[data-presents='add_html']").click(function(e) {
    e.preventDefault();
    var $button = $(this);
    var html = $button.data("html");
    var target = $($button.data("target"));
    target.append(html);
  })
})
