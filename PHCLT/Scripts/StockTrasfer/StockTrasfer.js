jQuery(document).ready(function ($) {
    $('#btnsave').on('click', function () {
        var Billno = $("#billno").val();
        var userid = $("#usermaster").val();
        var itemid = $("#cmbritemname").val();
        var billdate = $("#txtEntryDate").val();
        var qty = $("#Qty").val();
        var itemname = $('#cmbritemname option:selected').text();
        $.ajax({
            type: 'POST',
            url: '/TransferStock/Addstock',
            data: { Billno: Billno, billdate: billdate, userid: userid, itemid: itemid, itemname: itemname,qty:qty},
            success: function (result) {
                var msg = "તમારો Stock Trasfer નંબર છે :- " + result.opmessage + "";
                Swal.fire({
                    title: "તમારો Stock Trasfer ગયો છે.",
                    text: msg,
                    icon: "success"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = '/TransferStock/index';
                    }
                });
            },
            error: function (error) {
                // Handle the error response
                console.log(error);
            }
        });
    });
});