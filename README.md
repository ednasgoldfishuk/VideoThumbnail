VideoThumbnail
================

A plugin to allow the selection of a thumbnail from a video source, the path to the video is supplied to the function and a base64 encoded image is returned to the javascript. the thumbnail is taken from the srubbers current position.

Example usage
=============
    thumbnailSuccess: function(imageData) {
        var smallImage = document.getElementById('myimage');
        smallImage.src = "data:image/jpeg;base64," + imageData;
    },
    thumbnailError: function(error) {
        console.log('error getting thumbnail')
    },
    getThumbnail: function() {
        window.VideoThumbnail.getThumbnail(thumbnailSuccess, thumbnailError, app.mediaPath);
    },
