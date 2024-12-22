jQuery(document).ready(function ($) {
    $('.select2').select2();
    $('.select2bs4').select2({
        theme: 'bootstrap4'
    })
    function calculateTotal() {
        // Get the values of Rate and Qty
        var rate = parseFloat($('#Rate').val()) || 0;
        var qty = parseFloat($('#Qty').val()) || 0;

        // Calculate total amount
        var totalAmount = rate * qty;

        // Set the calculated value into totalamount input field
        $('#totalamount').val(totalAmount.toFixed(2));
    }

    // Attach blur event to both Rate and Qty input fields
    $('#Rate, #Qty').on('blur', function () {
        calculateTotal();
    });
    $('.select2').on('change', function () {
        if ($(this).val() === null) {
            $(this).addClass('is-invalid');
        } else {
            $(this).removeClass('is-invalid');
        }
    });
    $('#Qty').on('input', function () {
        // Allow only numbers
        //$(this).val($(this).val().replace(/[^0-9]/g, ''));
        $(this).val($(this).val().replace(/[^0-9.]/g, '')      // Allow numbers and decimal points
            .replace(/(\..*?)\..*/g, '$1') // Allow only one decimal point
            .replace(/^(\d*\.\d{2}).*/, '$1')); // Restrict to two decimal places
    });
    $('#Rate').on('input', function () {
        // Allow only numbers
        //$(this).val($(this).val().replace(/[^0-9]/g, ''));
        $(this).val($(this).val().replace(/[^0-9.]/g, '')      // Allow numbers and decimal points
            .replace(/(\..*?)\..*/g, '$1') // Allow only one decimal point
            .replace(/^(\d*\.\d{2}).*/, '$1')); // Restrict to two decimal places
    });
    $(document).on('input', '.qtyInput', function () {
        //$(this).val($(this).val().replace(/[^0-9]/g, ''));
        $(this).val($(this).val().replace(/[^0-9.]/g, '')      // Allow numbers and decimal points
            .replace(/(\..*?)\..*/g, '$1') // Allow only one decimal point
            .replace(/^(\d*\.\d{2}).*/, '$1')); // Restrict to two decimal places
    });
    $('#btnsave').on('click', function () {
        var Billno = $("#billno").val();
        var Membid = $("#cmbrmember").val();
        var billdate = $("#txtEntryDate").val();
        var remarks = $("#rema").val();

        var MembName = $('#cmbrmember option:selected').text();
        var Ismem = $("input[name='membership']:checked").val();

        var totalamt = $("#lbltotalamt").text();
        // Get the payment type if applicable
        if (Ismem = "Yes") {
            var Ptype = $('#paymentType').val(); // Will return "Cash" or "Credit"
        }
        else {
            var Ptype = "Cash"; // Will return "Cash" or "Credit"
            MembName = remarks;
        }
        var products = [];

        // Loop through the rows in the product table and collect the data
        $('#productTable tbody tr').each(function () {
            var ItemName = $(this).find('td:eq(1)').text();  // Item name (second column)
            var Qty = $(this).find('td:eq(2)').text();  // Qty (third column, editable)
            var rate = $(this).find('td:eq(3)').text();  // Item name (second column)
            var amout = $(this).find('td:eq(4)').text();  // Item name (second column)
            var Itemid = $(this).find('td:eq(0)').text();  // Item name (second column)

            // Add the product data to the array
            products.push({
                ItemName: ItemName,
                Qty: Qty,
                rate: rate,
                amout: amout,
                Itemid: Itemid
            });
        });
        $.ajax({
            type: 'POST',
            url: '/Home/Addsale',
            data: { Billno: Billno, billdate: billdate, Membid: Membid, MembName: MembName, Ismem: Ismem, Ptype: Ptype, totalamt: totalamt, products: JSON.stringify(products) },
            success: function (result) {
                //var msg = "તમારો બીલ નંબર છે :- " + result.opmessage + "";
                //Swal.fire({
                //    title: "તમારો Order અમને મળી ગયો છે.",
                //    text: msg,
                //    icon: "success"
                //});
                var msg = "તમારો બીલ નંબર છે :- " + result.opmessage + "";
                Swal.fire({
                    title: "તમારો Order અમને મળી ગયો છે.",
                    text: msg,
                    icon: "success"
                }).then((result) => {
                    if (result.isConfirmed) {
                        //window.location.href = "/KhatarSale/Addsale"; // Replace with your target URL
                        window.location.href = '/Home/Dashboard';
                    }
                });
            },
            error: function (error) {
                // Handle the error response
                console.log(error);
            }
        });


    });

    // Click event for the Add Product button
    $('#addProduct').on('click', function () {
        // Get values from input fields
        var itemcode = $('#cmbritemname').val();
        var itemName = $('#cmbritemname option:selected').text();

        var qty = $('#Qty').val();
        var rate = $('#Rate').val();


        // Check if inputs are not empty
        if (itemName.trim() === '') {
            alert('કૃપા કરી વસ્તુ નું નામ નાખો');
            return;
        }
        if (qty.trim() === '') {
            alert('કૃપા કરી જથ્થો નાખો');
            return;
        }
        // Create a new table row with the input values
        var newRow = `
                <tr>
                    <td style="display:none">${itemcode}</td>
                    <td>${itemName}</td>
                   <td>
                        ${qty}
                    </td>
                    <td>
                       ${rate}
                    </td>
                    <td>
                        ${rate * qty} 
                    </td>
                    <td>
                        <button class="btn btn-danger btn-sm deleteRow">Delete</button>
                    </td>
                </tr>
            `;

        // Append the new row to the table body
        $('#productTable tbody').append(newRow);
        var total = 0;
        $('#productTable tbody tr').each(function () {
            var amount = parseFloat($(this).find('td:eq(4)').text()) || 0;  // Convert to number
            total += amount; // Add the number to total
        });
        $('#lbltotalamt').text(total.toFixed(2)); // Display total
        // Clear input fields
        $('#cmbritemname').val('');
        $('#Rate').val('');
        $('#Qty').val('');

    });

    // Click event for the Delete button inside the table
    $(document).on('click', '.deleteRow', function () {
        // Remove the row of the clicked button
        $(this).closest('tr').remove();
        var total = 0;
        $('#productTable tbody tr').each(function () {
            var amount = parseFloat($(this).find('td:eq(4)').text()) || 0;  // Convert to number
            total += amount; // Add the number to total
        });
        $('#lbltotalamt').text(total.toFixed(2)); 
    });
});

