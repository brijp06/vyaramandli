jQuery(document).ready(function ($) {

    Getdatagantri($("#txtEntryDate").val());
    //var productTable = new DataTable('#productTable');
    //productTable.column(0).visible(false);
    //productTable.clear().draw();
    $('#txtEntryDate').on('change', function () {
        var selectedDate = $(this).val();
        Getdatagantri(selectedDate);
    });

    function Getdatagantri(ddate) {
        var dateInput = new Date(ddate);

        var year = dateInput.getFullYear();
        var month = ("0" + (dateInput.getMonth() + 1)).slice(-2);  // Adding leading zero for month
        var day = ("0" + dateInput.getDate()).slice(-2);  // Adding leading zero for day
        var ddate = year + '/' + month + '/' + day;
        getgantri(ddate)
    }

    function getgantri(gantridate) {

        $.ajax({
            url: '/Home/getgantri?gantridate=' + gantridate,
            type: 'GET',
            contentType: 'application/json',
            success: function (result) {
                if (result) {
                    if (result.Message1 !== null) {
                        console.log('Message 1:', result.Message1);
                        $("#jantrion").text(result.Message1);
                    } else {
                        console.log('Message 1 is null');
                    }

                    if (result.Message2 !== null) {
                        console.log('Message 2:', result.Message2);
                        $("#jantrirate").text(result.Message2);
                    } else {
                        console.log('Message 2 is null');
                    }

                    if (result.Message4 !== null) {
                        $("#jantri1").text(result.Message4);
                    } else {
                        console.log('Message 2 is null');
                    }
                    if (result.Message5 !== null) {
                      
                        $("#jantri2").text(result.Message5);
                    } else {
                        console.log('Message 2 is null');
                    }
                    if (result.Message6 !== null) {
                        $("#jantri3").text(result.Message6);
                    } else {
                        console.log('Message 2 is null');
                    }

                    //const unwantedKeys = ['Dt', 'PrevDt', 'JantryOn', 'Rate', 'Increase', 'Decrease', 'entryID', 'CPU', 'UDt', 'UId'];

                    //const filteredArray = result.Message3.filter(item => !unwantedKeys.includes(item.Key));

                    //filteredArray.forEach(item => {
                    //    if (item && item.Key && item.Key.startsWith('Rate')) {
                    //        const rateValue = item.Key.replace('Rate', '');  // Extract the numeric part
                    //        //console.log(`${rateValue}: ${item.Value}`);
                    //        productTable.row.add([rateValue, item.Value
                    //        ]).draw(false);
                    //    }
                    //});
                    const unwantedKeys = ['Dt', 'PrevDt', 'JantryOn', 'Rate', 'Increase', 'Decrease', 'entryID', 'CPU', 'UDt', 'UId'];
                    //productTable.clear().draw();
                    // Assuming result.Message3 is an array of arrays, we need to access the first array
                    if (Array.isArray(result.Message3) && result.Message3.length > 0) {
                        const messageArray = result.Message3[0]; // Access the first inner array

                        const filteredArray = messageArray.filter(item => item && item.Key && !unwantedKeys.includes(item.Key));

                        //$.each(filteredArray, function (key, value) {
                        //    const rateValue = value.Key.replace('Rate', '');
                        //    $('#rateTable tbody').append('<tr><td>' + rateValue + '</td><td>' + value.Value + '</td></tr>');
                        //});
                        $('#rateTable tbody').empty();
                        for (var i = 0; i < filteredArray.length; i += 2) {
                            var value1 = filteredArray[i].Key;
                            var rate1 = filteredArray[i].Value;
                            var value2 = (i + 1 < filteredArray.length) ? filteredArray[i + 1].Key : "";
                            var rate2 = (i + 1 < filteredArray.length) ? filteredArray[i + 1].Value : "";
                            value1 = value1.replace('Rate', '');
                            value2 = value2.replace('Rate', '');
                            if (rate1 != 0 || rate2 != 0) {
                                var row = '<tr>';

                                // Check rate1
                                if (rate1 != 0) {
                                    row += '<td>' + value1 + '</td><td>' + rate1 + '</td>';
                                } else {
                                    // Leave cells empty if rate1 is 0
                                    //row += '<td></td><td></td>';
                                }

                                // Check rate2
                                if (rate2 != 0) {
                                    row += '<td>' + value2 + '</td><td>' + rate2 + '</td>';
                                } else {
                                    // Leave cells empty if rate2 is 0
                                    //row += '<td></td><td></td>';
                                }

                                row += '</tr>';
                                $('#rateTable tbody').append(row);
                            }
                            //$('#rateTable tbody').append('<tr><td>' + value1 + '</td><td>' + rate1 + '</td><td>' + value2 + '</td><td>' + rate2 + '</td></tr>');
                        }
                    } else {
                        //console.error('Invalid structure for result.Message3');
                        $('#rateTable tbody').empty();
                    }



                }

            },
            error: function (error) {
                console.error('Error:', error.responseText);
                // Handle the error here
            }
        });
    }
});

