$(document).ready(function () {
    $('#logoutButton').on('click', function () {
        // Redirect to the logout action
        var confirmLogout = confirm('Are you sure you want to logout?');
        
        if (confirmLogout) {         
            window.location.href = '/Home/Logout';
        }
    });
});