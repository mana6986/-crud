// ajaxHandler.js
export const ajaxRequest = ({ url, method, data, successCallback, errorCallback }) => {
    $.ajax({
        url,
        method,
        contentType: "application/json",
        data: JSON.stringify(data),
        success: successCallback,
        error: errorCallback
    });
};
