function public_ajax(url, method, data, successCallback, errorCallback, options) {
    let settings = {
        url: url,
        type: method.toUpperCase(),
        contentType: "application/json",
        processData: true,
        data: {},
        headers: {},
        beforeSend: function(xhr) {},
        complete: function(xhr, textStatus) {},
        ...options 
    };

    if (data instanceof FormData) {
        settings.contentType = false;
        settings.processData = false;
        settings.data = data;
    } else if (typeof data === 'object') {
        settings.data = JSON.stringify(data);
    } else {
        settings.data = data;
    }

    $.ajax(settings).done(function(result, textStatus, xhr) {
        if (typeof successCallback === 'function') {
            successCallback(result, textStatus, xhr);
        }
    }).fail(function(xhr, textStatus, errorThrown) {
        if (typeof errorCallback === 'function') {
            errorCallback(xhr, textStatus, errorThrown);
        } else {
            console.error("Error: " + textStatus + ": " + errorThrown);
        }
    });
}

