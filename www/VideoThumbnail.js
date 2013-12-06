
/**
 * Constructor.
 *
 */
function VideoThumbnail() {
    
};

/**
 * Checks if the Twitter SDK is loaded
 * @param {Function} response callback on result
 * @param {Number} response.response is 1 for success, 0 for failure
 * @example
 *      window.plugins.twitter.isTwitterAvailable(function (response) {
 *          console.log("twitter available? " + response);
 *      });
 */
VideoThumbnail.prototype.getThumbnail = function(successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }
    
    if (typeof errorCallback != "function") {
        console.log("getThumbnail error: failure parameter not a function");
        return;
    }
    
    if (typeof successCallback != "function") {
        console.log("getThumbnail error: success parameter not a function");
        return;
    }
    
    cordova.exec(successCallback, errorCallback, 'VideoThumbnail', 'getThumbnail', []);
};

module.exports = new VideoThumbnail();

