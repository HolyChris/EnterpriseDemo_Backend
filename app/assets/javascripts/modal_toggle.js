$(function() {
  $(".overlay-container").click(function(event) {
    event.preventDefault();
    console.log('clicked');
    var $modalContainer = $(this).closest('.portalModals');
    var $action = $modalContainer.find('.bg-overlay');

    if ($action.hasClass("closed")) {
      $action
        .removeClass("closed")
          .addClass("open");
    } else if ($action.hasClass("open")) {
      $action
        .removeClass("open")
          .addClass("closed");
    }
  });

  $(".close-modal").click(function(event) {
    event.preventDefault();

    var $modalContainer = $(this).closest('.portalModals');
    var $action = $modalContainer.find('.bg-overlay');

    $action
      .removeClass("open")
        .addClass("closed");
  });
});