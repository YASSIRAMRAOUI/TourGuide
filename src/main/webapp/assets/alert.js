function openDeleteReservation(reservationId) {
  const modal = document.getElementById("deleteModal");
  const confirmBtn = document.getElementById("deleteConfirmBtn");
  confirmBtn.href = "ReservationServlet?action=delete&id=" + reservationId;
  modal.classList.remove("hidden");
}

function openDeleteUser(userId) {
  const modal = document.getElementById("deleteModal");
  const confirmBtn = document.getElementById("deleteConfirmBtn");
  confirmBtn.href = "UserServlet?action=delete&id=" + userId;
  modal.classList.remove("hidden");
}

function openDeleteReview(reviewId) {
  const modal = document.getElementById("deleteModal");
  const confirmBtn = document.getElementById("deleteConfirmBtn");
  confirmBtn.href = "ReviewServlet?action=delete&id=" + reviewId;
  modal.classList.remove("hidden");
}

function openDeleteActivity(activityId) {
  document.getElementById("deleteModal").classList.remove("hidden");
  document.getElementById("deleteConfirmBtn").href =
    "ActivityServlet?action=delete&id=" + activityId;
}

function openDeleteTour(tourId) {
  const deleteModal = document.getElementById("deleteModal");
  const deleteConfirmBtn = document.getElementById("deleteConfirmBtn");
  deleteConfirmBtn.href = "TourServlet?action=delete&id=" + tourId;
  deleteModal.classList.remove("hidden");
}

function closeDeleteModal() {
  const modal = document.getElementById("deleteModal");
  modal.classList.add("hidden");
}

function toggleMenu() {
  const links = document.getElementById("navbar-links");
  links.classList.toggle("hidden");
}
