$(document).on("click", ".to-confirm", function() {
  $(this).closest(".confirmable").addClass("confirming");
});
$(document).on("click", ".cancel", function() {
  $(this).closest(".confirmable").removeClass("confirming");
});
