/**
 * What to include in your HTML/JSP page to utilize this function:
 * <ol>
 * 	<li>< script src="pictureUploadPreview.js">< /script></li>
 * 	<li>< img id="myImgId"></li> 
 * 	<li>< input type="file" onchange="previewPic(this, 'myImgId');"></li>
 * </ol>
 * https://stackoverflow.com/questions/12368910/html-display-image-after-selecting-filename
 * @param imgFile The file input DOM element to get the file from.
 * @param imgId The ID of the img tag to use a preview.
 */
function previewPic(imgFile, imgId) {
	if (imgFile.files && imgFile.files[0]) {
		let fr = new FileReader();
		fr.onload = function (e) {
			$('#'+imgId).attr('src', e.target.result)
		};
		fr.readAsDataURL(imgFile.files[0]);
	}
}