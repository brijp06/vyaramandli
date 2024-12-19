$(document).ready(function () {


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
    }

});