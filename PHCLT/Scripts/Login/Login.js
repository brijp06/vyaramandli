$(document).ready(function () {
    var usname = localStorage.getItem("uname");
    var upassword = localStorage.getItem("upassword");

    if (usname != "") {
        $('#txtuserid').val(usname)
    }

    if (upassword != "") {
        $('#txtpass').val(upassword)
    }
   

    function getUrlParameter(name) {
        var urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(name);
    }

    // Check if the URL has the "isAuth" parameter
    var isAuthValue = getUrlParameter('isAuth');

    if (isAuthValue !== null) {                

        // Example: Show an alert based on the isAuth value
        if (isAuthValue === 'false') {
            Swal.fire({
                icon: "error",
                title: "Oops... Username or Passowrd is Incorrent",
            });
        }
        else {
           

        }
    }
    $("#btnsave").click(function () {
        var usname = $('#txtuserid').val();
        var upassword = $('#txtpass').val();


        $.ajax({
            url: '/Home/verify', // Replace with your actual API endpoint
            data: { Username: usname, Password: upassword }, // Change this line
            method: 'GET',
            dataType: 'json',
            success: function (result) {
                var isChecked = $('#chkRemember').prop('checked');
                if (isChecked) {
                    localStorage.setItem("uname", usname);
                    localStorage.setItem("upassword", upassword)
                } else {

                }
                window.location.href = '/home/Dashboard';
               
            },
            error: function (error) {
                // Handle the error response
                console.log(error);
            }
        });
    });

});