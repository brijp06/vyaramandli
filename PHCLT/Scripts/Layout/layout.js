$(document).ready(function () {
    $('#logoutButton').on('click', function () {
        // Redirect to the logout action
        var confirmLogout = confirm('Are you sure you want to logout?');
        
        if (confirmLogout) {         
            window.location.href = '/Home/Logout';
        }
    });
   

    function checkUserSubScription() {
        $.ajax({
            url: '/Home/CheckUserSubScription',
            type: 'GET',
            contentType: 'application/json',
            success: function (result) {
                if (result && result.UserSubdate) {
                    $('#spanSubDate').empty();
                    $('#spanSubDate').text(` (Subscription Till : ${result.UserSubdate} )`);
                }
                else {
                    Swal.fire({
                        title: "Expired",
                        text: `Your Subscription has been expired, please Subscribe again to use this Portal`,
                        icon: "error"
                    }).then((result) => {
                        window.location.href = '/Home/Logout';
                    });
                }
            },
            error: function (error) {
                $("#loader").hide();
                console.error('Error:', error.responseText);
            }
        });
    }

    //checkUserSubScription();
});